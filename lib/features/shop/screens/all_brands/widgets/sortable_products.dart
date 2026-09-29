import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/screens/all_brands/brand_products.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        USectionHeading(title: "Brands", showActionButton: false),
        SizedBox(height: USizes.spaceBtwItems),
        UGridLayout(
          itemCount: 30,
          itemBuilder: (context, index) => UBrandCard(
            onTap: () {
              Get.to(() => BrandProductsScreen());
            },
          ),
          mainAxisExtent: 80,
        ),
      ],
    );
  }
}
