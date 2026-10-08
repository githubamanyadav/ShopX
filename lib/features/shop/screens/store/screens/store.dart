import 'package:e_commerce/common/widget/appbar/tabbar.dart';
import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/common/widget/shimmer/brands_shimmer.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/brands/brands_controller.dart';

import 'package:e_commerce/features/shop/controller/category/category_controller.dart';

import 'package:e_commerce/features/shop/screens/all_brands/all_brands.dart';
import 'package:e_commerce/features/shop/screens/store/screens/widgets/category_tab.dart';
import 'package:e_commerce/features/shop/screens/store/screens/widgets/store_primary_header.dart';
import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    final brandController = Get.put(BrandController());

    return Obx(() {
      final categories = controller.featuredCategories;

      // A TabController with length 0 can crash, so wait for data
      if (categories.isEmpty) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return DefaultTabController(
        length: categories.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 340,
                  pinned: true,
                  floating: false,
                  flexibleSpace: SingleChildScrollView(
                    child: Column(
                      children: [
                        const UStorePrimaryHeader(),
                        SizedBox(height: USizes.spaceBtwSections / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: USizes.defaultSpace,
                          ),
                          child: Column(
                            children: [
                              USectionHeading(
                                title: "Brands",
                                onPressed: () => Get.to(() => AllBrands()),
                              ),
                              SizedBox(height: USizes.spaceBtwSections / 2),
                              SizedBox(
                                height: USizes.brandCardHeight,
                                child: Obx(() {
                                  if (brandController.featuredBrands.isEmpty) {
                                    return Text("Brands Not Found");
                                  }
                                  if (brandController.isLoading.value) {
                                    return UBrandsShimmer();
                                  }

                                  final brands = brandController.featuredBrands;
                                  return ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: USizes.spaceBtwItems),
                                    itemCount: brands.length,
                                    itemBuilder: (context, index) => SizedBox(
                                      width: USizes.brandCardWidth,
                                      child: UBrandCard(
                                        brandModel: brands[index],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: UTabBar(
                    tabs: categories
                        .map((category) => Tab(child: Text(category.name)))
                        .toList(),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: categories.map((category) => UCategoryTab()).toList(),
            ),
          ),
        ),
      );
    });
  }
}
