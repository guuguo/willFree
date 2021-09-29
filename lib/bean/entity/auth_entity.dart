import 'package:free/generated/json/base/json_convert_content.dart';

///AuthBean
class AuthEntity with JsonConvert<AuthEntity> {
  ///openid
  String? openid;

  ///accessToken
  String? accessToken;

  ///expiresIn 到期时间
  int? expiresIn;

  AuthEntity({this.openid, this.accessToken, this.expiresIn});
}
