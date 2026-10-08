import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/common/widget/images/rounded_images.dart';
import 'package:e_commerce/common/widget/text/brand_title_with_verification_icon.dart';
import 'package:e_commerce/features/shop/models/brands/brands_model.dart';
import 'package:e_commerce/utils/constants/enums.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UBrandCard extends StatelessWidget {
  const UBrandCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.brandModel,
  });

  final bool showBorder;
  final VoidCallback? onTap;
  final BrandModel brandModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 200, // <-- fixed width fixes the unbounded-constraint crash
        child: URoundedContainer(
          height: USizes.brandCardHeight,
          showBorder: showBorder,
          padding: EdgeInsets.all(USizes.sm),
          backgroundColor: Colors.transparent,
          child: Row(
            children: [
              Flexible(
                child: URoundedImage(
                  imageUrl: brandModel.image,
                  isNetworkImage: true, // see issue #2 below
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(width: USizes.spaceBtwItems / 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UBrandTitleWithVerifyIcon(
                      title: brandModel.name,
                      brandTextSize: TextSizes.large,
                    ),
                    Text(
                      "${brandModel.productsCount.toString()} products",
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
