import 'package:e_commerce/common/widget/image_text/vertical_image.dart';
import 'package:e_commerce/features/shop/controller/category/category_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/screens/sub_categories/sub_categories.dart';
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
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
          Obx(() {
            final categories = controller.featuredCategories;

            if (controller.isCategoriesLoading.value) {
              return CircularProgressIndicator();
            }
            if (categories.isEmpty) {
              return Text("Categories not found");
            }
            //
            return SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),

                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  CategoryModel model = categories[index];
                  return UVerticalImage(
                    onTap: () {
                      Get.to(() => SubCategories());
                    },
                    image: model.image,
                    title: model.name,
                    textColor: UColors.white,
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
