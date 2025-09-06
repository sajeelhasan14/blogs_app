import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';

class TagsDataCard extends StatelessWidget {
  final String title, body;
  final int likes, dislikes, views;

  const TagsDataCard({
    required this.title,
    required this.body,

    required this.likes,
    required this.dislikes,
    required this.views,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      margin: EdgeInsets.all(10),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: whiteColor,
              ),
            ),
            SizedBox(height: 6),
            Text(
              body,
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: whiteColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up, size: 18, color: Colors.green),
                    SizedBox(width: 4),
                    Text(
                      likes.toString(),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(width: 12),
                    Icon(Icons.thumb_down, size: 18, color: Colors.red),
                    SizedBox(width: 4),
                    Text(
                      dislikes.toString(),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.visibility, size: 18, color: Colors.blue),
                    SizedBox(width: 4),
                    Text(
                      views.toString(),
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
