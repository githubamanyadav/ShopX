import 'package:e_commerce/common/style/padding.dart';
import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/common/widget/button/elevated_button.dart';
import 'package:e_commerce/features/personalization/screens/controller/address/adress_controller.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/validator/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAdress extends StatelessWidget {
  const AddNewAdress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: const UAppBar(
        showArrowBack: true,
        title: Text("Add New Address"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              children: [
                /// Name
                TextFormField(
                  controller: controller.name,
                  validator: (value) =>
                      UValidator.validateEmptyText('Name', value),

                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: USizes.spaceBtwInputFields),

                /// Phone Number
                TextFormField(
                  controller: controller.phoneNumber,
                  validator: (value) =>
                      UValidator.validateEmptyText('Phone Number', value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: USizes.spaceBtwInputFields),

                /// Street & Postal Code
                Row(
                  children: [
                    /// Street
                    Expanded(
                      child: TextFormField(
                        validator: (value) =>
                            UValidator.validateEmptyText('Street', value),
                        controller: controller.street,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'Street',
                        ),
                      ),
                    ),
                    const SizedBox(width: USizes.spaceBtwInputFields),

                    /// Postal Code
                    Expanded(
                      child: TextFormField(
                        validator: (value) =>
                            UValidator.validateEmptyText('Postal Code', value),
                        controller: controller.postalCode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                        ),
                      ),
                    ),
                  ],
                ), // Row
                const SizedBox(height: USizes.spaceBtwInputFields),

                /// City & State
                Row(
                  children: [
                    /// City
                    Expanded(
                      child: TextFormField(
                        validator: (value) =>
                            UValidator.validateEmptyText('City', value),
                        controller: controller.city,

                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                      ),
                    ),
                    const SizedBox(width: USizes.spaceBtwInputFields),

                    /// State
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        validator: (value) =>
                            UValidator.validateEmptyText('State', value),

                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.activity),
                          labelText: 'State',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: USizes.spaceBtwItems),
                UElevatedButton(
                  onPressed: () {
                    controller.addNewAddress();
                  },
                  child: Text("Save"),
                ),
                // Row
              ], // Column children
            ),
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
