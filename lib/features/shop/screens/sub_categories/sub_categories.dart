import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';

import 'package:e_commerce/common/widget/products/products_card/product_card_horizntal.dart';
import 'package:e_commerce/common/widget/shimmer/horizontal_shimmer.dart';

import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/category/category_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SubCategories extends StatelessWidget {
  const SubCategories({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: UAppBar(
        showArrowBack: true,
        title: Text(
          category.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: FutureBuilder(
            future: controller.fetchSUbCategories(category.id),
            builder: (context, snapshot) {
              //shimmer effect
              const loader = UHorizontalProductShimmer();
              //
              final widget = UCloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,
                loader: loader,
              );
              if (widget != null) {
                return widget;
              }
              final List<CategoryModel> subcategories = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: subcategories.length,
                itemBuilder: (context, index) {
                  CategoryModel subcategory = subcategories[index];
                  return FutureBuilder(
                    future: controller.fetchCategoryProducts(subcategory.id),
                    builder: (context, snapshot) {
                      final widget =
                          UCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: loader,
                          );
                      if (widget != null) return widget;

                      //products
                      final products = snapshot.data!;
                      return Column(
                        children: [
                          //
                          /// Sub Category
                          USectionHeading(
                            title: subcategory.name,
                            onPressed: () {
                              Get.to(
                                () => AllProductsScreen(
                                  title: subcategory.name,
                                  futureMethod: controller
                                      .fetchCategoryProducts(
                                        subcategory.id,
                                        limit: -1,
                                      ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: USizes.spaceBtwItems / 2),

                          /// Horizontal Product Card - right side
                          SizedBox(
                            height: 120,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: USizes.spaceBtwItems / 2),
                              itemCount: products.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return UProductHorizontalCard(product: product);
                              },
                            ), // ListView.separated
                          ), // SizedBox
                          //left side details
                        ],
                      );
                    },
                  );
                },
              );
            },
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    );
  }
}
