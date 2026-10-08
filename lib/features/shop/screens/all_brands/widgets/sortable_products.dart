import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/brands/brands_controller.dart';

import 'package:e_commerce/features/shop/screens/all_brands/brand_products.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Column(
      children: [
        USectionHeading(title: "Brands", showActionButton: false),
        SizedBox(height: USizes.spaceBtwItems),
        Obx(() {
          return UGridLayout(
            itemCount: controller.allBrands.length,
            itemBuilder: (context, index) => UBrandCard(
              brandModel: controller.allBrands[index],
              onTap: () {
                Get.to(() => BrandProductsScreen());
              },
            ),
            mainAxisExtent: 80,
          );
        }),
      ],
    );
  }
}
