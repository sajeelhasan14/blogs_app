import 'package:blogs_app/Provider/navigationbar_provider.dart';
import 'package:blogs_app/Provider/post_provider.dart';
import 'package:blogs_app/Provider/quote_provider.dart';
import 'package:blogs_app/Provider/user_provider.dart';
import 'package:blogs_app/Screens/home_screen.dart';
import 'package:blogs_app/Screens/quotes_screen.dart';
import 'package:blogs_app/Screens/splash_screen.dart';
import 'package:blogs_app/Screens/user_profile_screen.dart';
import 'package:blogs_app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider()),
        ChangeNotifierProvider(create: (context) => QuoteProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => NavigationbarProvider()),
      ],
      child: const BlogApp(),
    ),
  );
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyApp());
  }
}
