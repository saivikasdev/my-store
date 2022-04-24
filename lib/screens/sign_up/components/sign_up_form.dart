import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gadgets4u/components/custom_surfix_icon.dart';
import 'package:gadgets4u/components/default_button.dart';
import 'package:gadgets4u/components/form_error.dart';
import 'package:gadgets4u/screens/complete_profile/complete_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gadgets4u/screens/home/home_screen.dart';
import 'package:gadgets4u/screens/login_success/login_success_screen.dart';
import 'package:gadgets4u/screens/sign_in/sign_in_screen.dart';
import '../../../constants.dart';
import 'dart:async';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool remember = false;

  final List<String?> errors = [];

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conformpasswordcontroller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  get password => null;
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
              text: "Continue",
              press: () {
                signingupwithemail(
                    context, emailcontroller.text, passwordcontroller.text);
              }),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    ////////////////////////////////
    return TextFormField(
      controller: conformpasswordcontroller,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    ////////////////////////////////////
    return TextFormField(
      controller: passwordcontroller,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    ////////////////////////////////////////
    return TextFormField(
      controller: emailcontroller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}

Future<dynamic> signingupwithemail(
    BuildContext context, email, password) async {
  final snackBar =  SnackBar(
      content: Text(
    'Something went wrong',
    style: TextStyle(
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ));
  final sucBar =  SnackBar(
      content: Text(
    'User may be created you may login (or) try with some other gmail',
    style: TextStyle(
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ));

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;
  CollectionReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection('users');

  try {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    users..doc(email).set({
      'UID': user!.uid,
      'EMAIL': email,
      'PASSWORD': password,
    });
    return Navigator.pushNamed(context, HomeScreen.routeName);
  } on FirebaseAuthException catch (e) {
    print(e.toString());
    ScaffoldMessenger.of(context).showSnackBar(sucBar);
    Navigator.pushNamed(context, SignInScreen.routeName);
  }
}



