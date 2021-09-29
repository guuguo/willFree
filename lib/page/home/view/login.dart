import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:free/commmon/inputer_utils.dart';
import 'package:free/commmon/utils.dart';
import 'package:free/global/global_model.dart';
import 'package:provider/provider.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  var username = "";
  var password = "";
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("用户登录"),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: 10),
        buildMaterialTextField(
          inputFormatters: [CustomizedTextInputFormatter(filterPattern: RegExp("[a-zA-Z0-9]"))],
          placeholder: "用户名",
          preIcon: CupertinoIcons.person_alt_circle_fill,
          onChanged: (v) {
            username = v;
          },
          onEditingComplete: (){
            passwordFocusNode.requestFocus();
          }
        ),
        SizedBox(height: 8),
        buildMaterialTextField(
          placeholder: "密码",
          preIcon: CupertinoIcons.lock_circle_fill,
          onChanged: (v) {
            password = v;
          },
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("取消")),
        TextButton(onPressed: login, child: Text("登录")),
      ],
    );
  }

  CupertinoTextField buildTextField({
    TextEditingController? controller,
    FocusNode? focusNode,
    List<TextInputFormatter>? inputFormatters,
    String? placeholder,
    IconData? preIcon,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
  }) {
    return CupertinoTextField(
      controller: controller,
      autofocus: true,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      placeholder: placeholder,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      prefix: Padding(padding: EdgeInsets.only(left: 10), child: Icon(preIcon)),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
    );
  }

  TextField buildMaterialTextField({
    TextEditingController? controller,
    FocusNode? focusNode,
    List<TextInputFormatter>? inputFormatters,
    String? placeholder,
    IconData? preIcon,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
  }) {
    return TextField(
      controller: controller,
      focusNode:focusNode,
      autofocus: true,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: Padding(padding: EdgeInsets.only(left: 10, right: 10), child: Icon(preIcon)),
      ),
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
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
