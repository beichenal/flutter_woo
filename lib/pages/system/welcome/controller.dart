import 'package:flutter_woo/common/index.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  List<WelcomeModel>? items;

  int currentIndex = 0;

  /// 当前位置发生改变
  void onPageChanged(int index) {
    currentIndex = index;
    update(['slider', 'bar']);
  }

  _initData() {
    items = [
      WelcomeModel(
        image: AssetsImages.welcome_1Png,
        title: LocaleKeys.welcomeOneTitle.tr,
        desc: LocaleKeys.welcomeOneDesc.tr,
      ),
      WelcomeModel(
        image: AssetsImages.welcome_2Png,
        title: LocaleKeys.welcomeTwoTitle.tr,
        desc: LocaleKeys.welcomeTwoDesc.tr,
      ),
      WelcomeModel(
        image: AssetsImages.welcome_3Png,
        title: LocaleKeys.welcomeThreeTitle.tr,
        desc: LocaleKeys.welcomeThreeDesc.tr,
      ),
    ];

    update(['slider', 'bar']);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
