import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/features/personalization/screens/address/add_new_adress.dart';
import 'package:e_commerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';

class UAdress extends StatelessWidget {
  const UAdress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showArrowBack: true,
        title: Text(
          "Addresses",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),

      /// -----[Body]-----
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Column(
            children: [
              USingleAddress(isSelected: true),
              SizedBox(height: USizes.spaceBtwItems), // Column
              USingleAddress(isSelected: false), // Column
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: UColors.primary,
        onPressed: () {
          Get.to(() => AddNewAdress());
        },
        child: Icon(Iconsax.add, color: UColors.white),
      ), // URoundedContainer
    );
  }
}
