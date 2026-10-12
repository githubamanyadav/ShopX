import 'package:e_commerce/common/widget/brands/brand_showcase.dart';
import 'package:e_commerce/common/widget/shimmer/boxes_shimmer.dart';
import 'package:e_commerce/common/widget/shimmer/list_tile_shimmer.dart';
import 'package:e_commerce/features/shop/controller/brands/brands_controller.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';

import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandForCategory(category.id),
      builder: (context, snapshot) {
        //shimmer effect

        const loader = Column(
          children: [
            UListTileShimmer(),
            SizedBox(height: USizes.spaceBtwItems),
            UBoxesShimmer(),
            SizedBox(height: USizes.spaceBtwItems),
          ],
        );

        //widgets from the error
        final widget = UCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          loader: loader,
        );
        if (widget != null) return widget;

        final brand = snapshot.data!;
        final brands = snapshot.data;
        if (brands == null || brands.isEmpty) {
          return const Text('No brands found');
        }

        return ListView.builder(
          itemCount: brand.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // print(
            //   '${brand[index].id} | ${brand[index].name} | ${brand[index].image}',
            // );
            return FutureBuilder(
              future: controller.getBrandProduct(brand[index].id, limit: 3),
              builder: (context, snapshot) {
                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                );
                if (widget != null) {
                  return widget;
                }
                final products = snapshot.data!;

                return UBrandShowcase(
                  brand: brand[index],
                  images: products.map((product) => product.thumbnail).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}
