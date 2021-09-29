import 'package:free/bean/entity/a_entity.dart';
import 'package:free/generated/json/base/json_convert_content.dart';

/// Make sure that `part` is specified, even before launching the builder

class UserEntity with JsonConvert<UserEntity> {
  ///用户认证信息
  String? sessionToken;
  DateTime? updatedAt;
  String? objectId;

  ///用户个性签名
  String? signature;

  ///用户名
  String? username;
  DateTime? createdAt;
  String? className;

  ///头像
  String? avatar;

  ///邮箱认证开启
  bool? emailVerified;

  ///昵称
  String? nickName;

  ///手机认证开启
  bool? mobilePhoneVerified;

  ///默认是否公开日记
  bool? defaultPublic;

  ///性别 -1,null未设置 0女 1男
  int? gender;

  ///认证信息 Map<String,AuthBean>
  AuthMapEntity? authData;

  UserEntity(
      {
      this.sessionToken,
      this.updatedAt,
      this.objectId,
      this.signature,
      this.username,
      this.createdAt,
      this.className,
      this.avatar,
      this.emailVerified,
      this.nickName,
      this.mobilePhoneVerified,
      this.defaultPublic,
      this.gender,
      this.authData});

  @override
  UserEntity copyWith(
      {String? sessionToken,
      String? signature,
      String? username,
      String? nickName,
      String? avatar,
      String? emailVerified,
      String? defaultPublic,
      String? mobilePhoneVerified,
      String? gender,
      String? objectId,
      DateTime? createdAt,
      DateTime? updatedAt,
      UserEntity? defaultConfig}) {
    return UserEntity(
      sessionToken: sessionToken ?? this.sessionToken,
      signature: signature ?? this.signature,
      username: username ?? this.username,
      nickName: nickName ?? this.nickName,
      avatar: avatar ?? this.avatar,
      emailVerified: emailVerified as bool? ?? this.emailVerified,
      defaultPublic: defaultPublic as bool? ?? this.defaultPublic,
      mobilePhoneVerified: mobilePhoneVerified as bool? ?? this.mobilePhoneVerified,
      gender: gender as int? ?? this.gender,
      objectId: objectId ?? this.objectId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  ///获取展示用的名字[nickName] 为空则展示用户名
  String? showName() => nickName ?? username;
}
