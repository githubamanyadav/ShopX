import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/common/widget/images/rounded_images.dart';
import 'package:e_commerce/features/shop/controller/home/home_controller.dart';
import 'package:flutter/material.dart';

class UPromotionSlider extends StatelessWidget {
  const UPromotionSlider({super.key, required this.banners});

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Column(
      children: [
        CarouselSlider(
          items: banners
              .map((element) => URoundedImage(imageUrl: element))
              .toList(),
          //this viewPortionFraction make sure only one image should be visible
          options: CarouselOptions(
            viewportFraction: 1.0,
            onPageChanged: ((index, reason) => controller.onPageChange(index)),
          ),
          carouselController: controller.carouselController,
        ),
      ],
    );
  }
}
