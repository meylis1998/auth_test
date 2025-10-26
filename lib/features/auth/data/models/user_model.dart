import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:auth_test/features/auth/domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() {
    return User(email: email);
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(email: user.email);
  }
}
