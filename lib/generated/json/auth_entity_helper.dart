import 'package:free/bean/entity/auth_entity.dart';

authEntityFromJson(AuthEntity data, Map<String, dynamic> json) {
	if (json['openid'] != null) {
		data.openid = json['openid'].toString();
	}
	if (json['accessToken'] != null) {
		data.accessToken = json['accessToken'].toString();
	}
	if (json['expiresIn'] != null) {
		data.expiresIn = json['expiresIn'] is String
				? int.tryParse(json['expiresIn'])
				: json['expiresIn'].toInt();
	}
	return data;
}

Map<String, dynamic> authEntityToJson(AuthEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['openid'] = entity.openid;
	data['accessToken'] = entity.accessToken;
	data['expiresIn'] = entity.expiresIn;
	return data;
}