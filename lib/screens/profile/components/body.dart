

import 'package:flutter/material.dart';
import 'package:gadgets4u/screens/cart/cart_screen.dart';
import 'package:gadgets4u/screens/contact_screen/contact.dart';
import 'package:gadgets4u/screens/home/home_screen.dart';
import 'package:gadgets4u/screens/orders/orders_screen.dart';
import 'package:gadgets4u/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constants.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var SvgPicture;
    FirebaseAuth auth = FirebaseAuth.instance;
    String? email = auth.currentUser!.email;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            style: TextButton.styleFrom(
              primary: kPrimaryColor,
              padding: EdgeInsets.all(20),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              backgroundColor: Color(0xFFF5F6F9),
            ),
            onPressed: ()=> null,
            child: Row(
              children: [
                Icon(Icons.account_circle,color: Colors.black87,),
                SizedBox(width: 20),
                Expanded(child: Text('$email.',style: TextStyle(color:Colors.black),)),
              ],
            ),
          ),
        ),
          ProfileMenu(
            text: "Back to home",
            icon: "assets/icons/Shop Icon.svg",
              press:() =>
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> HomeScreen()), (route) => false)
          ),
          ProfileMenu(
            text: "My orders",
            icon: "assets/icons/Cash.svg",
              press:() =>
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> orderscreen()), (route) => false)
          ),
          ProfileMenu(
            text: "View cart",
            icon: "assets/icons/Cart Icon.svg",
            press: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
          ProfileMenu(
            text: "Contact us",
            icon: "assets/icons/Question mark.svg",
              press:() =>
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> contactscreen()), (route) => false)
          ),
          ProfileMenu(
              text: "Logout",
              icon: "assets/icons/Log out.svg",
              press:() =>signout(context),
          ),
        ],
      ),
    );
  }
}

  Future<Object> signout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx)=> SplashScreen()), (route) => false);
  }
