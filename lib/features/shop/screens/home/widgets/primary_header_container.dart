import 'package:e_commerce/common/custom_shapes/circular_container.dart';
import 'package:e_commerce/common/custom_shapes/rounded_edges.dart';

import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/device_helper.dart';
import 'package:flutter/material.dart';

class UPrimaryHeaderContainer extends StatelessWidget {
  const UPrimaryHeaderContainer({
    super.key,
    required this.child,
    required this.height,
  });

  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return URoundedEdges(
      child: Container(
        height: height,
        width: UDeviceHelper.getScreenWidth(context),
        color: UColors.primary,
        child: Stack(
          children: [
            //first transparent circle
            Positioned(
              top: -120,
              right: -220,
              child: ClipPath(
                child: UCircularContainer(
                  height: USizes.homePrimaryHeaderHeight,
                  width: UDeviceHelper.getScreenHeight(context) * 0.4,
                  backgroundColor: UColors.white.withValues(alpha: 0.1),
                ),
              ),
            ),

            //second transparent circle
            Positioned(
              top: 120,
              bottom: -40,
              right: -250,
              child: UCircularContainer(
                height: USizes.homePrimaryHeaderHeight,
                width: UDeviceHelper.getScreenHeight(context) * 0.4,
                backgroundColor: UColors.white.withValues(alpha: 0.1),
              ),
            ),
            // Container(
            //   height: UDeviceHelper.getScreenHeight(context) * 0.4,
            //   // width: UDeviceHelper.getScreenHeight(context) * 0.4,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(500),
            //     color: UColors.white.withValues(alpha: 0.5),
            //   ),
            // ),
            child,
          ],
        ),
      ),
    );
  }
}
