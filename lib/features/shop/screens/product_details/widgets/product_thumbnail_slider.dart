import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/common/widget/images/rounded_images.dart';
import 'package:e_commerce/features/shop/controller/product/image_controller.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class UProductThumbnailAndSlider extends StatelessWidget {
  const UProductThumbnailAndSlider({
    super.key,
    required this.dark,
    required this.product,
  });

  final bool dark;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ImagesController());
    List<String> images = controller.getAllProductImages(product);
    return Stack(
      children: [
        //thumbnail or the image
        SizedBox(
          height: 400,
          child: Padding(
            padding: EdgeInsetsGeometry.all(USizes.productImageRadius * 2),
            child: Center(
              child: Obx(() {
                final image = controller.selectedProductImage.value;
                return GestureDetector(
                  onTap: () => controller.showEnlargeImage(image),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    progressIndicatorBuilder: (context, url, progress) =>
                        CircularProgressIndicator(
                          color: UColors.primary,
                          value: progress.progress,
                        ),
                  ),
                );
              }),
            ),
          ),
        ),

        //image slider
        //image slider
        Positioned(
          left: USizes.defaultSpace,
          right: 0,
          bottom: 30,
          child: SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) =>
                  SizedBox(width: USizes.spaceBtwItems),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  final isSelected =
                      controller.selectedProductImage.value == images[index];
                  return URoundedImage(
                    isNetworkImage: true,
                    width: 80,
                    imageUrl: images[index], // show this thumbnail's own image
                    onPressed: () =>
                        controller.selectedProductImage.value = images[index],
                    padding: EdgeInsets.all(USizes.sm),
                    backgroundColor: dark ? UColors.dark : UColors.white,
                    border: Border.all(
                      color: isSelected ? UColors.primary : Colors.transparent,
                    ),
                  );
                });
              },
            ),
          ),
        ),

        //arrow navigation & fav button
        UAppBar(
          showArrowBack: true,
          actions: [UCircularIcon(icon: Iconsax.heart5, color: Colors.red)],
        ),
      ],
    );
  }
}
