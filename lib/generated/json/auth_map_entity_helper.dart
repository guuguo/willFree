import 'package:free/bean/entity/auth_map_entity.dart';
import 'package:free/bean/entity/a_entity.dart';
import 'package:free/bean/entity/auth_entity.dart';

authMapEntityFromJson(AuthMapEntity data, Map<String, dynamic> json) {
	if (json['qq'] != null) {
		data.qq = AuthEntity().fromJson(json['qq']);
	}
	if (json['wechat'] != null) {
		data.wechat = AuthEntity().fromJson(json['wechat']);
	}
	return data;
}

Map<String, dynamic> authMapEntityToJson(AuthMapEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['qq'] = entity.qq?.toJson();
	data['wechat'] = entity.wechat?.toJson();
	return data;
}