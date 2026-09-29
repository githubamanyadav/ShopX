import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return ListView.separated(
      // shrinkWrap: true,

      // physics: ScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: USizes.spaceBtwSections / 2),
      itemCount: 10,
      itemBuilder: (context, index) => Padding(
        padding: Upadding.screenPadding,
        child: URoundedContainer(
          backgroundColor: dark ? UColors.dark : UColors.light,
          showBorder: true,
          padding: EdgeInsets.all(USizes.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 1 - Row
              Row(
                children: [
                  Icon(Iconsax.ship),
                  SizedBox(width: USizes.spaceBtwItems / 2),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Processing',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.apply(color: UColors.primary),
                        ),
                        Text(
                          '01 Jan 2025',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ), // Column
                  ), // Expanded

                  IconButton(
                    onPressed: () {},
                    icon: Icon(Iconsax.arrow_right_34, size: USizes.iconSm),
                  ),
                ],
              ), // Row

              SizedBox(height: USizes.spaceBtwItems),

              /// 2 - Row
              Row(
                children: [
                  //order id
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Iconsax.tag),
                        SizedBox(width: USizes.spaceBtwItems / 2),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'order',
                                style: Theme.of(context).textTheme.labelMedium!
                                    .apply(color: UColors.darkGrey),
                              ),
                              Text(
                                '#23434534',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            ],
                          ), // Column
                        ), // Expanded
                      ],
                    ),
                  ),

                  //calender date
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Iconsax.calendar),
                        SizedBox(width: USizes.spaceBtwItems / 2),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shipping date',
                                style: Theme.of(context).textTheme.labelMedium!
                                    .apply(color: UColors.darkGrey),
                              ),
                              Text(
                                '06 jan 2026',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                            ],
                          ), // Column
                        ), // Expanded
                      ],
                    ),
                  ),
                ],
              ), // Row
            ],
          ), // Column
        ),
      ),
    );
  }
}
