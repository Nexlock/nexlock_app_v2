import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_jwt_model.freezed.dart';
part 'user_jwt_model.g.dart';

@freezed
sealed class UserJwtModel with _$UserJwtModel {
  const factory UserJwtModel({
    required String id,
    required String email,
    required String name,
  }) = _UserJwtModel;

  factory UserJwtModel.fromJson(Map<String, dynamic> json) =>
      _$UserJwtModelFromJson(json);
}
