import 'package:e_commerce/common/widget/brands/brand_showcase.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:flutter/material.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return UBrandShowcase(
      images: [
        UImages.productImage11,
        UImages.productImage11,
        UImages.productImage11,
      ],
    );
  }
}
