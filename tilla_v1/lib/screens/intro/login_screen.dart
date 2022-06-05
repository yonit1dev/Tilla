import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quteba_v1/network_handler.dart';
import 'package:quteba_v1/screens/dashboard/main_dash.dart';
import 'package:quteba_v1/screens/intro/forgotPassword.dart';
import 'package:quteba_v1/screens/intro/registration_screen.dart';
import 'package:quteba_v1/styles/mono_icons_icons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Retrieve the text of the form
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool verify = false;
  String errorMsg = null.toString();

  final ApiHandler _apiHandler = ApiHandler();

  // Password visibility
  bool notVisible = true;

  // Dispose contents once the widget is destroyed
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

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
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(children: [
              Image.asset("assets/illustrations/qutebaLogo.png"),
              const SizedBox(height: 40.0),
              const Text(
                "Welcome to Tilla!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.0,
                ),
              ),
              const Text("Sign in to continue",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFFBBBBBB))),
              const SizedBox(
                height: 40.0,
              ),
              Form(
                key: _formKey,
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(height: 390.0, width: 380),
                  child: Column(
                    children: <Widget>[
                      EmailField(),
                      const SizedBox(
                        height: 20.0,
                      ),
                      PasswordField(),
                      ForgotPassword(),
                      LoginButton(),
                      SizedBox(
                        height: 20,
                      ),
                      OrDivider(),
                      SizedBox(
                        height: 10,
                      ),
                      GoogleLogin(),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFFBBBBBB),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5),
                              children: <TextSpan>[
                            TextSpan(
                                onEnter: (event) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpScreen()));
                                },
                                text: "Register",
                                style: TextStyle(
                                    color: Color(0xFFEE8042),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600))
                          ]))
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

// Email field widget
  Widget EmailField() {
    return TextFormField(
      validator: (value) {
        if (verify == false) {
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
              borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
              borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Color(0xFF7C7C7C)))),
    );
  }

// Password field widget
  Widget PasswordField() {
    return TextFormField(
      obscureText: notVisible,
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your password";
        }
        if (value.length < 6) {
          return "Your password shoud be greater than 6 characters";
        }

        return null;
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          hintText: "Password",
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0xFFBBBBBB),
          ),
          prefixIcon: const Icon(
            MonoIcons.lock,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility, color: Colors.black),
            onPressed: () {
              setState(() {
                notVisible = !notVisible;
              });
            },
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFCCCCCC),
              ),
              borderRadius: BorderRadius.circular(10.0)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Color(0xFF7C7C7C)))),
    );
  }

// Forgot password widget
  Widget ForgotPassword() {
    return TextButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Validate the form
            return null;
          }
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(225, 0, 0, 0),
          child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            child: Text(
              "Forgot Password?",
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
        ));
  }

// Login Button
  Widget LoginButton() {
    return ElevatedButton(
        onPressed: () async {
          Map<String, String> data = {
            "email": emailController.text,
            "password": passwordController.text
          };

          var response = await _apiHandler.post("/user/login", data);

          if (response.statusCode == 200 || response.statusCode == 201) {
            Map<String, dynamic> responseData = json.decode(response.body);
            print(responseData['token']);
            setState(() {
              verify = true;
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            });
          } else {
            String responseData = json.decode(response.body);
            setState(() {
              verify = false;
              errorMsg = responseData;
            });
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300),
        ));
  }

// Google Login Button
  Widget GoogleLogin() {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            primary: Colors.white, onPrimary: Color(0xFFBBBBBB)),
        child: Row(children: const [
          Padding(
            padding: EdgeInsets.only(right: 80),
            child: Icon(
              Icons.mail,
              color: Colors.black,
            ),
          ),
          Text(
            'Login with Google',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
          ),
        ]));
  }

// Divider below the login button
  Expanded buildDivider() {
    return const Expanded(
        child: Divider(
      color: Color(0xFFAAAAAA),
      thickness: 1,
    ));
  }

// Divider Structure
  Widget OrDivider() {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.85,
      child: Row(children: <Widget>[
        buildDivider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "OR",
            style: TextStyle(
                color: Color(0xFFAAAAAA),
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
        ),
        buildDivider()
      ]),
    );
  }
}
