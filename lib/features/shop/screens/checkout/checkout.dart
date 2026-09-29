import 'package:e_commerce/common/custom_shapes/clipper/rounded_container.dart';
import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/common/widget/products/cart/cart_item/cart_item.dart';
import 'package:e_commerce/common/widget/screens/success_screen.dart';
import 'package:e_commerce/common/widget/textfields/promo_code_field.dart';
import 'package:e_commerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/amount_billing_section.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:e_commerce/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:e_commerce/navigation_menu.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/images.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: UAppBar(showArrowBack: true, title: Text(" Order review")),

      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Column(
            children: [
              UCartItems(isShowButtons: false),
              SizedBox(height: USizes.spaceBtwSections),

              /// Promo code - TextField
              UPromoCodeField(), // URoundedContainer
              //billing section
              SizedBox(height: USizes.spaceBtwItems),
              URoundedContainer(
                padding: EdgeInsets.all(USizes.md),
                showBorder: true,
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    /// Amount billing section
                    UAmountBillingSection(), // Column\
                    //
                    SizedBox(height: USizes.spaceBtwItems),
                    Divider(),
                    SizedBox(height: USizes.spaceBtwItems),
                    //billing options
                    UBillingPaymentSection(),
                    SizedBox(height: USizes.spaceBtwItems),

                    //User adress details
                    UBillingAddressSection(),

                    //
                  ],
                ), // Column,
              ),
              SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        ),
      ),

      /// ------[BottomNavigation]------
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: UElevatedButton(
          onPressed: () {
            Get.to(
              () => SuccessScreen(
                image: UImages.successfulPaymentIcon,
                title: "payment successful!",
                subtitle: " Your item will be shipped soon! ",
                onTap: () => Get.offAll(() => NavigationMenu()),
              ),
            );
          },
          child: Text('Checkout \$263527'),
        ),
      ), // Padding
    );
  }
}
