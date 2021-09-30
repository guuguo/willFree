import 'package:flutter/cupertino.dart';
import 'package:free/bean/entity/article_entity.dart';
import 'package:free/bean/res_bean.dart';
import 'package:free/repository/net_repository.dart';
import 'package:free/utils/developer.dart';
import 'package:intl/intl.dart';

class HomeModel extends ChangeNotifier {
  double nationNalDebtRatio=0;

  HomeModel() {
    getDebt();
  }

  var loading=false;
  Future getDebt() async {
    loading=true;
    notifyListeners();
    try {
      final currentDate= DateFormat('yyyy-MM-dd').format(DateTime.now());
      dynamic res = await NetRepository.getNationNalDebtRatio(currentDate);
      loading=false;
    } catch (e) {
      debug(e);
    }
    notifyListeners();
  }
}
