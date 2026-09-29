import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/common/widget/chip/choice_chip.dart';
import 'package:e_commerce/common/widget/text/product_price_text.dart';
import 'package:e_commerce/common/widget/text/product_text_title.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return Column(
      children: [
        //selected attribute & pricing  & description
        URoundedContainer(
          padding: EdgeInsets.all(USizes.sm),
          backgroundColor: dark ? UColors.darkGrey : UColors.grey,
          //title, price & stock
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  USectionHeading(title: 'Variation', showActionButton: false),
                  SizedBox(width: USizes.spaceBtwItems),

                  Column(
                    children: [
                      Row(
                        children: [
                          UProductTextTitle(title: 'Price : ', smallSize: true),
                          //
                          Text(
                            '250',
                            style: Theme.of(context).textTheme.titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(width: USizes.spaceBtwItems),
                          //
                          UProductPriceText(price: '200'),
                        ],
                      ),

                      Row(
                        children: [
                          UProductTextTitle(title: 'Stock : ', smallSize: true),
                          Text(
                            'In Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              //
              UProductTextTitle(
                title: "this is a product  of iphone 11  with 512Gb ",
                maxLines: 2,
              ),
            ],
          ),
        ),
        SizedBox(height: USizes.spaceBtwItems),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Colors', showActionButton: false),
            SizedBox(height: USizes.spaceBtwItems / 2),
            Wrap(
              spacing: USizes.sm,
              children: [
                UChoiceChip(
                  text: 'Red',
                  selected: true,
                  onSelected: (value) {},
                ),
                UChoiceChip(
                  text: 'Blue',
                  selected: false,
                  onSelected: (value) {},
                ),
                UChoiceChip(
                  text: 'Yellow',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ), // Wrap
          ],
        ),
        //
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Sizes', showActionButton: false),
            SizedBox(height: USizes.spaceBtwItems / 2),
            Wrap(
              spacing: USizes.sm,
              children: [
                UChoiceChip(
                  text: 'medium',
                  selected: true,
                  onSelected: (value) {},
                ),
                UChoiceChip(
                  text: 'Blue',
                  selected: false,
                  onSelected: (value) {},
                ),
                UChoiceChip(
                  text: 'Yellow',
                  selected: false,
                  onSelected: (value) {},
                ),
              ],
            ), // Wrap
          ],
        ),
      ],
    );
  }
}
