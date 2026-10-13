import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/features/personalization/models/address/address_model.dart'
    show AddressModel;
import 'package:e_commerce/features/personalization/screens/address/add_new_adress.dart';
import 'package:e_commerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:e_commerce/features/personalization/screens/controller/address/adress_controller.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';

class UAdress extends StatelessWidget {
  const UAdress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
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
          child: FutureBuilder(
            future: controller.getAllAddress(),
            builder: (context, snapshot) {
              /// Handle Error, Loading, Empty
              final widget = UCloudHelperFunctions.checkMultiRecordState(
                snapshot: snapshot,
              );
              if (widget != null) return widget;

              /// Data Found - Addresses Found
              List<AddressModel> addresses = snapshot.data!;

              return ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(height: USizes.spaceBtwItems),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  return USingleAddress(isSelected: true, address: address);
                },
              );
            },
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
