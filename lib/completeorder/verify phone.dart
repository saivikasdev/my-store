import 'package:flutter/material.dart';
import 'package:gadgets4u/components/custom_surfix_icon.dart';
import 'package:gadgets4u/components/default_button.dart';
import 'package:gadgets4u/components/form_error.dart';
import 'package:gadgets4u/screens/home/components/home_header.dart';
import 'package:gadgets4u/screens/home/home_screen.dart';
import 'package:gadgets4u/screens/otp/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constants.dart';
import '../size_config.dart';

class verifyphone extends StatefulWidget {
  @override
  _verifyphoneState createState() => _verifyphoneState();
}

class _verifyphoneState extends State<verifyphone> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();




  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {


    final firstname = firstnamecontroller.text;
    final lastname = lastnamecontroller.text;
    final phone = phonecontroller.text;
    final address = addresscontroller.text;


    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
              text: "place order",
              press: () =>{


                if (_formKey.currentState!.validate()) {
                  profiletofirebase(phonecontroller.text,context),
                  Navigator.pushNamed(context, HomeScreen.routeName),
                }
              }
          ),
        ],
      ),
    );
  }


  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      maxLength: 10,
      controller: phonecontroller,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;

      },


      validator: (value) {
        if (value!.length!= 10) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },


      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }





  profiletofirebase(phone,BuildContext context,) async{
    final sucBar = SnackBar(
      content: Text('Order is successfully placed in few minutes our member will contact for the given phone number', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18,
      ),
      ),backgroundColor: Colors.deepOrangeAccent,duration:Duration(seconds: 7) ,
    );
    CollectionReference orders = FirebaseFirestore.instance.collection('orders');
    FirebaseAuth auth = FirebaseAuth.instance;
    String? email = auth.currentUser!.email;
    CollectionReference cartproducts = orders.doc(email,).collection('cart products');

    try {


      await orders.doc(email).update({
        'phone number' : phone,
      });

      return ScaffoldMessenger.of(context).showSnackBar(sucBar,);
    } on FirebaseException catch (e) {
      print(e.toString());
    }

  }











}
