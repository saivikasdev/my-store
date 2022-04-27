import 'package:gadgets4u/completeorder/verifyphonescreen.dart';
import 'package:gadgets4u/screens/cart/components/body.dart';
import 'package:flutter/material.dart';
import 'package:gadgets4u/components/default_button.dart';
import 'package:gadgets4u/models/Product.dart';
import 'package:gadgets4u/screens/cart/cart_screen.dart';
import 'package:gadgets4u/screens/details/components/phonenumber.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../size_config.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Body extends StatelessWidget {
  final List<dynamic> image;
  final String name;
  final String price;
  final String desc;
//  final String status;
  const Body({Key? key, required this.name,
    required this.image,
    required this.price,
    required this.desc,
    // required this.status,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(image:image,name:name,),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(name: name,
                image: image,
                price: price,
                desc:desc,
                // status:status,
                pressOnSeeMore: () {},
              ),

              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(0),
                          top: getProportionateScreenWidth(0),
                        ),

                        child: DefaultButton(
                          text: "Order now",
                          press: () => ordernow(context, image, name, price, desc)
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>phonenumber(context,image: image, price: price, desc: desc, name: name,)))
                        ),
                      ),
                    ),

                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(0),
                          top: getProportionateScreenWidth(0),
                        ),

                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () =>
                              addingtocart(context,image,name,price,desc,
                              // status
                              ),


                        ),
                      ),

                    ),
                  ],
                ),
              ),

              Text('Item added to cart cannot be removed',style: TextStyle(color: Colors.deepOrangeAccent),)
            ],
          ),
        ),
      ],
    );
  }
}

addingtocart(BuildContext context,image,name,price,desc) async{
  final sucBar = SnackBar(
    content: Text('Product added to cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18,
    ),
    ),backgroundColor: Colors.deepOrangeAccent,
  );
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String? email = auth.currentUser!.email;
  CollectionReference cartproducts = users.doc(email,).collection('cart products');

  try {
    await cartproducts.doc(name).set({
      'NAME': name,
      'image': image,
      'price' : price,
      'desc':desc,
      // 'status': status,
    });
    return
      ScaffoldMessenger.of(context).showSnackBar(sucBar,);
  } on FirebaseException catch (e) {
    print(e.toString());
  }

}




ordernow(BuildContext context,image,name,price,desc) async{
  final sucBar = SnackBar(
    content: Text('Product added to cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18,
    ),
    ),backgroundColor: Colors.deepOrangeAccent,
  );
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  FirebaseAuth auth = FirebaseAuth.instance;
  String? email = auth.currentUser!.email;
  CollectionReference userorders = users.doc(email,).collection('orders');
  try {
    await userorders.doc(name).set({
      'NAME': name,
      'image': image,
      'price' : price,
      'desc':desc,
      // 'status':status
    });

    await orders.doc(email).set({
      'NAME': name,
      'image': image,
      'price' : price,
      'desc':desc,
      // 'status':status

    });



    return
      Navigator.push (context, MaterialPageRoute(builder: (context)=> verifyphonescreen())
      );
  } on FirebaseException catch (e) {
    print(e.toString());
  }

}


















