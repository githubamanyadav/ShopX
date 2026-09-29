import 'package:e_commerce/features/personalization/screens/edit%20profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text("stark", style: Theme.of(context).textTheme.headlineSmall),
      subtitle: Text(
        "stark@gmail.com",
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(
        icon: Icon(Iconsax.edit),
        onPressed: () {
          Get.to(() => EditProfile());
        },
      ),
    );
  }
}
