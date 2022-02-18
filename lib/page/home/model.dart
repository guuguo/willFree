import 'package:flutter/cupertino.dart';
import 'package:free/bean/stock_bean.dart';
import 'package:free/repository/net_repository.dart';
import 'package:free/utils/developer.dart';
import 'package:free/widget/state_view/state_view.dart';
import 'package:intl/intl.dart';

import '../../bean/pe_bean.dart';

class HomeModel extends ChangeNotifier {
  double nationNalDebtRatio = 0;
  PEBean? todayPE;

  List<StockBean> stocks = [];

  var initStock = ["603587", "600566"];

  HomeModel() {
    initLoading();
  }

  WidgetState widgetState = WidgetState.loading;

  initLoading() async {
    widgetState = WidgetState.loading;
    notifyListeners();
    await Future.wait([
      getDebt(),
      getPE(),
      getStockInfos(),
    ]);
    widgetState = WidgetState.content;
    notifyListeners();
  }

  Future getPE() async {
    try {
      final res = await NetRepository.getPE();
      if (res == null) {
        notifyListeners();
        return;
      }
      todayPE = res[0];
    } catch (e) {
      debug(e);
    }
  }

  Future getDebt() async {
    try {
      final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final res = await NetRepository.getNationNalDebtRatio(currentDate);
      if (res == null) {
        return;
      }
      nationNalDebtRatio = res[10] ?? 0;
    } catch (e) {
      debug(e);
    }
  }

  Future getStockInfos() async {
    try {
      for (var code in initStock) {
        final stock = await NetRepository.getStockFinance(code);
        if (stock == null) {
          continue;
        }
        final price = await NetRepository.getStockPrice(code);
        stock.priceDetail = price;
        stocks.add(stock);
      }
    } catch (e) {
      debug(e);
    }
  }
}
