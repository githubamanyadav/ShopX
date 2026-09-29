import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class USingleAddress extends StatelessWidget {
  const USingleAddress({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return URoundedContainer(
      width: double.infinity,
      showBorder: true,
      borderColor: isSelected ? Colors.transparent : UColors.primary,
      backgroundColor: isSelected
          ? UColors.primary.withValues(alpha: 0.5)
          : Colors.transparent,
      padding: EdgeInsets.all(USizes.md),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Name
              Text(
                'Unknown Pro',
                style: Theme.of(context).textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: USizes.spaceBtwItems / 2),

              /// Phone Number
              Text(
                '+92 312345678',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: USizes.spaceBtwItems / 2),

              /// Address
              Text(
                'House No.295, Hyderabad, Sindh, Pakistan',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),

          if (isSelected)
            Positioned(
              top: 0,
              bottom: 0,
              right: 7,

              child: Icon(
                Iconsax.tick_circle5,
                color: dark ? UColors.white : UColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}
