import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free/page/home/model.dart';
import 'package:free/page/home/view/NationnalDebt.dart';
import 'package:free/page/home/view/PE.dart';
import 'package:free/page/home/view/Stock.dart';
import 'package:free/page/view/card.dart';
import 'package:free/theme/bg.dart';
import 'package:free/widget/state_view/state_view.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // HomeModel? model =;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(gradient: MyGradient.bgScaffold(context)),
        child: ChangeNotifierProvider(
          create: (c) => HomeModel(),
          builder: (c, chi) => Consumer<HomeModel>(
              builder: (ctx, v, c) => StateView(
                  state: v.widgetState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NationnalDebt(),
                      PE(),
                      ...v.stocks.map((e) =>Stock(stock: e)),
                      addButton(),
                    ],
                  ))),
        ),
      ),
    ));
  }

  Widget addButton() {
    return MainCard(
      child: Container(child: Icon(Icons.add)),
    );
  }

  ///获取主页列表
  Widget buildContent([int footerCount = 0]) {
    return Container(
        constraints: BoxConstraints.tightFor(width: 800),
        child: Consumer<HomeModel>(builder: (context, value, child) {
          return Text((value.nationNalDebtRatio).toString());
        }));
  }

  ///空布局
  Widget buildEmpty() {
    return Center(child: Text("没有找到数据"));
  }

  Widget buildLoading() {
    return Container(
        padding: EdgeInsets.only(bottom: 40, top: 20),
        child: CupertinoActivityIndicator());
  }
}

class TagItem {
  Color color;
  String tag;

  TagItem(this.tag, this.color);
}
