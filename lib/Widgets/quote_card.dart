import 'package:blogs_app/Provider/quote_provider.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class QuoteCard extends StatelessWidget {
  final int index;
  final String quote;
  final String author;
  QuoteCard({
    required this.quote,
    required this.author,
    required this.index,
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
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/love_button.png",
                        height: 40,
                        width: 30,
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
