import 'package:e_commerce/common/widget/images/rounded_images.dart';
import 'package:e_commerce/common/widget/text/brand_title_with_verification_icon.dart';
import 'package:e_commerce/common/widget/text/product_text_title.dart';
import 'package:e_commerce/features/shop/models/cart_system/cart_item_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class UCartItem extends StatelessWidget {
  const UCartItem({super.key, required this.cartItem});
  final CartItemModel cartItem;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return Row(
      children: [
        /// Product Image
        URoundedImage(
          imageUrl: cartItem.image ?? " ",
          isNetworkImage: true,
          height: 60.0,
          width: 60.0,
          padding: EdgeInsets.all(USizes.md),

          backgroundColor: dark ? UColors.darkerGrey : UColors.light,
        ), // URoundedImage
        SizedBox(width: USizes.spaceBtwItems),

        /// Brand, Name, Variation
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UBrandTitleWithVerifyIcon(title: cartItem.brandName ?? " "),
              UProductTextTitle(title: cartItem.title),

              //detail of the products
              /// Variation OR Attributes
              RichText(
                text: TextSpan(
                  children: (cartItem.selectedVariation ?? {}).entries
                      .map(
                        (item) => TextSpan(
                          children: [
                            TextSpan(
                              text: item.key,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: item.value,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ), // TextSpan, RichText
            ],
          ),
        ), // Column, Expanded
      ],
    );
  }
}
