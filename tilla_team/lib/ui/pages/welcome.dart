// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../auth/login.dart';
import '../nav/nav.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size of the device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Center(
            child: Padding(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/tillaLogo.png",
                    height: 55,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Text(
                    "Tilla",
                    style: GoogleFonts.poppins(
                        fontSize: 32.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/illustrations/splash.jpeg",
                fit: BoxFit.fitWidth,
                height: 250,
              ),
              const SizedBox(
                height: 25,
              ),
              DotsIndicator(
                dotsCount: 3,
                decorator: DotsDecorator(
                  color: Color(0xFF1F2633),
                  activeColor: Color(0xFFEE8042),
                  spacing: const EdgeInsets.symmetric(horizontal: 18),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Take control of your expenses \n Save towards your goal \n Achieve financial freedom",
                style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7C7C7C)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  context.push('/');
                },
                child: const Icon(
                  Icons.arrow_forward,
                  size: 42.0,
                  color: Color(0xFFFFFFFF),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(60, 60),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(5),
                  primary: const Color(0xFFEE8042),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
