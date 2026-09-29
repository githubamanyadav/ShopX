import 'package:e_commerce/common/widget/text/section_heading.dart';
import 'package:e_commerce/data/repository/authentication_repository.dart';
import 'package:e_commerce/features/personalization/screens/address/adress.dart';
import 'package:e_commerce/features/personalization/screens/widgets/profile_primary_header.dart';
import 'package:e_commerce/features/personalization/screens/widgets/setting_menu_tile.dart';
import 'package:e_commerce/features/personalization/screens/widgets/user_profile_tile.dart';
import 'package:e_commerce/features/shop/screens/order/orders.dart';
import 'package:e_commerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AuthenticationRepository.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //primary header
            UProfileHeader(),
            Padding(
              padding: EdgeInsetsGeometry.all(USizes.md),
              child: Column(
                children: [
                  //user profile tile
                  UserProfileTile(),

                  //
                  SizedBox(height: USizes.spaceBtwItems),
                  // Account Settings Heading
                  USectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),

                  // Settings Menu
                  /// Settings Menu
                  SettingsMenuTile(
                    onTap: () {
                      Get.to(() => UAdress());
                    },
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subtitle: 'Set shopping delivery addresses',
                  ),
                  SettingsMenuTile(
                    onTap: () {},
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subtitle: 'Add, remove products and move to checkout',
                  ),
                  SettingsMenuTile(
                    onTap: () {
                      Get.to(() => OrdersScreen());
                    },
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subtitle: 'In-progress and Completed Orders',
                  ), // ListTi

                  SizedBox(height: USizes.spaceBtwItems),

                  /// Logout
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: controller.logout,
                      child: Text('Logout'),
                    ),
                  ), // SizedBox
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
