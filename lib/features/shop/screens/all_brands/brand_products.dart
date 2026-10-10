import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/common/widget/shimmer/vertical_shimmer_product.dart';
import 'package:e_commerce/features/shop/controller/brands/brands_controller.dart';
import 'package:e_commerce/features/shop/models/brands/brands_model.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/features/shop/screens/all_brands/widgets/sortable_products.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({
    super.key,
    required this.title,
    required this.brand,
  });
  final String title;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        showArrowBack: true,
        title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Column(
            children: [
              UBrandCard(brandModel: brand),
              SizedBox(height: USizes.spaceBtwSections),

              FutureBuilder(
                future: controller.getBrandProduct(brand.id),
                builder: (context, asyncSnapshot) {
                  const loader = UVerticalProductShimmer();
                  Widget? widget = UCloudHelperFunctions.checkMultiRecordState(
                    snapshot: asyncSnapshot,
                  );
                  if (widget != null) return widget;
                  //
                  List<ProductModel> products = asyncSnapshot.data!;
                  return USortableProducts(product: products);
                },
              ),
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
