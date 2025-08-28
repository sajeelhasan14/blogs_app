import 'package:blogs_app/Provider/quote_provider.dart';
import 'package:blogs_app/Screens/favorites.dart';
import 'package:blogs_app/Widgets/quote_card.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  void initState() {
    super.initState();
    // ignore: use_build_context_synchronously
    Future.microtask(() => context.read<QuoteProvider>().fetchQuotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,

        title: Provider.of<QuoteProvider>(context).isSearching
            ? TextField(
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: whiteColor,
                ),
                decoration: InputDecoration(
                  hintText: "Search quotes...",
                  hintStyle: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  context.read<QuoteProvider>().updateSearchQuery(value);
                },
              )
            : Text(
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
          icon: SvgPicture.asset(
            "assets/blue_quote.svg",
            height: 15,
            width: 21,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
            icon: Image.asset("assets/love_button.png"),
          ),
          IconButton(
            onPressed: () {
              context.read<QuoteProvider>().toggleSearching();
            },
            icon: Image.asset("assets/search_button.png"),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Consumer<QuoteProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Expanded(
              flex: 1,
              child: SpinKitThreeBounce(color: whiteColor),
            );
          } else if (provider.error != null) {
            return Center(
              child: Text(
                "Error: ${provider.error}",
                style: TextStyle(color: whiteColor),
              ),
            );
          } else if (provider.quotes.isEmpty) {
            return const Center(
              child: Text(
                "No quotes found",
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
              itemCount: provider.searchQuotes.length,
              itemBuilder: (context, index) {
                final quotes = provider.searchQuotes[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      provider.addFavorite(quotes);
                    },
                    child: QuoteCard(
                      index: index,
                      quote: quotes.quote.toString(),
                      author: quotes.author.toString(),
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
