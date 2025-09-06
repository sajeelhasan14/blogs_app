import 'package:blogs_app/Provider/auth_provider.dart';
import 'package:blogs_app/Provider/navigationbar_provider.dart';
import 'package:blogs_app/Provider/post_provider.dart';
import 'package:blogs_app/Provider/quote_provider.dart';
import 'package:blogs_app/Screens/home_screen.dart';
import 'package:blogs_app/Screens/quotes_screen.dart';
import 'package:blogs_app/Screens/user_profile_screen.dart';
import 'package:blogs_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Widget> _pages = [
    HomeScreen(),
    QuotesScreen(),
    UserProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().fetchPosts();
      context.read<QuoteProvider>().fetchQuotes();
      context.read<AuthProvider>().loadUserFromStorage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[Provider.of<NavigationbarProvider>(context).selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff151B22),
        selectedItemColor: whiteColor,
        unselectedItemColor: greyColor,
        currentIndex: Provider.of<NavigationbarProvider>(context).selectedIndex,
        onTap: Provider.of<NavigationbarProvider>(context).toggleIndex,
        selectedLabelStyle: TextStyle(
          fontFamily: "Inter",
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        items: [
          // Image.asset("assets/home.png", height: 20, width: 20),
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          // Image.asset("assets/quote.png", height: 20, width: 20),
          BottomNavigationBarItem(
            label: "Quotes",
            icon: Icon(Icons.format_quote),
          ),
          // Image.asset("assets/profile.png", height: 20, width: 20)
          BottomNavigationBarItem(label: "Profile", icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
