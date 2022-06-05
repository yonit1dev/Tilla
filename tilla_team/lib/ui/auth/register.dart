// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tilla_team/application/auth/auth_bloc.dart';

import '../nav/nav.dart';
import '../styles/buttons.dart';
import '../styles/monoicons.dart';
import '../styles/textfields.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _key = GlobalKey<FormState>();

  String firstName = '';

  String lastName = '';

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
                content: Text('Registering'),
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
                      key: _key,
                      child: SizedBox(
                        height: 600,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              NativeTextField(
                                hintText: 'First Name',
                                onChanged: (value) {
                                  firstName = value;
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
                                hintText: 'LastName',
                                onChanged: (value) {
                                  lastName = value;
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
                              const SizedBox(
                                height: 20,
                              ),
                              AffirmButtons(
                                text: "Sign Up",
                                onPressed: () async {
                                  BlocProvider.of<AuthBloc>(context).add(
                                      SignUpAuth(firstName, lastName, username,
                                          password, "native"));
                                },
                                size: const Size(double.infinity, 50),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "Already have an account? ",
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
                                        text: "Login",
                                        style: const TextStyle(
                                          color: Color(0xFF1F2633),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context.go(Routes.login);
                                          }),
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
            height: 5,
          ),
          const Text(
            "Join Us",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              color: Color(0xFFBBBBBB),
            ),
          ),
        ],
      ),
    );
  }
}
