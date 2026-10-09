import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/brands/brand_cards.dart';
import 'package:e_commerce/features/shop/models/brands/brands_model.dart';
import 'package:e_commerce/features/shop/screens/all_brands/widgets/sortable_products.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class BrandProductsScreen extends StatelessWidget {
  const BrandProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showArrowBack: true,
        title: Text('Bata', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Column(
            children: [
              UBrandCard(brandModel: BrandModel.empty()),
              SizedBox(height: USizes.spaceBtwSections),

              USortableProducts(product: []),
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
