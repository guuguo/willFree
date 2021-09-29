import 'package:free/bean/entity/a_entity.dart';
import 'package:free/generated/json/base/json_convert_content.dart';
import 'package:free/generated/json/base/json_filed.dart';

class ArticleEntity with JsonConvert<ArticleEntity> {
	String? file;
	String? title;
	String? content;
	UserEntity? user;
	String? objectId;
	DateTime? createdAt;
	DateTime? updatedAt;
	List<String>? tags;
}
