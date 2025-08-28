import 'package:blogs_app/Provider/post_provider.dart';
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
    // ignore: use_build_context_synchronously
    Future.microtask(() => context.read<PostProvider>().fetchPosts());
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
            fontFamily: "inter",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: whiteColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/shuffle.svg"),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
            icon: SvgPicture.asset("assets/search.svg"),
          ),
        ],
      ),
      body: Consumer<PostProvider>(
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
