import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;
  const QuoteCard({required this.quote, required this.author, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0, bottom: 16, left: 25),
            child: SvgPicture.asset("assets/quote.svg"),
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
