import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/products_card/products_card_vetrtical.dart';
import 'package:e_commerce/common/widget/shimmer/vertical_shimmer_product.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/category/category_controller.dart';
import 'package:e_commerce/features/shop/controller/product/all_products_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screens/store/screens/widgets/category_brands.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(USizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(category: category),

              USectionHeading(
                title: "You might like",

                onPressed: () {
                  Get.to(
                    () => AllProductsScreen(
                      title: category.name,
                      futureMethod: controller.fetchCategoryProducts(
                        category.id,
                        limit: -1,
                      ),
                    ),
                  );
                },
              ),
              //showing the products according to the  categories
              FutureBuilder(
                future: controller.fetchCategoryProducts(category.id),
                builder: (context, snapshot) {
                  //shimmer effect
                  final loader = UVerticalProductShimmer();
                  final widget = UCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                  );
                  if (widget != null) return widget;

                  final List<ProductModel> products = snapshot.data!;

                  return UGridLayout(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final ProductModel product = products[index];
                      return UProductsCardVetrtical(product: product);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
