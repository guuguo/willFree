import 'package:free/bean/entity/article_entity.dart';
import 'package:free/bean/entity/a_entity.dart';
import 'package:free/bean/res_bean.dart';
import 'package:free/net/dio_helper.dart';

const int pageLimited = 20;

class NetRepository {
  static Future<ResListBean<ArticleEntity>> getArticle() async {
    var res = await DioHelper.get().fetch("/classes/Article", params: {"include": "user","order":"-createdAt","keys":"-content"});
    var list = ResListBean<ArticleEntity>.fromJsonMap(res as Map<String, dynamic>);
    return list;
  }
  static Future<ArticleEntity> getArticleDetail(String? id) async {
    var res = await DioHelper.get().fetch("/classes/Article/$id", params: {"keys":"content"});
    var article = ArticleEntity().fromJson(res as Map<String, dynamic>);
    return article;
  }

  static Future deleteArticle(ArticleEntity articleEntity) async {
    await DioHelper.get().fetch("/classes/Article/${articleEntity.objectId}", method: NetMethod.delete);
  }

  static Future<ArticleEntity> upArticle(ArticleEntity article) async {
    Map<String, dynamic> data = article.toJson();
    data.removeWhere((key, value) => value == null);
    data = {
      "title": article.title,
      "content": article.content,
      "user": {"__type": "Pointer", "className": "_User", "objectId": article.user?.objectId}
    };
    var res = await DioHelper.get().fetch(
      "/classes/Article" + (article.objectId != null ? "/${article.objectId}" : ""),
      params: data,
      method: article.objectId != null ? NetMethod.put : NetMethod.post,
    );

    var entity = ArticleEntity().fromJson(res as Map<String, dynamic>);
    return entity;
  }

  static Future<UserEntity?> loginWithTourist() async {
    return login(username: "tourist", password: "123");
  }

  static Future<UserEntity?> login({
    String username = "tourist",
    String password = "123",
  }) async {
    final data = {
      'username': username,
      'password': password,
    };
    var res = await DioHelper.get()!.fetch('/login', params: data, method: NetMethod.post);
    var entity = UserEntity().fromJson(res as Map<String, dynamic>);
    return entity;
  }

  static Future<ResListBean<RoleEntity>> getRoles(UserEntity user) async {
    final data = {
      'where': {
        "users": {"__type": "Pointer", "className": "_User", "objectId": user.objectId}
      },
    };
    var res = await DioHelper.get().fetch('/roles', params: data, method: NetMethod.get);
    var entity = ResListBean<RoleEntity>.fromJsonMap(res as Map<String, dynamic>);
    return entity;
  }
}
