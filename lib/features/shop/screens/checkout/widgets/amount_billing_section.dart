import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UAmountBillingSection extends StatelessWidget {
  const UAmountBillingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Subtotal',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('\$343', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ), // Row
        SizedBox(height: USizes.spaceBtwItems / 2),
        Row(
          children: [
            Expanded(
              child: Text(
                'Shipping fee',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('\$343', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ), // Row
        SizedBox(height: USizes.spaceBtwItems / 2),
        Row(
          children: [
            Expanded(
              child: Text(
                'Tax fee',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('\$343', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ), // Row
        SizedBox(height: USizes.spaceBtwItems / 2),
        Row(
          children: [
            Expanded(
              child: Text(
                'Order Total',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Text('\$343', style: Theme.of(context).textTheme.titleMedium),
          ],
        ), // Row
      ],
    );
  }
}
