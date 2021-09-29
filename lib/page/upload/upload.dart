import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:free/bean/entity/a_entity.dart';
import 'package:free/global/custom/my_theme.dart';
import 'package:free/page/home/model.dart';
import 'package:free/page/upload/model.dart';

class UploadPage extends StatefulWidget {
  UploadPage({Key? key, this.article}) : super(key: key);
  final ArticleEntity? article;

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  late UploadModel model = UploadModel(articleEntity: widget.article);
  late TextEditingController controllerTitle = TextEditingController.fromValue(TextEditingValue(text: model.articleEntity.title ?? ""));
  late TextEditingController controllerContent = TextEditingController.fromValue(TextEditingValue(text: model.articleEntity.content ?? ""));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(),
            Expanded(child: buildContent()),
            buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          BackButton(),
          Expanded(
            child: TextField(
              controller: controllerTitle,
              onChanged: (v) {
                model.articleEntity.title = v;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20),
                labelText: "输入文章标题...",
              ),
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(backgroundColor: kButtonBackgroundColor(context), foregroundColor: kButtonForegroundColor(context)),
            onPressed: submitArticle,
            child: Text("发布"),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  submitArticle() async {
    var bar = FlushbarHelper.createLoading(message: "正在提交文章", linearProgressIndicator: LinearProgressIndicator());
    try {
      bar.show(context);
      String? err = model.checkArticleValid();
      if (err != null) {
        print(err);
        // bar.dismiss();
        FlushbarHelper.createError(message: err).show(context);
        return;
      }
      if (!kIsWeb) {
        bar.dismiss();
        bar = FlushbarHelper.createLoading(message: "正在处理图片", linearProgressIndicator: LinearProgressIndicator());
        bar.show(context);

        ///处理替换图片url
        await model.dealReplaceUrl();
      }

      bar.dismiss();
      bar = FlushbarHelper.createLoading(message: "正在提交文章", linearProgressIndicator: LinearProgressIndicator());
      bar.show(context);

      ///上传文章
      await model.uploadArticle();
      bar.dismiss();
      final sucBar = FlushbarHelper.createSuccess(message: "成功提交");
      sucBar.show(context);
      await Future.delayed(Duration(seconds: 2));
      sucBar.dismiss();
      Navigator.of(context).pop(true);
    } catch (err) {
      print(err);
      bar.dismiss();
      FlushbarHelper.createError(message: err.toString()).show(context);
    }
  }

  Widget buildContent() {
    return TextField(
      autofocus: true,
      onChanged: (v) {
        model.articleEntity.content = v;
      },
      controller: controllerContent,
      maxLines: 1000,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        border: InputBorder.none,
      ),
    );
  }

  Widget buildFooter() {
    return Text("字数:${model.articleEntity.content?.length ?? 0}");
  }
}
