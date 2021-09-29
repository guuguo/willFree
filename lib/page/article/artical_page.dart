import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:free/bean/entity/a_entity.dart';
import 'package:free/net/dio_helper.dart';
import 'package:free/repository/net_repository.dart';
import 'package:free/widget/container.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

import 'browser_no_drag_behavior.dart';
import 'markdown/markdown_style.dart';

class ArticlePage extends StatefulWidget {
  ArticlePage({Key? key, required this.article}) : super(key: key);

  final ArticleEntity article;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  String? markdownSource;

  @override
  void initState() {
    super.initState();
    loadArticle();
  }

  bool isLoading = true;

  Future loadArticle() async {
    if (widget.article.file != null)
      markdownSource = await DioHelper.get().fetchString(widget.article.file!);
    else if (widget.article.content == null) {
      final res = await NetRepository.getArticleDetail(widget.article.objectId);
      widget.article.content = res.content;
    } else {
      await Future.delayed(Duration(milliseconds: 500), () {});
    }
    markdownSource = widget.article.content;
    isLoading = false;
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        scrollBehavior: BrowserNoDragBehavior(),
        headerSliverBuilder: (c, i) => [
          SliverAppBar(
            title: Text(widget.article.title ?? ""),
            leading: CupertinoNavigationBarBackButton(color: Theme.of(context).iconTheme.color,),
          )
        ],
        floatHeaderSlivers: true,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 1100),
            child: Hero(
              tag: widget.article.objectId ?? "",
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: RoundedBoxDecoration(
                  radius: 0,
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: buildMarkdown(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildMarkdown() => isLoading
      ? Center(
          child: CupertinoActivityIndicator(),
        )
      : Markdown(
          data: markdownSource!,
          syntaxHighlighter: HighLight(Theme.of(context).brightness == Brightness.light),
          padding: EdgeInsets.all(20),
          styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
          styleSheet: MarkdownStyleSheet(
              // 支持修改样式
              h1: TextStyle(fontSize: 24),
              h2: TextStyle(fontSize: 22),
              h3: TextStyle(fontSize: 18),
              p: TextStyle(fontSize: 14, height: 1.9),
              listIndent: 20,
              listBullet: TextStyle(fontSize: 18),
              blockquotePadding: EdgeInsets.all(20),
              blockquoteAlign: WrapAlignment.start,
              blockquote: TextStyle(fontSize: 14),
              blockSpacing: 12,
              blockquoteDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(left: BorderSide(color: Theme.of(context).dividerColor, width: 4)),
                color: Theme.of(context).chipTheme.backgroundColor,
              ),
              codeblockPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
              codeblockDecoration: RoundedBoxDecoration(
                color: Theme.of(context).chipTheme.backgroundColor,
                radius: 4,
              )),
          builders: {
            'h1': HeaderBuilder(padding: 15),
            'h2': HeaderBuilder(padding: 12),
            'h3': HeaderBuilder(padding: 6),
            'h6': HeaderBuilder(padding: 2),
          },
          onTapLink: (text, href, title)async {
            if (href!=null&&await canLaunch(href)) {
            await launch(href);
            }
          },
          selectable: true,
        );
}
