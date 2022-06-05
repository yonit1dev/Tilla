// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tilla_team/application/auth/auth_bloc.dart';
import 'package:tilla_team/ui/nav/nav.dart';
import 'package:tilla_team/ui/styles/buttons.dart';
import 'package:tilla_team/ui/styles/monoicons.dart';
import 'package:tilla_team/ui/styles/textfields.dart';

import 'register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        userRepository: RepositoryProvider.of(context),
      ),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Logging In'),
              ),
            );
          }
          if (state is Authenticated) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.go(Routes.dash);
          }
          if (state is FailedAuth) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMsg),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: header(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formkey,
                      child: SizedBox(
                        height: 600,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              NativeTextField(
                                hintText: 'Username',
                                onChanged: (value) {
                                  username = value;
                                },
                                icon: const Icon(
                                  MonoIcons.user,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              NativeTextField(
                                hintText: 'Password',
                                onChanged: (value) {
                                  password = value;
                                },
                                icon: const Icon(
                                  MonoIcons.lock,
                                  color: Colors.black,
                                ),
                              ),
                              forgotPassword(),
                              AffirmButtons(
                                text: "Login",
                                onPressed: () async {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    SignInAuth(username, password, 'native'),
                                  );
                                },
                                size: const Size(double.infinity, 50),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              helper(),
                              const SizedBox(
                                height: 10,
                              ),
                              googleLogin(),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: const Color(0xFFBBBBBB),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.5),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Register",
                                      style: const TextStyle(
                                        color: Color(0xFF1F2633),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          context.go(Routes.signup);
                                        },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget header() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Image.asset("assets/images/tillaLogo.png"),
          const SizedBox(height: 25),
          RichText(
            text: TextSpan(
                children: [
                  TextSpan(
                      text: "Tilla",
                      style: TextStyle(
                          color: Color(0xFFEE8042),
                          fontWeight: FontWeight.w700))
                ],
                text: "Welcome to ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2)),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Credentials to continue",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.normal,
              color: Color(0xFFBBBBBB),
            ),
          ),
        ],
      ),
    );
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          "Forgot Password?",
          textAlign: TextAlign.end,
          style: TextStyle(
              fontSize: 13.5, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
    );
  }

  Widget helper() {
    // Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity * 0.85,
      child: Row(
        children: <Widget>[
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
        ],
      ),
    );
  }

  Widget buildDivider() {
    return const Expanded(
      child: Divider(
        color: Color(0xFFAAAAAA),
        thickness: 1,
      ),
    );
  }

  Widget googleLogin() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          primary: Colors.white, onPrimary: const Color(0xFFBBBBBB)),
      child: Row(
        children: const [
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
        ],
      ),
    );
  }
}
