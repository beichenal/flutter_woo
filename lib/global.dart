import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'common/index.dart';

class Global {
  static Future<void> init() async {
    // 插件初始化
    WidgetsFlutterBinding.ensureInitialized();
    Storage().init();
    Loading();
    Get.put<WPHttpService>(WPHttpService());
    Get.put<UserService>(UserService());
    // 初始化队列
    await Future.wait([
      // 配置服务
      Get.putAsync<ConfigService>(() async => await ConfigService().init()),
    ]).whenComplete(() {});
  }
}
