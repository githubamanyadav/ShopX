import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/common/widget/chip/choice_chip.dart';
import 'package:e_commerce/common/widget/text/product_price_text.dart';
import 'package:e_commerce/common/widget/text/product_text_title.dart';
import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/features/shop/controller/product/variation_controller.dart';
import 'package:e_commerce/features/shop/models/products/products.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = UHelperFunction.isDarkMode(context);
    return Obx(
      () => Column(
        children: [
          // selected attribute & pricing & description
          if (controller.selectedVariation.value.id.isNotEmpty)
            URoundedContainer(
              padding: const EdgeInsets.all(USizes.sm),
              backgroundColor: dark ? UColors.darkGrey : UColors.grey,
              // title, price & stock
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const USectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                      const SizedBox(width: USizes.spaceBtwItems),

                      Column(
                        children: [
                          Row(
                            children: [
                              const UProductTextTitle(
                                title: 'Price : ',
                                smallSize: true,
                              ),
                              if (controller.selectedVariation.value.salePrice >
                                  0)
                                Text(
                                  "${UTexts.currency}${controller.selectedVariation.value.price.toStringAsFixed(0)}",
                                  style: Theme.of(context).textTheme.titleSmall!
                                      .apply(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                ),
                              const SizedBox(width: USizes.spaceBtwItems),
                              UProductPriceText(
                                price: controller.getVariationPrice(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const UProductTextTitle(
                                title: 'Stock : ',
                                smallSize: true,
                              ),
                              Text(
                                'In Stock',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  UProductTextTitle(
                    title:
                        controller.selectedVariation.value.description ?? " ",
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          const SizedBox(height: USizes.spaceBtwItems),

          // Attributes (e.g. Colors, Storage)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (product.productAttributes ?? []).map((attribute) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  USectionHeading(
                    title: attribute.name ?? '',
                    showActionButton: false,
                  ),
                  const SizedBox(height: USizes.spaceBtwItems / 2),
                  Obx(
                    () => Wrap(
                      spacing: USizes.sm,
                      children: (attribute.values ?? []).map((attributeValue) {
                        final isSelected =
                            controller.selectedAttributes[attribute.name] ==
                            attributeValue;
                        final available = controller
                            .getAttributesAvailabilityInVariation(
                              product.productVariations!,
                              attribute.name!,
                            )
                            .contains(attributeValue);

                        /// Chip is disabled (onSelected: null) when out of stock
                        return UChoiceChip(
                          text: attributeValue,
                          selected: isSelected,
                          onSelected: available
                              ? (selected) {
                                  if (available && selected) {
                                    controller.onAttributeSelected(
                                      product,
                                      attribute.name,
                                      attributeValue,
                                    );
                                  }
                                }
                              : null,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }).toList(), // <-- the fix: map() returns an Iterable, children needs a List
          ),
        ],
      ),
    );
  }
}
