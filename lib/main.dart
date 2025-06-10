import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woo/common/index.dart';
import 'package:get/get.dart';

import 'global.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 896), // 设计稿中设备的尺寸(单位随意,建议dp,但在使用过程中必须保持一致)
        splitScreenMode: false, // 支持分屏尺寸
        minTextAdapt: false, // 是否根据宽度/高度中的最小值适配文字
        builder: (context, child) => AdaptiveTheme(
            light: AppTheme.light,
            dark: AppTheme.dark,
            initial: ConfigService.to.themeMode,
            debugShowFloatingThemeButton: true, // 显示主题按钮
            builder: (theme, darkThem) => GetMaterialApp(
                  title: 'Flutter Demo',
                  // 主题
                  theme: theme,
                  darkTheme: darkThem,

                  // 多语言
                  translations: Translation(), // 词典
                  localizationsDelegates:
                      Translation.localizationsDelegates, // 代理
                  supportedLocales: Translation.supportedLocales, // 支持的语言种类
                  locale: ConfigService.to.locale, // 当前语言种类
                  fallbackLocale: Translation.fallbackLocale, // 默认语言种类

                  initialRoute: RouteNames.systemSplash,
                  getPages: RoutePages.list,
                  navigatorObservers: [RoutePages.observer],

                  builder: (context, widget) {
                    //不随系统字体缩放比例
                    return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: widget!);
                  },
                  debugShowCheckedModeBanner: false,
                )));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
