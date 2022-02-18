import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:free/bean/debt_bean.dart';
import 'package:free/bean/pe_bean.dart';
import 'package:free/bean/stock_bean.dart';
import 'package:free/net/dio_helper.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

const int pageLimited = 20;

class NetRepository {
  ///获取十年期国债收益率 [date] 日期2021-09-29
  static Future<Map<double,double>?> getNationNalDebtRatio(String date) async {
    var res = await DioHelper.instance().dioFetch<Map<String,dynamic>>(
      RequestOptions(
        path: "https://yield.chinabond.com.cn/cbweb-czb-web/czb/czbChartSearch",
        method: "post",
      ),
    );
    var result=Map<double,double>();
    res.data?['seriesData'].forEach((e){
      result[e[0]]=e[1];
    });
    return result;
  }

  ///获取深证平均市盈率
  static Future<List<PEBean>?> getPE() async {
    var res = await DioHelper.dio
        .get<String>("https://legulegu.com/stockdata/shenzhenPE");
    var document = htmlparser.parse(res.data);
    final peDomList = document.querySelector("#peTBody")?.querySelectorAll("tr");
    return peDomList?.map((element) {
      var bean=PEBean();
      var tds=element.querySelectorAll("td");
      bean.pe=double.tryParse(tds[1].text);
      bean.time=tds[0].text;
      bean.percent=tds[3].text;
      return bean;
    }).toList();
  }
  ///获取股票信息
  static Future<StockBean?> getStockFinance(String code) async {
    var res = await DioHelper.dio
        .get<String>("http://stockpage.10jqka.com.cn/${code}/finance/");
    try {
      var bean = StockBean();
      var document = htmlparser.parse(res.data);
      final headerDom = document.querySelector(".m_header");
      bean.code = code;
      bean.name = headerDom
          ?.querySelector("strong")
          ?.attributes["stockname"] ?? "";

      return bean;
    }catch (e) {
      return null;
    }
  }  ///获取价格信息
  static Future<StockPrice?> getStockPrice(String code) async {
    var res = await DioHelper.dio
        .get<String>("https://d.10jqka.com.cn/v2/realhead/hs_${code}/last.js");
    try {
      var bean = StockPrice();
      RegExpMatch? resJson=RegExp(r"{.*}").firstMatch(res.data??"");
      var map=json.decode(resJson?.group(0)??"")["items"];

      bean.currentPrice=double.parse(map['10']);
      bean.pricePlus=map['199112']+"%";
      bean.code=map["5"];
      bean.name=map['name'];
      bean.ttm=double.parse(map['2034120']);
      print(bean);
      return bean;
    }catch (e) {
      return null;
    }
  }
}
