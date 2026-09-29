import 'package:e_commerce/common/widget/brands/brand_showcase.dart';
import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/products_card/products_card_vetrtical.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(USizes.defaultSpace),
          child: Column(
            children: [
              UBrandShowcase(
                images: [
                  UImages.productImage11,
                  UImages.productImage11,
                  UImages.productImage11,
                ],
              ),
              UBrandShowcase(
                images: [
                  UImages.productImage11,
                  UImages.productImage11,
                  UImages.productImage11,
                ],
              ),
              UBrandShowcase(
                images: [
                  UImages.productImage11,
                  UImages.productImage11,
                  UImages.productImage11,
                ],
              ),

              USectionHeading(title: "You might like"),

              UGridLayout(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return UProductsCardVetrtical();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
