import 'dart:convert';

import 'package:ecommerce_ui/API/Api_connect.dart';
import 'package:ecommerce_ui/models/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ecommerce_ui/Components/already_have_an_account_acheck.dart';
import 'package:ecommerce_ui/constants.dart';
import 'package:ecommerce_ui/Screen/Login/login_screen.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({
    Key? key,
  }) : super(key: key);

  final TextEditingController nama_customer = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController no_telp_customer = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController alamat = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: nama_customer,
            decoration: const InputDecoration(
              hintText: "Nama",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.mail),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              controller: no_telp_customer,
              decoration: const InputDecoration(
                hintText: "NoHp",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              controller: password,
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              cursorColor: kPrimaryColor,
              controller: alamat,
              decoration: const InputDecoration(
                hintText: "Alamat",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.home),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              _handleRegister(context);
            },
            child: Text(
              "Register".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleRegister(BuildContext context) async {
    try {
      var response = await http.post(Uri.parse(ApiConnect.register), body: {
        "email_Custt": email.text.toString(),
        "password_Cust": password.text.toString(),
        "namaCust": nama_customer.text.toString(),
        "no_telp": no_telp_customer.text.toString(),
        "alamat" :alamat.text.toString()
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final register = Register.fromJson(jsonData);
        if (register.success == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else {
          Fluttertoast.showToast(
            msg: email.text.toString(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: password.text.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12,
        );
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }
}
