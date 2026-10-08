import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/common/widget/images/rounded_images.dart';
import 'package:e_commerce/common/widget/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/shop/controller/banner/banner_controller.dart';
import 'package:e_commerce/features/shop/controller/home/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class UPromotionSlider extends StatelessWidget {
  const UPromotionSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    final bannercontroller = Get.put(BannerController());

    return Obx(() {
      if (bannercontroller.isLoading.value) {
        return UShimmerEffect(width: double.infinity, height: 190);
      }
      if (bannercontroller.banners.isEmpty) {
        return Text("No banner found");
      }
      return Column(
        children: [
          CarouselSlider(
            items: bannercontroller.banners
                .map(
                  (banner) => URoundedImage(
                    imageUrl: banner.imageUrl,
                    isNetworkImage: true,
                  ),
                )
                .toList(),
            //this viewPortionFraction make sure only one image should be visible
            options: CarouselOptions(
              viewportFraction: 1.0,
              onPageChanged: ((index, reason) =>
                  controller.onPageChange(index)),
            ),
            carouselController: controller.carouselController,
          ),
        ],
      );
    });
  }
}
