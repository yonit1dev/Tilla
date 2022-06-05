// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class NativeTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final Function(String value) onChanged;

  NativeTextField(
      {Key? key,
      required this.hintText,
      required this.onChanged,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0xFFBBBBBB),
          ),
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class PasswordFields extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final Function(String value) onChanged;

  PasswordFields(
      {Key? key,
      required this.hintText,
      required this.onChanged,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        onChanged: onChanged,
        obscureText: true,
        style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Color(0xFFBBBBBB),
          ),
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
