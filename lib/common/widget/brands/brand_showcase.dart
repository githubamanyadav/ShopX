import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/common/widget/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/shop/models/brands/brands_model.dart';
import 'package:e_commerce/features/shop/screens/all_brands/brand_products.dart';
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class UBrandShowcase extends StatelessWidget {
  const UBrandShowcase({super.key, required this.images, required this.brand});

  final List<String> images;
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return InkWell(
      onTap: () {
        Get.to(() => BrandProductsScreen(title: brand.name, brand: brand));
      },
      child: URoundedContainer(
        showBorder: true,
        borderColor: UColors.darkGrey,
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.all(USizes.md),
        margin: EdgeInsets.only(bottom: USizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //brand with product count
            UBrandCard(brandModel: brand, showBorder: false),

            //
            Row(
              children: images
                  .map((images) => _buildBrandImages(dark, images))
                  .toList(),
            ),
          ],
        ),
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
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.contain,
          progressIndicatorBuilder: (context, url, progress) =>
              UShimmerEffect(width: 100, height: 100),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
