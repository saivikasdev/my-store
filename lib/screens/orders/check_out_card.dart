import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gadgets4u/components/default_button.dart';
import 'package:gadgets4u/screens/complete_profile/complete_profile_screen.dart';
import '../../../constants.dart';
import '../../size_config.dart';
class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [

                Spacer(),
                const SizedBox(width: 10),

              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(child: Row(
                  children: [
                    Icon(Icons.category,color: Colors.black87,),
                    Text('  order Now:',style: TextStyle(fontSize: 16),)
                  ],
                ),),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> CompleteProfileScreen())),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

