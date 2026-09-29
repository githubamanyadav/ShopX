// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce/utils/constants/colors.dart';

import 'package:e_commerce/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class UDivider extends StatelessWidget {
  const UDivider({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunction.isDarkMode(context);
    return SizedBox(
      width: double.infinity,

      child: Row(
        children: [
          Expanded(
            child: Divider(
              indent: 20,
              endIndent: 10,
              color: dark ? UColors.darkGrey : UColors.grey,
            ),
          ),
          Text(title, style: Theme.of(context).textTheme.labelMedium),
          Expanded(
            child: Divider(
              indent: 10,
              endIndent: 20,
              color: dark ? UColors.darkGrey : UColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
