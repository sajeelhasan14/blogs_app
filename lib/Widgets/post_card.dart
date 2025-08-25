import 'package:blogs_app/Provider/post_provider.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  final String title, body;
  final int likes, dislikes, views, index;
  final List<String> tags;

  const PostCard({
    required this.index,
    required this.title,
    required this.body,
    required this.likes,
    required this.dislikes,
    required this.views,
    required this.tags,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, left: 9, right: 33),
                  child: Text(
                    title.toString(),
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<PostProvider>(
                    context,
                    listen: false,
                  ).deletePost(index);
                },
                icon: Icon(Icons.delete, color: whiteColor),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 16, right: 102),
            child: Text(
              body.toString(),
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: greyColor,
              ),
              maxLines: 3,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                for (var tag in tags.take(3)) ...[
                  ReusableContainer(name: tag.toString()),
                  SizedBox(width: 8),
                  // ReusableContainer(name: widget.tags[0].toString()),
                  // SizedBox(width: 8),
                  // ReusableContainer(name: widget.tags[1].toString()),
                  // SizedBox(width: 8),
                  // ReusableContainer(name: widget.tags[2].toString()),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 9,
              right: 9,
              top: 25,
              bottom: 18,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage("assets/thumbsUp.png"),
                      height: 20,
                      width: 14,
                    ),
                    SizedBox(width: 2),
                    Text(
                      likes.toString(),

                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Image(
                      image: AssetImage("assets/thumbsDown.png"),
                      height: 20,
                      width: 14,
                    ),
                    SizedBox(width: 2),
                    Text(
                      dislikes.toString(),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 2),
                Row(
                  children: [
                    Image(
                      image: AssetImage("assets/eye.png"),
                      height: 20,
                      width: 14,
                    ),
                    SizedBox(width: 2),
                    Text(
                      views.toString(),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: greyColor,
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

class ReusableContainer extends StatelessWidget {
  final String name;
  const ReusableContainer({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff2B2B2B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Text(
          name,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
