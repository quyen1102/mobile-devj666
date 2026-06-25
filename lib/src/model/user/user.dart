import 'package:deep_pick/deep_pick.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nf_base/src/model/common/id.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@Freezed(fromJson: true, toJson: true)
sealed class LightUser with _$LightUser {
  const factory LightUser({
    required UserId id,
    required String name,
    String? email,
  }) = _LightUser;

  factory LightUser.fromJson(Map<String, dynamic> json) => _$LightUserFromJson(json);
}

@Freezed(fromJson: true, toJson: true)
sealed class User with _$User {
  const User._();

  const factory User({
    required UserId id,
    required String username,
    String? email,
    String? firstName,
    String? lastName,
  }) = _User;

  LightUser get lightUser => LightUser(id: id, name: username, email: email);

  String get initials =>
      firstName != null && lastName != null
          ? '${firstName![0]}${lastName![0]}'.toUpperCase()
          : username[0].toUpperCase();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  factory User.fromServerJson(Map<String, dynamic> json) => User.fromJson(json);
}

extension PickLightUser on Pick {
  LightUser asLightUserOrThrow() {
    final map = this.required().asMapOrThrow().cast<String, dynamic>();
    return LightUser.fromJson(map);
  }

  LightUser? asLightUserOrNull() {
    if (value == null) return null;
    try {
      return asLightUserOrThrow();
    } catch (_) {
      return null;
    }
  }
}

