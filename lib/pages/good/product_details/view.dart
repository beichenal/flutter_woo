import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import 'index.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // 5 定义 tag 值，唯一即可
  final String tag = '${Get.arguments['id'] ?? ''}${UniqueKey()}';

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _ProductDetailsViewGetX(tag);
  }
}

class _ProductDetailsViewGetX extends GetView<ProductDetailsController> {
  const _ProductDetailsViewGetX(this.uniqueTag);

  // 1 定义唯一 tag 变量
  final String uniqueTag;

  // 3 重写 GetView 属性 tag
  @override
  String? get tag => uniqueTag;

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("ProductDetailsPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      init: ProductDetailsController(),
      id: "product_details",
      tag: tag,
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text("product_details")),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
