import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadgets4u/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.desc,
    required this.status,
    this.pressOnSeeMore,
  }) : super(key: key);

  final String name;
  final List<dynamic> image;
  final int price;
  final String desc;
  final String status;

  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
            name,
            style: TextStyle(fontSize: 30,color: Colors.deepOrangeAccent),
          ),


        SizedBox(
          height: 6,
        ),
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(0)),
          child: Text(
            '$price/-',
            style: TextStyle(fontSize: 20,color: Colors.black87),
          ),
        ),

        Text(
          '$status',
          style: TextStyle(fontSize: 10,color: Colors.black45),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(10),
            right: getProportionateScreenWidth(64),
          ),
          child:
              Text(
                desc,
              ),
          ),

      ],
    );
  }
}
