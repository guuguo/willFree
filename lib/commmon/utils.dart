import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showMessage(BuildContext context, String msg, {double duration = 1.3, required Icon icon}) {
  Flushbar(
    icon: icon,
    message: msg,
    barBlur: 3,
    borderRadius: BorderRadius.circular(6),
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    duration: Duration(milliseconds: (duration * 1000).round()),
    animationDuration: Duration(milliseconds: 400),
  ).show(context);
}

showWarning(BuildContext context, String msg, {double duration = 1.3}) {
  showMessage(context, msg,
      duration: duration,
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ));
}
