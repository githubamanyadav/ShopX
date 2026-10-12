import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/features/shop/controller/product/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UFavouriteIcon extends StatelessWidget {
  const UFavouriteIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(
      () => UCircularIcon(
        icon: controller.isFavourite(productId)
            ? Iconsax.heart5
            : Iconsax.heart,
        color: controller.isFavourite(productId) ? Colors.red : null,
        onPressed: () => controller.toggleFavouriteProduct(productId),
      ),
    );
  }
}
