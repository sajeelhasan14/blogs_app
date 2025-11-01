import 'package:blogs_app/Provider/quote_provider.dart';
import 'package:blogs_app/Widgets/quote_card.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
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
          "Favorite Quotes",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: whiteColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: whiteColor),
        ),
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
                  child: QuoteCard(
                    index: index,
                    quote: favor.quote.toString(),
                    author: favor.author.toString(),
                    isFavoriteScreen: true,
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
