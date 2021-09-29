import 'package:free/bean/entity/role_entity.dart';

roleEntityFromJson(RoleEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'].toString();
	}
	if (json['createdAt'] != null) {
		data.createdAt = json['createdAt'].toString();
	}
	if (json['updatedAt'] != null) {
		data.updatedAt = json['updatedAt'].toString();
	}
	if (json['objectId'] != null) {
		data.objectId = json['objectId'].toString();
	}
	return data;
}

Map<String, dynamic> roleEntityToJson(RoleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['objectId'] = entity.objectId;
	return data;
}