import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:free/theme/bg.dart';
import 'package:free/widget/container.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        padding: EdgeInsets.all(20),
        decoration: RoundedBoxDecoration(
            boxShadow: MyShadow.cardShadow(context),
            color: Theme.of(context).colorScheme.surface,
            radius: 10),
        margin: EdgeInsets.only(right: 20, bottom: 100),
        child: Baseline(
          baseline: 20,
          baselineType: TextBaseline.ideographic,
          child: RichText(
            text: TextSpan(
              style: textTheme.caption?.copyWith(height: 1.4),
              children: [
                TextSpan(text: "guuguo  ", style: textTheme.headline6),
                TextSpan(text: "郭德清\n"),
                TextSpan(text: "Android开发工程师\n\n"),
                TextSpan(text: "基本信息\n", style: textTheme.headline6),
                TextSpan(text: "年龄：27岁(1994年生)\n"),
                TextSpan(
                    text: "工龄：5年(2016年至今)\n",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    )),
                TextSpan(text: "性别：男\n"),
                TextSpan(text: "地区：杭州\n"),
                TextSpan(text: "邮箱：guuguo@qq.com\n"),
                TextSpan(text: "毕业院校：温州大学城市学院(计算机科学与技术专业)\n"),
              ],
            ),
          ),
        ));
  }
}
