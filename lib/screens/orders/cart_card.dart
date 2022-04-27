import 'package:flutter/material.dart';
import 'package:gadgets4u/models/Cart.dart';
import 'package:gadgets4u/screens/details/details_screen.dart';

import '../../../constants.dart';
import '../../size_config.dart';
class CartCard extends StatelessWidget {
  const CartCard({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.desc,

  }) : super(key: key);

  final String desc;
  final String name;
  final String price;
  final List<dynamic> image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFF5F6F9),borderRadius: BorderRadius.circular(30)),
      child: GestureDetector(
        onTap: ()=> Navigator.pushNamed(context,DetailsScreen.routeName,arguments: ProductDetailsArguments(name: 
        name,image: image,price: price,desc:desc,
        // status: status,
        ),),
        child: Row(
          children: [
            SizedBox(
              width: 88,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:Image.network(image[0])
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  maxLines: 2,
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "${price}/-",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: kPrimaryColor),
                    children: [
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
