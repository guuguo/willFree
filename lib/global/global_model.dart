import 'package:flutter/material.dart';
import 'package:free/bean/entity/a_entity.dart';
import 'package:free/utils/developer.dart';

class GlobalModel extends ChangeNotifier {

  GlobalModel() {
    _instance = this;
  }

  static GlobalModel? _instance;

  static GlobalModel? get() => _instance;
}
