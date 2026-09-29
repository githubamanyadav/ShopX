import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/products_card/products_card_vetrtical.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/common/widget/textfields/search_bar.dart';
import 'package:e_commerce/features/shop/controller/home/home_controller.dart';
import 'package:e_commerce/features/shop/screens/all_products/all_products.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/home_app_bar.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/primary_header_container.dart';
import 'package:e_commerce/features/shop/screens/home/widgets/product_card_vertical.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // the
    final controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //
          children: [
            ///Upper part of the Home screen
            Stack(
              children: [
                ///total height + extra 20
                SizedBox(height: USizes.homePrimaryHeaderHeight + 30),
                UPrimaryHeaderContainer(
                  height: USizes.homePrimaryHeaderHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UHomeAppBar(),
                      SizedBox(height: USizes.spaceBtwSections),
                      //Home-categories
                      UHomeCategories(),
                    ],
                  ),
                ),
                //search bar
                USearchBar(),
              ],
            ),
            // Lower part
            //slidern carousel
            Padding(
              padding: EdgeInsetsGeometry.all(USizes.defaultSpace),
              child: UPromotionSlider(
                banners: [
                  UImages.homeBanner1,
                  UImages.homeBanner2,
                  UImages.homeBanner3,
                  UImages.homeBanner4,
                  UImages.homeBanner5,
                ],
              ),
            ),

            // BannerDotNavigation(pageController: PageController()),
            SizedBox(height: USizes.spaceBtwItems),

            Padding(
              padding: EdgeInsetsGeometry.all(USizes.defaultSpace),
              child: USectionHeading(
                title: "Popular categories",
                onPressed: () {
                  Get.to((() => AllProducts()));
                },
              ),
            ),

            SizedBox(height: USizes.spaceBtwItems / 2),

            //product card vetical
            Padding(
              padding: const EdgeInsets.all(USizes.md),
              child: UGridLayout(
                itemCount: 10,
                itemBuilder: (BuildContext, index) {
                  return UProductsCardVetrtical();
                },
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
