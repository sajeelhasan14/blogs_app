import 'package:blogs_app/Provider/user_post_provider.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final List<Color> myColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  final List<String> myImages = [
    'images/history.jpeg',
    'images/history.jpeg',
    'images/history.jpeg',
    'images/history.jpeg',
    'images/history.jpeg',
  ];

  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final userPostsProvider = Provider.of<UserPostsProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Search", style: TextStyle(color: whiteColor)),
        backgroundColor: backColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: greyColor),
                prefixIcon: Icon(Icons.search, color: greyColor),
                filled: true,
                fillColor: greyColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: greyColor),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: userPostsProvider.userPosts?.posts?.length,
              itemBuilder: (context, index) {
                final randomImage = widget
                    .myImages[index % widget.myImages.length]; // cycle karega
                final randomColor =
                    widget.myColors[index % widget.myColors.length];
                final post = userPostsProvider.userPosts?.posts![index];
                return Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: greyColor,
                    ),
                    height: 125,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 95,
                            width: 95,
                            decoration: BoxDecoration(
                              color: randomColor,
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage(randomImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                post!.title ?? " ",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: whiteColor,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 25,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: randomColor,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        post.tags![0],
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: greyColor,
                                        ),
                                        Text(
                                          post.views.toString(),
                                          style: TextStyle(color: greyColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
