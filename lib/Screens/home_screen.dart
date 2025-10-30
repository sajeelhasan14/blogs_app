import 'package:blogs_app/Provider/post_provider.dart';
import 'package:blogs_app/Provider/quote_provider.dart';
import 'package:blogs_app/Screens/addpost_screen.dart';
import 'package:blogs_app/Screens/post_detail_screen.dart';
import 'package:blogs_app/Screens/search_screen.dart';
import 'package:blogs_app/Widgets/post_card.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().fetchPosts();
      context.read<QuoteProvider>().fetchQuotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        title: Text(
          "Daily Stories",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddpostScreen()),
              );
            },
            icon: Icon(Icons.post_add, color: whiteColor),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TagPostsScreen()),
              );
            },
            icon: SvgPicture.asset("assets/search.svg"),
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return SpinKitThreeBounce(color: whiteColor);
          } else if (provider.error != null) {
            return Center(
              child: Text(
                "Error: ${provider.error}",
                style: TextStyle(color: whiteColor),
              ),
            );
          } else if (provider.posts.isEmpty) {
            return const Center(
              child: Text(
                "No posts found",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];

                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostDetailScreen(
                            index: index,
                            title: post.title ?? "",
                            body: post.body ?? "",
                            likes: post.reactions?.likes ?? 0,
                            dislikes: post.reactions?.dislikes ?? 0,
                            views: post.views ?? 0,
                            tags: post.tags ?? [],
                          ),
                        ),
                      );
                    },
                    child: PostCard(
                      index: index,
                      id: post.id,
                      title: post.title ?? "",
                      body: post.body ?? "",
                      likes: post.reactions?.likes ?? 0,
                      dislikes: post.reactions?.dislikes ?? 0,
                      views: post.views ?? 0,
                      tags: post.tags ?? [],
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
