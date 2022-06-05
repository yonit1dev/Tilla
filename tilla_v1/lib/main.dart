import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:quteba_v1/screens/dashboard/main_dash.dart';
import 'package:quteba_v1/screens/intro/registration_screen.dart';
import 'package:quteba_v1/screens/intro/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  fixedSize: Size(380, 50),
                  primary: Color(0xFFEE8042),
                  onPrimary: Colors.white)),
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
      title: 'Tilla',
      home: WelcomeScreen(),
    );
  }
}
