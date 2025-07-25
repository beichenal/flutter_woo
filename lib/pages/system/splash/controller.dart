import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/index.dart';

class SplashController extends GetxController {
  SplashController();

  _jumpToPage() {
    // 欢迎页

    ConfigService().getAlreadyOPen().then((opened) {
      debugPrint("splash page opened $opened");
      if (opened) {
        Get.offAllNamed(RouteNames.systemMain);
      } else {
        Get.offAllNamed(RouteNames.systemWelcome);
      }
    });
  }

  _initData() {
    update(["splash"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    AppTheme.setSystemStyle();
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
    _jumpToPage(); // 跳转界面
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
