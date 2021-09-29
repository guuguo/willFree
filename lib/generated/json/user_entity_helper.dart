import 'package:free/bean/entity/user_entity.dart';
import 'package:free/bean/entity/a_entity.dart';

userEntityFromJson(UserEntity data, Map<String, dynamic> json) {
	if (json['sessionToken'] != null) {
		data.sessionToken = json['sessionToken'].toString();
	}
	if(json['updatedAt'] != null){
		data.updatedAt = DateTime.parse(json['updatedAt']);
	}
	if (json['objectId'] != null) {
		data.objectId = json['objectId'].toString();
	}
	if (json['signature'] != null) {
		data.signature = json['signature'].toString();
	}
	if (json['username'] != null) {
		data.username = json['username'].toString();
	}
	if(json['createdAt'] != null){
		data.createdAt = DateTime.parse(json['createdAt']);
	}
	if (json['className'] != null) {
		data.className = json['className'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['emailVerified'] != null) {
		data.emailVerified = json['emailVerified'];
	}
	if (json['nickName'] != null) {
		data.nickName = json['nickName'].toString();
	}
	if (json['mobilePhoneVerified'] != null) {
		data.mobilePhoneVerified = json['mobilePhoneVerified'];
	}
	if (json['defaultPublic'] != null) {
		data.defaultPublic = json['defaultPublic'];
	}
	if (json['gender'] != null) {
		data.gender = json['gender'] is String
				? int.tryParse(json['gender'])
				: json['gender'].toInt();
	}
	if (json['authData'] != null) {
		data.authData = AuthMapEntity().fromJson(json['authData']);
	}
	return data;
}

Map<String, dynamic> userEntityToJson(UserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sessionToken'] = entity.sessionToken;
	data['updatedAt'] = entity.updatedAt;
	data['objectId'] = entity.objectId;
	data['signature'] = entity.signature;
	data['username'] = entity.username;
	data['createdAt'] = entity.createdAt;
	data['className'] = entity.className;
	data['avatar'] = entity.avatar;
	data['emailVerified'] = entity.emailVerified;
	data['nickName'] = entity.nickName;
	data['mobilePhoneVerified'] = entity.mobilePhoneVerified;
	data['defaultPublic'] = entity.defaultPublic;
	data['gender'] = entity.gender;
	data['authData'] = entity.authData?.toJson();
	return data;
}