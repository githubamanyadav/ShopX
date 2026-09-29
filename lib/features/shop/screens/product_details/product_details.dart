import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/common/widget/chip/choice_chip.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:e_commerce/features/shop/screens/product_details/widgets/product_thumbnail_slider.dart';
import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return Scaffold(
      /// -----[Body]-----
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: Upadding.screenPadding,
              child: Column(
                children: [
                  /// -----[Product Image With Slider]-----
                  UProductThumbnailAndSlider(dark: dark), // Stack
                  /// -----[Product Details]-----
                  /// Price, Title, Stock And Brand
                  UProductMetaData(),

                  ///
                  UProductAttributes(),
                  SizedBox(height: USizes.spaceBtwItems),

                  /// Attributes
                  /// Attributes

                  // Column
                  /// Checkout Button
                  UElevatedButton(onPressed: () {}, child: Text("Check out")),
                  SizedBox(height: USizes.spaceBtwItems),

                  /// Description
                  ///
                  ReadMoreText(
                    'This is a product of iPhone 11 with 512 GB, This is a product of iPhone 11 with 512 GB This is a product of iPhone 11 with 512 GB, This is a product of iPhone 11 with 512 GB',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: USizes.spaceBtwSections), // ReadMoreText
                ],
              ),
            ),
          ],
        ), // Column
      ), // SingleChildScrollView
      /// -----[Bottom Navigation]-----
      bottomNavigationBar: UBottomAddToCart(),
    ); // Scaffold
  }
}
