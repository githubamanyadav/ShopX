import 'package:e_commerce/common/widget/appbar/tabbar.dart';
import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/screens/all_brands/all_brands.dart';
import 'package:e_commerce/features/shop/screens/store/screens/widgets/category_tab.dart';
import 'package:e_commerce/features/shop/screens/store/screens/widgets/store_primary_header.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 340,
                pinned: true,
                floating: false,
                //upper header with search box
                flexibleSpace: SingleChildScrollView(
                  child: Column(
                    children: [
                      //primary header
                      const UStorePrimaryHeader(),
                      SizedBox(height: USizes.spaceBtwSections / 2),

                      //Brand card
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: USizes.defaultSpace,
                        ),
                        child: Column(
                          children: [
                            //
                            USectionHeading(
                              title: "Brands",
                              onPressed: () {
                                Get.to(() => AllBrands());
                              },
                            ),

                            SizedBox(height: USizes.spaceBtwSections / 2),

                            SizedBox(
                              height: USizes.brandCardHeight,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: USizes.spaceBtwItems),
                                itemCount: 10,
                                itemBuilder: (context, index) => SizedBox(
                                  width: USizes.brandCardWidth,

                                  child: const UBrandCard(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //
                    ],
                  ),
                ),

                //scrolling the categories
                bottom: UTabBar(
                  tabs: [
                    Tab(child: Text("Sports")),
                    Tab(child: Text("Furniture")),
                    Tab(child: Text("Electronics")),
                    Tab(child: Text("Sports")),
                    Tab(child: Text("Sports")),
                  ],
                ),
                //brand heading
              ),
            ];
          },
          //bottom brandshow case cateogories
          body: TabBarView(
            children: [
              UCategoryTab(),
              UCategoryTab(),
              UCategoryTab(),
              UCategoryTab(),
              UCategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
