import 'dart:async';

import 'package:blogs_app/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0D0D0D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.35),
            Image(image: AssetImage("assets/logo.png"), height: 80, width: 80),

            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Text(
              "Daily Stories",
              style: TextStyle(
                color: Color(0xffFFFFFF),
                fontFamily: "Inter",
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "Your daily stories at a glance",
              style: TextStyle(
                fontFamily: "Inter",
                color: Color(0xffA1A1A1),
                fontSize: 18,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            SvgPicture.asset("assets/circle.svg"),
          ],
        ),
      ),
    );
  }
}
