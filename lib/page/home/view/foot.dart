import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:free/widget/container.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: FooterText(divider: " - "));
  }
}

class SideCard extends StatelessWidget {
  const SideCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: RoundedBoxDecoration(
            color: Theme.of(context).colorScheme.surface, radius: 10),
        margin: EdgeInsets.only(right: 20, top: 20, bottom: 20),
        child: FooterText(divider: "\n"));
  }
}

class FooterText extends StatelessWidget {
  const FooterText({
    Key? key,
    required this.divider,
  }) : super(key: key);

  final String divider;

  @override
  Widget build(BuildContext context) {
    return RichText(
      locale: const Locale('ch', 'CN'),
      softWrap: true,
      text: TextSpan(
        style: Theme.of(context).textTheme.caption,
        children: [
          TextSpan(text: "guuguo$divider"),
          TextSpan(
              text: "浙ICP备20002139号-1$divider",
              recognizer: new TapGestureRecognizer()
                ..onTap = () async {
                  const url = 'http://www.beian.gov.cn/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
          TextSpan(text: "谷果之家"),
        ],
      ),
    );
  }
}
