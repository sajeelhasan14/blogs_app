import 'package:blogs_app/Models/user_model.dart';
import 'package:blogs_app/Models/user_post_model.dart';

import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String  body;
  
  final int index;
  final Users user;
  const ProfileCard({required this.body, required this.user,required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 25, child: Image.network(user.image!)),
                    SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${user.firstName}",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: whiteColor,
                          ),
                        ),
                        Text(
                          "${user.lastName}",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz, color: whiteColor),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              body.toString(),
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: greyColor,
              ),
              maxLines: 5,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite_border_outlined, color: whiteColor),
                        SizedBox(width: 2),
                        Text("24", style: TextStyle(color: greyColor)),
                      ],
                    ),
                    SizedBox(width: 15),
                    Row(
                      children: [
                        Icon(Icons.comment, color: whiteColor),
                        SizedBox(width: 2),
                        Text("4", style: TextStyle(color: greyColor)),
                      ],
                    ),
                    SizedBox(width: 15),
                    Row(
                      children: [
                        Icon(Icons.question_mark_rounded, color: whiteColor),
                        SizedBox(width: 2),
                        Text("24", style: TextStyle(color: greyColor)),
                      ],
                    ),
                  ],
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.bookmark)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
