// ignore_for_file: use_build_context_synchronously

import 'package:blogs_app/Provider/auth_provider.dart';
import 'package:blogs_app/Provider/login_provider.dart';
import 'package:blogs_app/app.dart';
import 'package:flutter/material.dart';
import 'package:blogs_app/constants.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    Future<void> login() async {
      if (_formKey.currentState!.validate()) {
        await authProvider.login(
          usernameController.text,
          passwordController.text,
        );

        if (authProvider.user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MyApp()),
          );
        } else if (authProvider.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(authProvider.error!)));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: backColor),
      backgroundColor: backColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "inter",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Login to continue",
                    style: TextStyle(
                      color: greyColor,
                      fontSize: 16,
                      fontFamily: "inter",
                    ),
                  ),
                  const SizedBox(height: 40),

                  /// Email Field
                  TextFormField(
                    controller: usernameController,
                    style: const TextStyle(color: whiteColor),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: cardColor,
                      hintText: "Username",
                      hintStyle: TextStyle(color: greyColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter your username" : null,
                  ),
                  const SizedBox(height: 20),

                  /// Password Field
                  Consumer<LoginProvider>(
                    builder: (context, loginProvider, child) {
                      return TextFormField(
                        controller: passwordController,
                        obscureText: loginProvider.obscurePassword,
                        style: const TextStyle(color: whiteColor),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: cardColor,
                          hintText: "Password",
                          hintStyle: TextStyle(color: greyColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              loginProvider.obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: greyColor,
                            ),
                            onPressed: loginProvider.toggleVisibility,
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter your password" : null,
                      );
                    },
                  ),
                  const SizedBox(height: 30),

                  /// Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: login,
                      child: authProvider.authLoading
                          ? const CircularProgressIndicator(color: backColor)
                          : Text(
                              "Login",
                              style: TextStyle(
                                color: backColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "inter",
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Sign Up Text
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Don’t have an account? Sign Up",
                        style: TextStyle(
                          color: greyColor,
                          fontSize: 14,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
