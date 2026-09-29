import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class UBrandShowcase extends StatelessWidget {
  const UBrandShowcase({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return URoundedContainer(
      showBorder: true,
      borderColor: UColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.all(USizes.md),
      margin: EdgeInsets.only(bottom: USizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //brand with product count
          UBrandCard(showBorder: false),

          //
          Row(
            children: images
                .map((images) => _buildBrandImages(dark, images))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandImages(bool dark, String image) {
    return Expanded(
      child: URoundedContainer(
        height: 100,
        margin: const EdgeInsets.only(right: USizes.md),
        padding: const EdgeInsets.all(USizes.md),
        backgroundColor: dark ? UColors.white : UColors.darkGrey,
        child: Image(image: AssetImage(image), fit: BoxFit.contain),
      ),
    );
  }
}
