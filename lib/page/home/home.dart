import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free/bean/entity/article_entity.dart';
import 'package:free/global/global_model.dart';
import 'package:free/page/home/model.dart';
import 'package:free/page/home/view/banner.dart';
import 'package:free/page/home/view/foot.dart';
import 'package:free/page/home/view/profile.dart';
import 'package:free/theme/bg.dart';
import 'package:free/utils/date.dart';
import 'package:free/widget/container.dart';
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
        body: Container(
      decoration: BoxDecoration(gradient: MyGradient.bgScaffold(context)),
      child: ChangeNotifierProvider(
          create: (c) => HomeModel(),
          builder: (c, chi) => Center(
                child: LayoutBuilder(builder: (context, constraints) {
                  final width = constraints.maxWidth ;
                  ///根据宽度获取不同的Screen
                  return judgePageWithScreenWidth(width);
                }),
              )),
    ));
  }

  Widget judgePageWithScreenWidth(double width) {
    return width > 1100
                    ? buildBigScreenHomeContent()
                    : Column(
                        children: [Expanded(child: buildContent(1)), Footer()],
                      );
  }

  Widget buildBigScreenHomeContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildContent(),
        SizedBox(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SideCard(),
              ProfileCard(),
            ],
          ),
        ),
      ],
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
    return Container(padding: EdgeInsets.only(bottom: 40, top: 20), child: CupertinoActivityIndicator());
  }


  Widget buildBanner() {
    return GradientBgContainer();
  }
}

class TagItem {
  Color color;
  String tag;

  TagItem(this.tag, this.color);
}
