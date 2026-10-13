import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/features/personalization/models/address/address_model.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class USingleAddress extends StatelessWidget {
  const USingleAddress({
    super.key,
    required this.isSelected,
    required this.address,
  });

  final bool isSelected;
  final AddressModel address;

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
                '+91${address.phoneNumber}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: USizes.spaceBtwItems / 2),

              /// Address
              Text(
                address.toString(),
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
