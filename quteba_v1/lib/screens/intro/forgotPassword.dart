import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forgotPasswordEmail = TextEditingController();

    return Container(
      child: Center(child: Text("Forgot Password")),
    );
  }
}
