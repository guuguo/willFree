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
          return buildList(value, footerCount);
        }));
  }
  ///空布局
  Widget buildEmpty() {
    return Center(child: Text("没有找到数据"));
  }

  Widget buildLoading() {
    return Container(padding: EdgeInsets.only(bottom: 40, top: 20), child: CupertinoActivityIndicator());
  }

  ListView buildList(HomeModel value, [int footerCount = 0]) {
    if (value.loading || value.list.isEmpty) footerCount++;
    return ListView.builder(
      itemBuilder: (c, i) => buildListItem(c, value, value.list, i),
      itemCount: value.list.length + 1 + footerCount,
    );
  }

  Widget buildListItem(BuildContext context, HomeModel value, List<ArticleEntity> list, int index) {
    if (index == 0) return buildBanner();

    ///出去头和尾,占用的数量,比如列表数量和空布局或者加载布局数量
    int centerCount = list.length;
    if (value.loading) {
      if (index == 1) return buildLoading();
      centerCount++;
    } else if (value.list.isEmpty) {
      if (index == 1) return buildEmpty();
      centerCount++;
    }
    switch (index - centerCount - 1) {
      case 0:
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: ProfileCard(),
        );
    }

    return buildArticleItem(context, list[index - 1]);
  }

  ///文章item
  Widget buildArticleItem(BuildContext context, ArticleEntity item) {
    return GestureDetector(
        onTap: () {

        },
        child: Hero(
          tag: item.objectId ?? "",
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: RoundedBoxDecoration(
                boxShadow: MyShadow.cardShadow(context),
                radius: 10,
                color: Theme.of(context).colorScheme.surface,
              ),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        item.user == null ? SizedBox() : Text((item.user?.username ?? "")+" | "+DateTimeUtil.beforeSimpleStr(item.createdAt), style: Theme.of(context).textTheme.caption),
                        SizedBox(height: 8),
                        Text(item.title!, style: Theme.of(context).textTheme.subtitle1)
                      ],
                    ),
                  ),
                  Consumer<GlobalModel>(builder: (c, v, chi) => buildEditButton(v, context, item)),
                  Consumer<GlobalModel>(builder: (c, v, chi) => buildDeleteButton(v, context, item))
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildDeleteButton(GlobalModel v, BuildContext context, ArticleEntity item) {
    return Offstage(
      offstage: !v.isAdmin(),
      child: IconButton(
        onPressed: () {
          late Flushbar action;
          action = FlushbarHelper.createAction(
              message: "删除吗？",
              title: "警告",
              duration: Duration(seconds: 8),
              button: TextButton(
                  onPressed: () async {
                    action.dismiss();
                    await deleteArticle(context, item);
                  },
                  child: Text("确定")));
          action.show(context);
        },
        icon: Icon(CupertinoIcons.delete_solid),
      ),
    );
  }
  Widget buildEditButton(GlobalModel v, BuildContext context, ArticleEntity item) {
    return Offstage(
      offstage: !v.isAdmin(),
      child: IconButton(
        onPressed: () {
        },
        icon: Icon(CupertinoIcons.square_pencil_fill),
      ),
    );
  }
  Future deleteArticle(BuildContext context, ArticleEntity item) async {
    HomeModel model = Provider.of<HomeModel>(context, listen: false);
    final bar = FlushbarHelper.createLoading(message: "正在删除", linearProgressIndicator: LinearProgressIndicator());
    bar.show(context);
    await model.delete(item);
    bar.dismiss();
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
