import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/products/cart/cart_counter_icon.dart';
import 'package:e_commerce/common/widget/shimmer/shimmer_effect.dart';
import 'package:e_commerce/features/personalization/screens/controller/user_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/helpers/helper_function.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UHomeAppBar extends StatelessWidget {
  const UHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return UAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title for the App bar
          Text(
            UHelperFunction.getGreetingMessage(),
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.apply(color: UColors.grey),
          ),
          //subtitle for the App Bar
          Obx(() {
            if (controller.profileLoading.value) {
              return UShimmerEffect(width: 80, height: 15);
            }
            return Text(
              controller.user.value.fullName,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.apply(color: UColors.white),
            );
          }),
        ],
      ),
      actions: [UCartCounterIcon()],

      // shoping Icons bag
    );
  }
}
