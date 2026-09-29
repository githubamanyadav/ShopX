import 'package:e_commerce/common/widget/products/cart/cart_item/cart_item.dart';
import 'package:e_commerce/common/widget/products/cart/product_quantity_with_add_button.dart';
import 'package:e_commerce/common/widget/text/product_price_text.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({super.key, this.isShowButtons = true});
  final bool isShowButtons;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: USizes.spaceBtwItems),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Column(
          children: [
            //
            UCartItem(),

            if (isShowButtons) SizedBox(height: USizes.spaceBtwItems),
            if (isShowButtons)
              Row(
                children: [
                  UProductWithAddButton(),
                  Spacer(),
                  UProductPriceText(price: "400"),
                ],
              ),
          ],
        ); // Row
      },
    );
  }
}
