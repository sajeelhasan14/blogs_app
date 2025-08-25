import 'package:blogs_app/Provider/quote_provider.dart';

import 'package:blogs_app/Widgets/quote_card.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        title: Text(
          "Quotes",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: whiteColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/quote.svg"),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset("assets/search_button.png"),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Consumer<QuoteProvider>(
        builder: (context, provider, child) {
          if (provider.favorites.isEmpty) {
            return const Center(
              child: Text(
                "No posts found",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: whiteColor,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                final favor = provider.favorites[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: QuoteCard(
                      quote: favor.quote.toString(),
                      author: favor.author.toString(),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
