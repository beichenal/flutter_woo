import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woo/common/index.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/bar_item.dart';

class MyIndexPage extends GetView<MyIndexController> {
  const MyIndexPage({super.key});

  // 顶部 APP 导航栏
  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      // 背景色
      backgroundColor: Colors.transparent,
      // 固定在顶部
      pinned: true,
      // 浮动在顶部
      floating: true,
      // 自动弹性显示
      snap: true,
      // 是否应拉伸以填充过度滚动区域。
      stretch: true,
      // 高度
      expandedHeight: 280.h,
      // 此小组件堆叠在工具栏和选项卡栏后面。其高度将与应用栏的整体高度相同。
      flexibleSpace: FlexibleSpaceBar(
        // // // 折叠模式
        // collapseMode: CollapseMode.parallax,
        // // // 折叠动画
        // stretchModes: const [
        //   // 模糊
        //   StretchMode.blurBackground,
        //   // 尺寸
        //   StretchMode.zoomBackground,
        //   // 标题动画
        //   StretchMode.fadeTitle,
        // ],
        // // // 标题
        // title: const TextWidget.navigation(text: "Ducafecat"),
        // 背景
        background: <Widget>[
          // 背景图
          <Widget>[
            IconWidget.svg(
              AssetsSvgs.profileHeaderBackgroundSvg,
              color: context.colors.scheme.primary,
              fit: BoxFit.cover,
            ).expanded(),
            // const ImageWidget.(
            //   AssetsImages.profileBackgroundPng,
            //   fit: BoxFit.cover,
            // ).expanded(),
          ].toColumn(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),

          // 内容
          <Widget>[
            // 用户信息
            <Widget>[
              // 头像
              ImageWidget.img(
                // 测试需要改成自定义头像
                "https://ducafecat-pub.oss-cn-qingdao.aliyuncs.com/avatar/00258VC3ly1gty0r05zh2j60ut0u0tce02.jpg",
                width: 100.w,
                height: 100.w,
                fit: BoxFit.fill,
                radius: 50.w,
              ).paddingRight(AppSpace.listItem),

              // 称呼
              TextWidget.h2(
                "${UserService.to.profile.username}",
                color: context.colors.scheme.onPrimary,
              ),
            ].toRow().paddingHorizontal(AppSpace.card),

            // 功能栏位
            <Widget>[
              // 1
              BarItemWidget(
                title: LocaleKeys.myTabWishlist.tr,
                svgPath: AssetsSvgs.iLikeSvg,
              ),
              // 2
              BarItemWidget(
                title: LocaleKeys.myTabFollowing.tr,
                svgPath: AssetsSvgs.iAddFriendSvg,
              ),
              // 3
              BarItemWidget(
                title: LocaleKeys.myTabVoucher.tr,
                svgPath: AssetsSvgs.iCouponSvg,
              ),
            ]
                .toRow(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                )
                .paddingSymmetric(
                  horizontal: AppSpace.card,
                  vertical: AppSpace.card * 2,
                )
                .card(
                  color: context.colors.scheme.surface,
                )
                .paddingHorizontal(AppSpace.page),
          ].toColumn(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ].toStack(),
      ),
    );
  }

  // My Order
  Widget _buildMyOrder(BuildContext context) {
    return const Text("My Order");
  }

  // 按钮列表
  Widget _buildButtonsList(BuildContext context) {
    return const Text("按钮列表");
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        // 顶部 APP 导航栏
        _buildAppBar(context),

        // My Order
        _buildMyOrder(context).sliverBox,

        // 按钮列表
        _buildButtonsList(context).sliverBox,

        // 注销
        ButtonWidget.primary(
          LocaleKeys.myBtnLogout.tr,
          // height: 60,
          // onTap: () => controller.onLogout(),
        )
            .padding(
              left: AppSpace.page,
              right: AppSpace.page,
              bottom: AppSpace.listRow * 2,
            )
            .sliverBox,

        // 版权
        const TextWidget.label(
          "Code by: https://ducafefcat.com",
        ).alignCenter().paddingBottom(AppSpace.listRow).sliverBox,

        // 版本号
        TextWidget.label(
          "v ${ConfigService.to.version}",
        ).alignCenter().paddingBottom(200).sliverBox,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyIndexController>(
      init: Get.find<MyIndexController>(),
      id: "my_index",
      builder: (_) {
        return Scaffold(
          body: _buildView(context),
        );
      },
    );
  }
}
