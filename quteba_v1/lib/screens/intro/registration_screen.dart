// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quteba_v1/network_handler.dart';
import 'package:quteba_v1/styles/mono_icons_icons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final ApiHandler _apiHandler = ApiHandler();
  String errorMsg = null.toString();
  bool validated = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Image.asset(
                "assets/illustrations/qutebaLogo.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 25.0),
            const Text(
              "Let's Get Started!",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.0,
              ),
            ),
            const Text("Create a new account",
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Color(0xFFBBBBBB))),
            const SizedBox(
              height: 15.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20.0,
                  ),
                  emailField(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  passwordField(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  confirmPasswordField(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  signUpButton(),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Have an account? ",
                          style: GoogleFonts.poppins(
                              color: Color(0xFFBBBBBB),
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5),
                          children: const <TextSpan>[
                        TextSpan(
                            text: "Sign in",
                            style: TextStyle(
                                color: Color(0xFF1F2632),
                                fontSize: 15,
                                fontWeight: FontWeight.w600))
                      ]))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // Function to verify whether email exists or not
  verifyEmail() async {
    final response =
        await _apiHandler.get("/user/verifyEmail/${emailController.text}");

    var responseData = json.decode(response.body);

    if (responseData['Status']) {
      setState(() {
        validated = false;
        errorMsg = "Email already taken. Use a different one.";
      });
    } else {
      setState(() {
        validated = true;
      });
    }
  }

  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: TextFormField(
        validator: (value) {
          if (validated == false) {
            return errorMsg;
          }
          return null;
        },
        controller: emailController,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            hintText: "Email",
            hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Color(0xFFBBBBBB),
            ),
            prefixIcon: const Icon(
              MonoIcons.email,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFBBBBBB),
                ),
                borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xFF7C7C7C)))),
      ),
    );
  }

  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: TextFormField(
        obscureText: true,
        controller: passwordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter a strong password";
          }

          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            suffixIcon: IconButton(
              icon: Icon(Icons.visibility_off),
              onPressed: () {},
            ),
            hintText: "Password",
            hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Color(0xFFBBBBBB),
            ),
            prefixIcon: const Icon(
              MonoIcons.lock,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFBBBBBB),
                ),
                borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xFF7C7C7C)))),
      ),
    );
  }

  Widget confirmPasswordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: TextFormField(
        obscureText: true,
        controller: confirmPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please confirm your password";
          }
          if (value != passwordController.text) {
            return "Passwords don't match";
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            suffixIcon: IconButton(
              icon: Icon(Icons.visibility_off),
              onPressed: () {},
            ),
            hintText: "Confirm Password",
            hintStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Color(0xFFBBBBBB),
            ),
            prefixIcon: const Icon(
              MonoIcons.lock,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFBBBBBB),
                ),
                borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xFF7C7C7C)))),
      ),
    );
  }

  Widget signUpButton() {
    return ElevatedButton(
        onPressed: () async {
          await verifyEmail();
          if (_formKey.currentState!.validate() && validated) {
            Map<String, String> data = {
              "fullName": "Third User",
              "email": emailController.text,
              "password": passwordController.text
            };
            _apiHandler.post("/user/register", data);
          }
        },
        child: Text(
          'Sign Up',
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300),
        ));
  }
}
