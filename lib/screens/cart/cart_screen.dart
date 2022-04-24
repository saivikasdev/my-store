import 'package:flutter/material.dart';
import 'package:gadgets4u/models/Cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/body.dart';
import 'components/cart_card.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {


  static String routeName = "/cart";


  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;

  @override


  Widget build(BuildContext context) {



    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {

    final email = auth.currentUser!.email;
    CollectionReference<Map<String, dynamic>> cartproducts = users.doc(email,).collection('cart products');
    return AppBar(
      backgroundColor: Colors.deepOrangeAccent,
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
