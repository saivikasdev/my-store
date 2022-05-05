import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gadgets4u/models/Cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gadgets4u/screens/home/components/popular_product.dart';
import '../../../size_config.dart';
import 'cart_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gadgets4u/models/Cart.dart';
import 'package:gadgets4u/screens/complete_profile/components/complete_profile.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    String? email = FirebaseAuth.instance.currentUser!.email;
    Stream<QuerySnapshot<Map<String, dynamic>>> cartproducts = users
        .doc(
          email,
        )
        .collection('cart products')
        .snapshots();
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: cartbuilder(),
      ),
    );
  }
}

class cartbuilder extends StatelessWidget {
  cartbuilder({Key? key}) : super(key: key);

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final Function profiletofirebase;
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('products').snapshots();
    final email = auth.currentUser!.email;
    Stream<QuerySnapshot<Map<String, dynamic>>> cartproducts = users
        .doc(
          email,
        )
        .collection('cart products')
        .snapshots();
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
          stream: cartproducts,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print(
                  '////////////////////////////////////////////////////////////////////////////////////////');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.deepOrangeAccent,
                ),
              );
            } else {
              Center(child: CircularProgressIndicator());
            }

            return ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return SizedBox(
                  child: SingleChildScrollView(
                      child: CartCard(
                          image: data['image'],
                          name: data['NAME'],
                          price: data['price'],
                          desc: data['desc'],
                      )),
                );
              }).toList(),
            );
          }),
    );
  }
}
