import 'package:flutter/material.dart';
import 'package:free/global/custom/my_theme.dart';
import 'package:free/global/global_model.dart';
import 'package:free/global/options_model.dart';
import 'package:free/page/home/home.dart';
import 'package:free/page/upload/upload.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var globalModel = GlobalModel();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => globalModel),
        ChangeNotifierProvider(create: (c) => OptionsModel()),
      ],
      child: Consumer<OptionsModel>(
          builder: (context, v, c) => MaterialApp(
                title: '谷果之家',
                theme: kLightDiaryTheme.data,
                darkTheme: kDarkDiaryTheme.data,
                home: MyHomePage()),
              ),
    );
  }
}
