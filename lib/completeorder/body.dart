// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gadgets4u/constants.dart';

import '../size_config.dart';
import 'verify phone.dart';

class Body extends StatelessWidget {
  final List<dynamic> image;
  final String name;
  final String price;
  final String desc;

  const Body({Key? key, required this.name,
    required this.image,
    required this.price,
    required this.desc,
    // required this.status,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("Enter your phone number", style: headingStyle),
                SizedBox(height: 20,),
                Text(
                  "Our member will call you in few minutes",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                verifyphone(


                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "By continuing your confirm that you agree \nwith our Term and Condition",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
