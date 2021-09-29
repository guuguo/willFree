import 'package:free/bean/entity/article_entity.dart';
import 'package:free/bean/entity/a_entity.dart';
import 'package:free/generated/json/base/json_filed.dart';

articleEntityFromJson(ArticleEntity data, Map<String, dynamic> json) {
	if (json['file'] != null) {
		data.file = json['file'].toString();
	}
	if (json['title'] != null) {
		data.title = json['title'].toString();
	}
	if (json['content'] != null) {
		data.content = json['content'].toString();
	}
	if (json['user'] != null) {
		data.user = UserEntity().fromJson(json['user']);
	}
	if (json['objectId'] != null) {
		data.objectId = json['objectId'].toString();
	}
	if(json['createdAt'] != null){
		data.createdAt = DateTime.parse(json['createdAt']);
	}
	if(json['updatedAt'] != null){
		data.updatedAt = DateTime.parse(json['updatedAt']);
	}
	if (json['tags'] != null) {
		data.tags = (json['tags'] as List).map((v) => v.toString()).toList().cast<String>();
	}
	return data;
}

Map<String, dynamic> articleEntityToJson(ArticleEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['file'] = entity.file;
	data['title'] = entity.title;
	data['content'] = entity.content;
	data['user'] = entity.user?.toJson();
	data['objectId'] = entity.objectId;
	data['createdAt'] = entity.createdAt;
	data['updatedAt'] = entity.updatedAt;
	data['tags'] = entity.tags;
	return data;
}