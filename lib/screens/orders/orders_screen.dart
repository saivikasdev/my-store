import 'package:flutter/material.dart';
import 'package:gadgets4u/components/coustom_bottom_nav_bar.dart';
import 'package:gadgets4u/models/cart.dart';
import 'package:gadgets4u/screens/cart/components/check_out_card.dart';
import '../../enums.dart';
import 'package:gadgets4u/screens/orders/body.dart';
class orderscreen extends StatelessWidget {
  static String routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body:Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.orders),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Orders placed by you",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
