import 'package:blogs_app/Screens/post_detail_screen.dart';
import 'package:blogs_app/Services/posts_service.dart';
import 'package:blogs_app/Widgets/post_card.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    PostsService callPosts = PostsService();
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
            onPressed: () {},
            icon: SvgPicture.asset("assets/search.svg"),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: callPosts.getPosts(),
              builder: (context, snapshot) {
                final posts = snapshot.data!.posts!;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: whiteColor),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.posts!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(
                                  title: posts[index].title!,
                                  body: posts[index].body!,
                                  likes: posts[index].reactions!.likes!,
                                  dislikes: posts[index].reactions!.dislikes!,
                                  views: posts[index].views!,
                                  tags: posts[index].tags!,
                                ),
                              ),
                            );
                          },
                          child: PostCard(
                            title: posts[index].title!,
                            body: posts[index].body!,
                            likes: posts[index].reactions!.likes!,
                            dislikes: posts[index].reactions!.dislikes!,
                            views: posts[index].views!,
                            tags: posts[index].tags!,
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
