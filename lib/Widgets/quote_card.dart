import 'package:blogs_app/Provider/quote_provider.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class QuoteCard extends StatelessWidget {
  final int index;
  final String quote;
  final String author;
  final bool isFavoriteScreen;
  QuoteCard({
    required this.quote,
    required this.author,
    required this.index,
    required this.isFavoriteScreen,
    super.key,
  });
  final List<Color> codeColors = [
    Color(0xFFC084FC), // Purple
    Color(0xFF60A5FA), // Blue
    Color(0xFF4ADE80), // Green
    Color(0xFFFACC15), // Yellow
    Color(0xFFF472B6), // Pink
  ];

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<QuoteProvider>(context, listen: false);
    final color = colorProvider.getColorForQuote(index);
    final quotes = Provider.of<QuoteProvider>(context);
    return Card(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0, bottom: 16, left: 25),
            child: SvgPicture.asset(
              "assets/yellow_quote.svg",
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              width: 21,
              height: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 6, bottom: 16),
            child: Text(
              '"$quote"',
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: quoteColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '— $author',
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: authorColor,
                  ),
                ),
                Row(
                  children: [
                    isFavoriteScreen
                        ? IconButton(
                            onPressed: () {},
                            icon: Stack(
                              alignment: AlignmentGeometry.directional(0, 0),
                              children: [
                                Image.asset(
                                  "assets/love_button.png",
                                  color: Color(0xff303843),
                                  height: 40,
                                  width: 30,
                                ),
                                Icon(
                                  Icons.favorite,
                                  color:
                                      quotes.isFavorite(
                                        quotes.searchQuotes[index],
                                      )
                                      ? Colors.red
                                      : whiteColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              quotes.addFavorite(quotes.searchQuotes[index]);
                            },
                            icon: Stack(
                              alignment: AlignmentGeometry.directional(0, 0),
                              children: [
                                Image.asset(
                                  "assets/love_button.png",
                                  color: Color(0xff303843),
                                  height: 40,
                                  width: 30,
                                ),
                                Icon(
                                  Icons.favorite,
                                  color:
                                      quotes.isFavorite(
                                        quotes.searchQuotes[index],
                                      )
                                      ? Colors.red
                                      : whiteColor,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/share_button.png",
                        height: 40,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
