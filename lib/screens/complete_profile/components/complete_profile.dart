import 'package:flutter/material.dart';
import 'package:gadgets4u/completeorder/verifyphonescreen.dart';
import 'package:gadgets4u/components/custom_surfix_icon.dart';
import 'package:gadgets4u/components/default_button.dart';
import 'package:gadgets4u/components/form_error.dart';
import 'package:gadgets4u/screens/home/home_screen.dart';
import 'package:gadgets4u/screens/otp/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
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


    final sucBar = SnackBar(backgroundColor:Colors.deepOrange,duration:Duration(seconds: 9),content: Text('Order placed successfully we ill contact you in few minutes'));
    final firstname = firstnamecontroller.text;
    final lastname = lastnamecontroller.text;
    final phone = phonecontroller.text;
    final address = addresscontroller.text;


    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () =>{



              if (_formKey.currentState!.validate()) {
             profiletofirebase(firstnamecontroller.text,lastnamecontroller.text,addresscontroller.text,phonecontroller.text,context,),
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false),
               ScaffoldMessenger.of(context).showSnackBar(sucBar,),
              }
            }
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {

    return TextFormField(
      controller: addresscontroller,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
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

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastnamecontroller,
      onSaved: (newValue) => lastName = newValue,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstnamecontroller,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }




  profiletofirebase(firstname,lastname,phone,address,BuildContext context,) async{

      final orders = FirebaseFirestore.instance.collection('cart orders');
    FirebaseAuth auth = FirebaseAuth.instance;
    String? email = auth.currentUser!.email;
    CollectionReference cartproducts = orders.doc(email,).collection('cart products');

    try {
      await orders.doc(email).set(
          {
        'first name': firstname,
        'last name': lastname,
        'phone number' : phone,
        'address':address,

      });
      await orders.doc(email).update(
          {
            'first name': firstname,
            'last name': lastname,
            'phone number' : phone,
            'address':address,
          });
      print(firstname);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> verifyphonescreen()));

    } on FirebaseException catch (e) {
      print(e.toString());
    }

  }











}
