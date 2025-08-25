import 'package:blogs_app/Provider/post_provider.dart';
import 'package:blogs_app/Widgets/reusable_row_reactions.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PostDetailScreen extends StatefulWidget {
  final String title, body;
  final int likes, dislikes, views, index;
  final List<String> tags;
  const PostDetailScreen({
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
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Screen size
    // final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        centerTitle: true,
        title: Text(
          "Daily Stories",
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: whiteColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: whiteColor),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.03),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableRow(
                  text: widget.likes.toString(),
                  path: "assets/love.svg",
                ),

                ReusableRow(
                  text: widget.dislikes.toString(),
                  path: "assets/delove.svg",
                ),

                ReusableRow(
                  text: widget.views.toString(),
                  path: "assets/views.svg",
                ),
                SvgPicture.asset("assets/share.svg"),
              ],
            ),
          ),
          SizedBox(height: height * 0.045),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              widget.title.toString(),
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: whiteColor,
              ),
            ),
          ),
          SizedBox(height: height * 0.017),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 16),
            child: Text(
              widget.body.toString(),
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: greyColor,
              ),
            ),
          ),
          SizedBox(height: height * 0.065),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: InkWell(
                onTap: () {
                  Provider.of<PostProvider>(
                    context,
                    listen: false,
                  ).deletePost(widget.index);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xffDC2626),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, color: whiteColor),
                      SizedBox(width: 8),
                      Text(
                        "Delete Post",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
