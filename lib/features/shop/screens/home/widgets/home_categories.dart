import 'package:e_commerce/common/widget/image_text/vertical_image.dart';
import 'package:e_commerce/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            UTexts.popularCategories,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: UColors.white),
          ),
          SizedBox(height: USizes.spaceBtwItems),
          //Home categories
          SizedBox(
            height: 80,
            child: ListView.separated(
              separatorBuilder: (context, Index) =>
                  SizedBox(width: USizes.spaceBtwItems),

              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return UVerticalImage(
                  onTap: () {
                    Get.to(() => SubCategories());
                  },
                  image: UImages.sportsIcon,
                  title: "sports",
                  textColor: UColors.white,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
