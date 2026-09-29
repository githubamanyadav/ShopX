import 'package:e_commerce/common/style/padding.dart';

import 'package:e_commerce/common/widget/button/elevated_button.dart';

import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/constants/text.dart';
import 'package:e_commerce/utils/helpers/device_helper.dart';

import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String image, title, subtitle;

  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyActions: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: Upadding.screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: UDeviceHelper.getScreenHeight(context) * 0.4,
              ),
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: USizes.spaceBtwInputFields),
              Text(subtitle, textAlign: TextAlign.center),

              SizedBox(height: USizes.spaceBtwSections),

              UElevatedButton(onPressed: onTap, child: Text(UTexts.uContinue)),
            ],
          ),
        ),
      ),
    );
  }
}
