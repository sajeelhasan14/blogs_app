import 'package:blogs_app/Provider/navigationbar_provider.dart';
import 'package:blogs_app/Screens/home_screen.dart';
import 'package:blogs_app/Screens/quotes_screen.dart';
import 'package:blogs_app/Screens/splash_screen.dart';
import 'package:blogs_app/Screens/user_profile_screen.dart';
import 'package:blogs_app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationbarProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserProfileScreen(),
      ),
    );
  }
}
