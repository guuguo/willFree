import 'package:free/bean/entity/a_entity.dart';
import 'package:free/bean/entity/auth_entity.dart';
import 'package:free/generated/json/base/json_convert_content.dart';


///AuthBean
class AuthMapEntity with JsonConvert<AuthMapEntity> {
  AuthEntity? qq;
  AuthEntity? wechat;
}
