
import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(),
      ),
      body: Body(name: agrs.name,price: agrs.price,image: agrs.image,desc:agrs.desc,status: agrs.status,),
    );
  }
}

class ProductDetailsArguments {
  final String name;
  final int price;
  final List<dynamic> image;
  final String desc;
  final String status;

  ProductDetailsArguments({
    required this.name,
  required this.price,
  required this.image,
    required this.desc,
    required this.status,

  });
}
