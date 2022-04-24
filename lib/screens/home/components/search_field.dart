
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../size_config.dart';
class SearchField extends StatelessWidget {

  CollectionReference products = FirebaseFirestore.instance.collection('products');
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.7,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0),
        borderRadius: BorderRadius.circular(17),
      ),
      child: Container(
          child: Text('MYSTORE',style: TextStyle(fontSize: 25,color: Colors.black45,),))






      //TextField(onChanged: (value) {print(value);}, decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20), vertical: getProportionateScreenWidth(9)), border: InputBorder.none, focusedBorder: InputBorder.none, enabledBorder: InputBorder.none, hintText: "Search product", prefixIcon: Icon(Icons.search)),),
    );
  }
}