import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free/global/global_model.dart';
import 'package:free/page/home/model.dart';
import 'package:free/page/home/view/login.dart';
import 'package:free/page/upload/upload.dart';
import 'package:free/theme/bg.dart';
import 'package:free/widget/simple_widget.dart';
import 'package:provider/provider.dart';

class GradientBgContainer extends StatelessWidget {
  const GradientBgContainer({
    Key? key,
    this.child,
    this.radius = 10,
  }) : super(key: key);
  final Widget? child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: MyGradient.bgPrimary(context),
        borderRadius: BorderRadius.circular(radius),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).primaryTextTheme.bodyText1!,
        child: Row(
          children: [
            buildAvatar(context),
            SizedBox(width: 20),
            Expanded(child:  buildSlogan()),
            SizedBox(),
            buildUpload(context),
          ],
        ),
      ),
    );
  }

  Widget buildSlogan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "不忘初心，方得始终\n缓步慢行",
          softWrap: true,
        ),
        // Consumer<GlobalModel>(
        //   builder: (con, v, child) => Text(v.user?.username ?? ""),
        // )
      ],
    );
  }

  Widget buildAvatar(BuildContext context) {
    return Hero(
      tag: "guuguoAvatar",
      child: GestureDetector(
        onDoubleTap: () {
          showCupertinoDialog(context: context, builder: (c) => LoginDialog());
        },
        child: RoundedImage.url(
          radius: 50,
          imageUrl: "https://guuguoweb.oss-cn-beijing.aliyuncs.com/avatar.png",
          borderSide: BorderSide(color: Colors.white, width: 4),
          fit: BoxFit.cover,
          width: 90,
          height: 90,
        ),
      ),
    );
  }

  Widget buildUpload(BuildContext context) {
    return Consumer<GlobalModel>(
        builder: (c, v, child) => Offstage(
            offstage: !v.isAdmin(),
            child: IconButton(
                iconSize: 30,
                onPressed: () async {
                  final res = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UploadPage()));
                  if (res == true) {
                    Provider.of<HomeModel>(context,listen: false).refresh();
                  }
                },
                icon: Icon(
                  CupertinoIcons.cloud_upload_fill,
                  color: Colors.white,
                ))));
  }
}
