import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  WebSocketChannel? _channel;
  Timer? _pingTimer;
  final Map<String, bool> _moduleConnectionStatus = {};
  final StreamController<Map<String, bool>> _connectionStatusController =
      StreamController<Map<String, bool>>.broadcast();

  Stream<Map<String, bool>> get connectionStatusStream =>
      _connectionStatusController.stream;

  bool get isConnected => _channel != null;

  Future<void> connect(String baseUrl) async {
    try {
      final wsUrl = baseUrl
          .replaceFirst('http', 'ws')
          .replaceFirst('https', 'wss');
      _channel = WebSocketChannel.connect(Uri.parse('$wsUrl/ws'));

      // Listen for messages
      _channel!.stream.listen(
        _handleMessage,
        onDone: _handleDisconnection,
        onError: _handleError,
      );

      // Start ping timer
      _startPingTimer();
    } catch (e) {
      print('WebSocket connection failed: $e');
    }
  }

  void _handleMessage(dynamic message) {
    try {
      final data = json.decode(message);

      switch (data['type']) {
        case 'pong':
          // Keep connection alive
          break;
        case 'module-status-update':
          _updateModuleStatus(data['moduleId'], data['isConnected']);
          break;
        case 'connection-status':
          if (data['connectedModules'] != null) {
            _updateAllModuleStatuses(data['connectedModules']);
          }
          break;
      }
    } catch (e) {
      print('Error parsing WebSocket message: $e');
    }
  }

  void _handleDisconnection() {
    _cleanup();
    // Attempt reconnection after 5 seconds
    Timer(const Duration(seconds: 5), () {
      if (_channel == null) {
        // Reconnect logic would go here
      }
    });
  }

  void _handleError(dynamic error) {
    print('WebSocket error: $error');
    _cleanup();
  }

  void _startPingTimer() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _sendPing();
    });
  }

  void _sendPing() {
    if (_channel != null) {
      try {
        _channel!.sink.add(
          json.encode({
            'type': 'ping',
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          }),
        );
      } catch (e) {
        print('Failed to send ping: $e');
      }
    }
  }

  void _updateModuleStatus(String moduleId, bool isConnected) {
    _moduleConnectionStatus[moduleId] = isConnected;
    _connectionStatusController.add(Map.from(_moduleConnectionStatus));
  }

  void _updateAllModuleStatuses(List<dynamic> connectedModules) {
    _moduleConnectionStatus.clear();
    for (String moduleId in connectedModules) {
      _moduleConnectionStatus[moduleId] = true;
    }
    _connectionStatusController.add(Map.from(_moduleConnectionStatus));
  }

  bool getModuleConnectionStatus(String moduleId) {
    return _moduleConnectionStatus[moduleId] ?? false;
  }

  void requestConnectionStatus() {
    if (_channel != null) {
      try {
        _channel!.sink.add(
          json.encode({
            'type': 'get-connection-status',
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          }),
        );
      } catch (e) {
        print('Failed to request connection status: $e');
      }
    }
  }

  void _cleanup() {
    _pingTimer?.cancel();
    _pingTimer = null;
    _channel?.sink.close(status.goingAway);
    _channel = null;

    // Mark all modules as disconnected
    for (String moduleId in _moduleConnectionStatus.keys) {
      _moduleConnectionStatus[moduleId] = false;
    }
    _connectionStatusController.add(Map.from(_moduleConnectionStatus));
  }

  void disconnect() {
    _cleanup();
  }

  void dispose() {
    _cleanup();
    _connectionStatusController.close();
  }
}
