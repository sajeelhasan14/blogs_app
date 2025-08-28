import 'package:blogs_app/Provider/user_post_provider.dart';
import 'package:blogs_app/Screens/user_profile_screen.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:blogs_app/Provider/auth_provider.dart';
import 'package:blogs_app/Provider/login_provider.dart';
import 'package:blogs_app/Provider/navigationbar_provider.dart';
import 'package:blogs_app/Provider/post_provider.dart';
import 'package:blogs_app/Provider/quote_provider.dart';
import 'package:blogs_app/Provider/user_provider.dart';
import 'package:blogs_app/Screens/login_screen.dart';
import 'package:blogs_app/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider()),
        ChangeNotifierProvider(create: (context) => QuoteProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => NavigationbarProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => UserPostsProvider()),
      ],
      child: const BlogApp(),
    ),
  );
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          // If still loading user data, show splash
          if (authProvider.startupLoading) {
            return const Scaffold(
              backgroundColor: backColor,
              body: Expanded(
                flex: 1,
                child: SpinKitThreeBounce(color: whiteColor),
              ),
            );
          }

          // // If token exists and user is loaded, go to HomeScreen
          if (authProvider.user != null) {
            return const MyApp();
          }

          // Otherwise, show LoginScreen
          return const LoginScreen();
        },
      ),
    );
  }
}
