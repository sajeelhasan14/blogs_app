import 'dart:async';
import 'package:blogs_app/Provider/auth_provider.dart';
import 'package:blogs_app/Screens/login_screen.dart';
import 'package:blogs_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLogin();
    });
  }

  Future<void> _checkLogin() async {
    // Wait for 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.loadUserFromStorage(); // ✅ wait for token/user to load
    if (!mounted) return;

    if (authProvider.user != null) {
      // ✅ user is available after storage load
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyApp()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
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
