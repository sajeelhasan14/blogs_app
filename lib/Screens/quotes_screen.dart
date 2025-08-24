import 'package:blogs_app/Services/quotes_service.dart';
import 'package:blogs_app/Widgets/quote_card.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  @override
  Widget build(BuildContext context) {
    QuotesService callQuotes = QuotesService();
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        title: Text(
          "Quotes",
          style: TextStyle(
            fontFamily: "nter",
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
            icon: Image.asset("assets/love_button.png"),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset("assets/search_button.png"),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: callQuotes.getQuotes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    flex: 1,
                    child: SpinKitThreeBounce(color: whiteColor),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: TextStyle(color: whiteColor),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.quotes == null) {
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
                  final quotes = snapshot.data!.quotes!;
                  return ListView.builder(
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: QuoteCard(
                            quote: quotes[index].quote.toString(),
                            author: quotes[index].author.toString(),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
