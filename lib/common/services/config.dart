import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../index.dart';

/// 配置服务
class ConfigService extends GetxService {
  Locale locale = PlatformDispatcher.instance.locale;

  // 主题
  AdaptiveThemeMode themeMode = AdaptiveThemeMode.light;

  static ConfigService get to => Get.find();

  // 单例写法
  static final ConfigService _instance = ConfigService._internal();
  factory ConfigService() => _instance;

  ConfigService._internal();

  // 包信息
  PackageInfo? _platform;

  // 版本号
  String get version => _platform?.version ?? '-';

  // 初始化
  Future<ConfigService> init() async {
    initLocale();
    await initTheme();
    await getPlatform();
    return this;
  }

  // 获取包信息
  Future<void> getPlatform() async {
    _platform = await PackageInfo.fromPlatform();
  }

  // 是否首次打开
  Future<bool> getAlreadyOPen() async {
    return await Storage().getBool(Constants.storageAlreadyOpen);
  }

  // 标记已打开app
  void setAlreadyOpen() {
    Storage().setBool(Constants.storageAlreadyOpen, true);
  }

  // 初始 theme
  Future<void> initTheme() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    themeMode = savedThemeMode ?? AdaptiveThemeMode.light;
  }

  // 切换 theme
  Future<void> setThemeMode(String themeKey) async {
    switch (themeKey) {
      case "light":
        AdaptiveTheme.of(Get.context!).setLight();
        break;
      case "dark":
        AdaptiveTheme.of(Get.context!).setDark();
        break;
      case "system":
        AdaptiveTheme.of(Get.context!).setSystem();
        break;
    }

    // 设置系统样式
    AppTheme.setSystemStyle();
  }

  // 初始语言
  void initLocale() async {
    var langCode = await Storage().getString(Constants.storageLanguageCode);
    if (langCode.isEmpty) return;
    var index = Translation.supportedLocales.indexWhere((element) {
      return element.languageCode == langCode;
    });
    if (index < 0) return;
    locale = Translation.supportedLocales[index];
  }

  // 更改语言
  void setLanguage(Locale value) {
    locale = value;
    Get.updateLocale(value);
    Storage().setString(Constants.storageLanguageCode, value.languageCode);
  }
}
