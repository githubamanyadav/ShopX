import 'package:e_commerce/common/widget/layouts/grid_layout.dart';
import 'package:e_commerce/common/widget/products/products_card/products_card_vetrtical.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/models/category_model.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/features/shop/screens/store/screens/widgets/category_brands.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UCategoryTab extends StatelessWidget {
  const UCategoryTab({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(USizes.defaultSpace),
          child: Column(
            children: [
              CategoryBrands(),

              USectionHeading(title: "You might like"),

              UGridLayout(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return UProductsCardVetrtical(product: ProductModel.empty());
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
