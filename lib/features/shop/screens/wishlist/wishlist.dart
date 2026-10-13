import 'package:e_commerce/common/widget/animation/animation_loader.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/icon/circular_icon.dart';
import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/products_card/products_card_vetrtical.dart';
import 'package:e_commerce/common/widget/shimmer/vertical_shimmer_product.dart';
import 'package:e_commerce/features/shop/controller/product/favourite_controller.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:iconsax/iconsax.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    return Scaffold(
      appBar: UAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          UCircularIcon(
            icon: Iconsax.add4,
            onPressed: () =>
                NavigationController.instance.selectedIndex.value = 0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(USizes.md),
        child: SingleChildScrollView(
          child: Obx(
            () => FutureBuilder(
              future: controller.getFavouriteProducts(),
              builder: (context, snapshot) {
                // print(controller.favourites.values);
                //
                final nothingFound = UAnimationLoader(
                  text: "Wishlist is empty",
                  animation: UImages.pencilAnimation,
                  showActionButton: true,
                  actionText: "Let's add some",
                  onActionPressed: () =>
                      NavigationController.instance.selectedIndex.value = 0,
                );
                //
                const loader = UVerticalProductShimmer();

                //
                final widget = UCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot,
                  loader: loader,
                  nothingFound: nothingFound,
                );
                if (widget != null) return widget;
                final List<ProductModel> products = snapshot.data!;
                return UGridLayout(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    print(products[index]);
                    return UProductsCardVetrtical(product: products[index]);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
