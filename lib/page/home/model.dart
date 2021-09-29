import 'package:flutter/cupertino.dart';
import 'package:free/bean/entity/article_entity.dart';
import 'package:free/bean/res_bean.dart';
import 'package:free/repository/net_repository.dart';
import 'package:free/utils/developer.dart';

class HomeModel extends ChangeNotifier {
  List<ArticleEntity> list = [];

  HomeModel() {
    refresh();
  }

  var loading=false;
  Future refresh() async {
    loading=true;
    notifyListeners();
    try {
      ResListBean<ArticleEntity> res = await NetRepository.getArticle();
      loading=false;
      list = res.results;
    } catch (e) {
      debug(e);
    }
    notifyListeners();
  }
  Future delete(ArticleEntity article) async {
    try {
      await NetRepository.deleteArticle(article);
      list.remove(article);
    } catch (e) {
      debug(e);
    }
    notifyListeners();
  }
}
