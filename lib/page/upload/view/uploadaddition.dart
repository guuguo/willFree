import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free/commmon/utils.dart';
import 'package:free/global/global_model.dart';
import 'package:provider/provider.dart';

class UploadAdditionDialog extends StatefulWidget {
  const UploadAdditionDialog({Key? key}) : super(key: key);

  @override
  _UploadAdditionDialogState createState() => _UploadAdditionDialogState();
}

class _UploadAdditionDialogState extends State<UploadAdditionDialog> {
  var username = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(" "),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          CupertinoTextField(
              autofocus: true,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]"))],
              placeholder: "用户名",
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              prefix: Padding(padding: EdgeInsets.only(left: 10), child: Icon(CupertinoIcons.person_alt_circle_fill)),
              onChanged: (v) {
                username = v;
              }),
          SizedBox(height: 8),
          CupertinoTextField(
            placeholder: "密码",
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            obscureText: true,
            prefix: Padding(padding: EdgeInsets.only(left: 10), child: Icon(CupertinoIcons.lock_circle_fill)),
            onChanged: (v) {
              password = v;
            },
            textInputAction: TextInputAction.done,
            onSubmitted: (v) {
              login();
            },
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("取消")),
        CupertinoDialogAction(onPressed: login, child: Text("登录")),
      ],
    );
  }

  login() async {
    String? err;
    if (username.isEmpty) {
      err = "用户名不能为空";
    } else if (password.isEmpty) {
      err = "密码不能为空";
    }
    if (err != null) {
      FlushbarHelper.createError(message: err).show(context);
      return;
    }
    Navigator.of(context).pop();
    final bar = FlushbarHelper.createLoading(message: "登录中", linearProgressIndicator: LinearProgressIndicator());
    bar.show(context);
    await Provider.of<GlobalModel>(context, listen: false).login(username, password);
    bar.dismiss();
  }
}
