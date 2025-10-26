import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:auth_test/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model with Freezed for immutability and JSON serialization
@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String email,
  }) = _UserModel;

  /// Convert from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convert to User entity
  User toEntity() {
    return User(email: email);
  }

  /// Create from User entity
  factory UserModel.fromEntity(User user) {
    return UserModel(email: user.email);
  }
}
