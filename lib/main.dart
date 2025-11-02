import 'package:blogs_app/Provider/favorite_provider.dart';
import 'package:blogs_app/Provider/tag_creator_provider.dart';
import 'package:blogs_app/Provider/tags_stories_provider.dart';
import 'package:blogs_app/Provider/user_post_provider.dart';
import 'package:blogs_app/Screens/splash_screen.dart';
import 'package:blogs_app/Services/firebase_favorites.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blogs_app/Provider/auth_provider.dart';
import 'package:blogs_app/Provider/login_provider.dart';
import 'package:blogs_app/Provider/navigationbar_provider.dart';
import 'package:blogs_app/Provider/post_provider.dart';
import 'package:blogs_app/Provider/quote_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider()),
        ChangeNotifierProvider(create: (context) => QuoteProvider()),
        ChangeNotifierProvider(create: (context) => NavigationbarProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => UserPostsProvider()),
        ChangeNotifierProvider(create: (context) => TagsStoriesProvider()),
        ChangeNotifierProvider(create: (context) => TagCreatorProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => FirebaseFavorites()),
      ],
      child: const BlogApp(),
    ),
  );
}

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
