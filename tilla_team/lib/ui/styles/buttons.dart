// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AffirmButtons extends StatelessWidget {
  const AffirmButtons({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.size,
  }) : super(key: key);

  final String text;
  final Size size;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: Size(380, 50),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
