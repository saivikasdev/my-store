
import 'package:flutter/material.dart';

import 'body.dart';

class verifyphonescreen extends StatelessWidget {
  final List<dynamic> image;
  final String name;
  final String price;
  final String desc;

  const verifyphonescreen({Key? key, required this.name,
    required this.image,
    required this.price,
    required this.desc,
    // required this.status,

  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(name: name,price: price,image: image,desc:desc,),
    );
  }
}