import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/brands/brands_controller.dart';
import 'package:e_commerce/features/shop/models/brands/brands_model.dart';
import 'package:e_commerce/features/shop/screens/all_brands/brand_products.dart';

import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: UAppBar(
        title: Text("Brands", style: Theme.of(context).textTheme.headlineSmall),
        showArrowBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Column(
            children: [
              USectionHeading(title: "brands", showActionButton: false),
              SizedBox(height: USizes.spaceBtwItems),
              Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.allBrands.isEmpty) {
                  return Text("No Brands available");
                }

                return UGridLayout(
                  mainAxisExtent: 80,
                  itemCount: controller.allBrands.length,
                  itemBuilder: (context, index) {
                    final BrandModel brand = controller.allBrands[index];
                    return UBrandCard(
                      onTap: () {
                        Get.to(
                          () => BrandProductsScreen(
                            title: brand.name,
                            brand: brand,
                          ),
                        );
                      },
                      brandModel: brand,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
