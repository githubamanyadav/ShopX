import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/products_card/products_card_vetrtical.dart';
import 'package:e_commerce/features/shop/controller/product/all_products_controller.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({super.key, required this.product});

  final List<ProductModel> product;

  @override
  Widget build(BuildContext context) {
    final controller = AllProductsController.instance;
    controller.assignProducts(product);
    return Column(
      children: [
        /// Filter Field
        DropdownButtonFormField(
          initialValue: controller.selectedSortOption.value,
          decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {
            if (value != null) {
              controller.sortProducts(value);
            }
          },
          items: ['Name', 'Lower Price', 'Higher Price', 'Sale', 'Newest'].map((
            filter,
          ) {
            return DropdownMenuItem(value: filter, child: Text(filter));
          }).toList(),
        ),
        SizedBox(height: USizes.spaceBtwSections),

        /// Products
        Obx(
          () => UGridLayout(
            itemCount: controller.products.length,
            itemBuilder: (context, index) =>
                UProductsCardVetrtical(product: controller.products[index]),
          ),
        ),
      ],
    );
  }
}
