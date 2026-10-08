import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';

import 'package:e_commerce/features/shop/screens/all_brands/widgets/sortable_products.dart';

import 'package:flutter/material.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text("Brands", style: Theme.of(context).textTheme.headlineSmall),
        showArrowBack: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: USortableProducts(),
        ),
      ),
    );
  }
}
