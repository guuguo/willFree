import 'package:flutter/material.dart';
import 'package:free/bean/entity/a_entity.dart';
import 'package:free/repository/net_repository.dart';
import 'package:free/utils/developer.dart';

class GlobalModel extends ChangeNotifier {
  UserEntity? user;
  RoleEntity? role;

  bool isAdmin() => role?.isAdmin() ?? false;

  GlobalModel() {
    _instance = this;
    NetRepository.loginWithTourist().then((value) {
      user = value;
      notifyListeners();
    }).catchError((e) {
      debug(e, tag: "登录失败");
    });
  }

  Future login(String username, String password) async {
    try {
      user = await NetRepository.login(username: username, password: password);
      final roles = await NetRepository.getRoles(user!);
      debug(roles.toJson(), tag: "获取角色成功");
      if (roles.results.length > 0) {
        role = roles.results[0];
      }
      notifyListeners();
    } catch (e) {
      debug(e, tag: "登录失败");
    }
  }

  static GlobalModel? _instance;

  static GlobalModel? get() => _instance;
}
