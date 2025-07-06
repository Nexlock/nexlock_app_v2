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

      print('Attempting to connect to WebSocket: $wsUrl/ws');
      _channel = WebSocketChannel.connect(Uri.parse('$wsUrl/ws'));

      // Listen for messages
      _channel!.stream.listen(
        _handleMessage,
        onDone: _handleDisconnection,
        onError: _handleError,
      );

      // Start ping timer and request initial status
      _startPingTimer();

      // Request connection status after a short delay to ensure connection is established
      Timer(const Duration(seconds: 1), () {
        requestConnectionStatus();
      });

      print('WebSocket connected successfully');
    } catch (e) {
      print('WebSocket connection failed: $e');
      print('Make sure your server is running and accessible at: $baseUrl');
      rethrow;
    }
  }

  void _handleMessage(dynamic message) {
    try {
      final data = json.decode(message);
      print('WebSocket received: $data');

      switch (data['type']) {
        case 'pong':
          // Keep connection alive
          break;
        case 'connection-acknowledged':
          // Module acknowledged connection
          print('Connection acknowledged: ${data['message']}');
          break;
        case 'module-registered':
          // Module registered successfully
          if (data['moduleId'] != null) {
            _updateModuleStatus(data['moduleId'], true);
          }
          break;
        case 'status-received':
          // Status was received by server
          break;
        case 'module-status-update':
          // Handle module status updates
          if (data['moduleId'] != null && data['isConnected'] != null) {
            _updateModuleStatus(data['moduleId'], data['isConnected']);
          }
          break;
        case 'connection-status-response':
          // Handle connection status response
          if (data['connectedModules'] != null) {
            _updateAllModuleStatuses(
              List<String>.from(data['connectedModules']),
            );
          }
          break;
        default:
          print('Unknown WebSocket message type: ${data['type']}');
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

  void _updateAllModuleStatuses(List<String> connectedModules) {
    // Clear previous status
    _moduleConnectionStatus.clear();

    // Mark connected modules as online
    for (String moduleId in connectedModules) {
      _moduleConnectionStatus[moduleId] = true;
    }

    print('Updated module statuses: $_moduleConnectionStatus');
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
        print('Requested connection status from server');
      } catch (e) {
        print('Failed to request connection status: $e');
      }
    }
  }

  void requestModuleStatus(String moduleId) {
    if (_channel != null) {
      try {
        _channel!.sink.add(
          json.encode({
            'type': 'get-module-status',
            'moduleId': moduleId,
            'timestamp': DateTime.now().millisecondsSinceEpoch,
          }),
        );
        print('Requested status for module: $moduleId');
      } catch (e) {
        print('Failed to request module status: $e');
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
