import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter_woo/common/index.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomeController extends GetxController {
  HomeController();

  // Banner 当前位置
  int bannerCurrentIndex = 0;

  // Banner 数据
  List<KeyValueModel> bannerItems = [];

  // 导航点击事件
  void onAppBarTap() {
    Get.toNamed(RouteNames.searchSearchIndex);
  }

  // Banner 切换事件
  dynamic onChangeBanner(int index, CarouselPageChangedReason rason) {
    bannerCurrentIndex = index;
    update(["home_banner"]);
  }

  // 分类导航数据
  List<CategoryModel> categoryItems = [];
  // 推荐商品列表数据
  List<ProductModel> flashShellProductList = [];
  // 最新商品列表数据
  List<ProductModel> newProductProductList = [];

  // 分类点击事件
  void onCategoryTap(int categoryId) {
    Get.toNamed(
      RouteNames.goodCategory,
      arguments: {
        "id": categoryId,
      },
    );
  }

  // ALL 点击事件
  void onAllTap(bool featured) {
    Get.toNamed(
      RouteNames.goodProductList,
      arguments: {
        "featured": featured,
      },
    );
  }

  // 刷新控制器
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );
  // 页码
  int _page = 1;

  // 页尺寸
  final int _limit = 20;

  /// 拉取数据
  /// isRefresh 是否是刷新
  Future<bool> _loadNewsSell(bool isRefresh) async {
    // 拉取数据
    var result = await ProductApi.products(ProductsReq(
      // 刷新, 重置页数1
      page: isRefresh ? 1 : _page,
      // 每页条数
      prePage: _limit,
    ));

    // 下拉刷新
    if (isRefresh) {
      _page = 1; // 重置页数1
      newProductProductList.clear(); // 清空数据
    }

    // 有数据
    if (result.isNotEmpty) {
      // 页数+1
      _page++;

      // 添加数据
      newProductProductList.addAll(result);
    }

    // 是否空
    return result.isEmpty;
  }

  // 上拉载入新商品
  void onLoading() async {
    if (newProductProductList.isNotEmpty) {
      try {
        // 拉取数据是否为空
        var isEmpty = await _loadNewsSell(false);

        if (isEmpty) {
          // 设置无数据
          refreshController.loadNoData();
        } else {
          // 加载完成
          refreshController.loadComplete();
        }
      } catch (e) {
        // 加载失败
        refreshController.loadFailed();
      }
    } else {
      // 设置无数据
      refreshController.loadNoData();
    }
    update(["home_news_sell"]);
  }

  // 下拉刷新
  void onRefresh() async {
    try {
      await _loadNewsSell(true);
      refreshController.refreshCompleted();
    } catch (error) {
      refreshController.refreshFailed();
    }
    update(["home_news_sell"]);
  }

  // 读取缓存
  Future<void> _loadCacheData() async {
    var stringBanner = await Storage().getString(Constants.storageHomeBanner);
    var stringCategories =
        await Storage().getString(Constants.storageHomeCategories);
    var stringFlashSell =
        await Storage().getString(Constants.storageHomeFlashSell);
    var stringNewSell = await Storage().getString(Constants.storageHomeNewSell);

    bannerItems = stringBanner != ""
        ? jsonDecode(stringBanner).map<KeyValueModel>((item) {
            return KeyValueModel.fromJson(item);
          }).toList()
        : [];

    categoryItems = stringCategories != ""
        ? jsonDecode(stringCategories).map<CategoryModel>((item) {
            return CategoryModel.fromJson(item);
          }).toList()
        : [];

    flashShellProductList = stringFlashSell != ""
        ? jsonDecode(stringFlashSell).map<ProductModel>((item) {
            return ProductModel.fromJson(item);
          }).toList()
        : [];

    newProductProductList = stringNewSell != ""
        ? jsonDecode(stringNewSell).map<ProductModel>((item) {
            return ProductModel.fromJson(item);
          }).toList()
        : [];

    if (bannerItems.isNotEmpty ||
        categoryItems.isNotEmpty ||
        flashShellProductList.isNotEmpty ||
        newProductProductList.isNotEmpty) {
      update(["home"]);
    }
  }

  _initData() async {
    // 首页
    // banner
    // bannerItems = await SystemApi.banners();
    // 分类
    // categoryItems = await ProductApi.categories();

    // 推荐商品
    // flashShellProductList =
    //     await ProductApi.products(ProductsReq(featured: true));
    // 新商品
    // newProductProductList = await ProductApi.products(ProductsReq());

    // 颜色
    // var attributeColors = await ProductApi.attributes(1);

    // 尺寸
    // var attributeSizes = await ProductApi.attributes(2);

    var result = await Future.wait([
      SystemApi.banners(),
      ProductApi.categories(),
      ProductApi.products(ProductsReq(featured: true)),
      ProductApi.products(ProductsReq()),
      ProductApi.attributes(1),
      ProductApi.attributes(2),
      ProductApi.attributes(3),
      ProductApi.attributes(4),
      ProductApi.attributes(5)
    ]);
    bannerItems = result[0] as List<KeyValueModel<dynamic>>;
    categoryItems = result[1] as List<CategoryModel>;
    flashShellProductList = result[2] as List<ProductModel>;
    newProductProductList = result[3] as List<ProductModel>;
    var attributeColors = result[4] as List<AttributeModel>;
    var attributeSizes = result[5] as List<AttributeModel>;

    // 品牌
    var attributeBrand = result[6] as List<AttributeModel>;
    // 性别
    var attributeGender = result[7] as List<AttributeModel>;
    // 新旧
    var attributeCondition = result[8] as List<AttributeModel>;

    // 保存离线数据 - 基础数据
    Storage()
        .setJson(Constants.storageProductsAttributesColors, attributeColors);
    Storage().setJson(Constants.storageProductsCategories, categoryItems);

    // 尺寸定义
    Storage().setJson(Constants.storageProductsAttributesSizes, attributeSizes);

    // // 保存离线数据
    Storage().setJson(Constants.storageHomeBanner, bannerItems);
    Storage().setJson(Constants.storageHomeCategories, categoryItems);
    Storage().setJson(Constants.storageHomeFlashSell, flashShellProductList);
    Storage().setJson(Constants.storageHomeNewSell, newProductProductList);
// 保存离线数据
    Storage().setString(
        Constants.storageProductsAttributesBrand, jsonEncode(attributeBrand));
    Storage().setString(
        Constants.storageProductsAttributesGender, jsonEncode(attributeGender));
    Storage().setString(Constants.storageProductsAttributesCondition,
        jsonEncode(attributeCondition));
    update(["home"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    // 读取缓存
    _loadCacheData();
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.dispose();
    // 刷新控制器释放
    refreshController.dispose();
  }
}
