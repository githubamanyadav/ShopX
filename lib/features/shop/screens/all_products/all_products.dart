import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/shimmer/vertical_shimmer_product.dart';
import 'package:e_commerce/features/shop/controller/product/all_products_controller.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/features/shop/screens/all_brands/widgets/sortable_products.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({
    super.key,
    this.title,
    this.query,
    this.futureMethod,
  });

  final String? title;
  final Query? query;
  final Future<List<ProductModel>>? futureMethod;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    return Scaffold(
      appBar: UAppBar(
        showArrowBack: true,
        title: Text(
          "Popular products",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: FutureBuilder<List<ProductModel>>(
            future: futureMethod ?? controller.fetchProductsByQuery(query),
            builder: (context, snapshot) {
              const loader = UVerticalProductShimmer();
              final widget = UCloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,
                loader: loader,
              );

              if (widget != null) return widget;
              final products = snapshot.data!;

              return USortableProducts(product: products);
            },
          ),
        ),
      ),
    );
  }
}
