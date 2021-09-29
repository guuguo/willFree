import 'package:free/generated/json/base/json_convert_content.dart';

class RoleEntity with JsonConvert<RoleEntity> {
  String? name;
  String? createdAt;
  String? updatedAt;
  String? objectId;

  bool isAdmin() => name == "admin";

}
