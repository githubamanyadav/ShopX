import 'package:e_commerce/common/widget/appbar/app_bar.dart';
import 'package:e_commerce/features/shop/screens/order/widgets/order_list.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(title: Text("My Orders"), showArrowBack: true),
      body: Column(children: [Expanded(child: OrderList())]),
    );
  }
}
