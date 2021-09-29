import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:free/bean/entity/article_entity.dart';
import 'package:free/bean/res_bean.dart';
import 'package:free/global/global_model.dart';
import 'package:free/net/dio_helper.dart';
import 'package:free/repository/net_repository.dart';
import 'package:free/utils/developer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class UploadModel extends ChangeNotifier {
  UploadModel({ArticleEntity? articleEntity}) {
    if (articleEntity != null) this.articleEntity = articleEntity;
  }

  ArticleEntity articleEntity = ArticleEntity();

  String? checkArticleValid() {
    if (articleEntity.title?.isEmpty ?? true) return "标题不能为空";
    if (articleEntity.content?.isEmpty ?? true) return "内容不能为空";
    return null;
  }

  Future dealReplaceUrl() async {
    //正则获取文章中的图片所有链接
    final images = await _checkContentImgUrl();
    //遍历处理图片
    for (var imgUrl in images) {
      if (imgUrl?.isNotEmpty != true) continue;
      //分割链接获取文件名
      final name = path.split(imgUrl!.split('?').first).last;
      //下载图片文件 到本地缓存文件夹
      String filePath = await DioHelper.getSaveCachePath(fileName: name);
      debug("filePath" + filePath);
      if (!await File(filePath).exists()) {
        await DioHelper.get().download(imgUrl, savePath: filePath);
      }
      //上传图片文件到oss
      var url = await DioHelper.get().uploadToOss(File(filePath));
      //替换图片链接成自己的
      articleEntity.content = articleEntity.content!.replaceFirst(imgUrl, url);
    }
  }

  Future uploadArticle() async {
    articleEntity.user = GlobalModel.get()?.user;
    await NetRepository.upArticle(articleEntity);
  }

  Future<List<String?>> _checkContentImgUrl() async {
    final content = articleEntity.content ?? "";
    RegExp exp = new RegExp(r"(?<=!\[.+\]\()https?.+?(?=\))");
    final matches = exp.allMatches(content);
    return matches.map((element) => element.group(0)).skipWhile((value) => value!.startsWith("https://guuguohome")).toList();
  }
}
