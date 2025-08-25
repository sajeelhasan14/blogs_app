import 'package:blogs_app/Services/user_service.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserService callUsers = UserService();
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        centerTitle: true,
        title: Text(
          "Profile",
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: whiteColor),
          ),
        ],
      ),
      body: FutureBuilder(
        future: callUsers.getUsers(),
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

          if (!snapshot.hasData || snapshot.data!.users == null) {
            return const Center(
              child: Text(
                "No posts found",
                style: TextStyle(
                  fontFamily: "inter",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: whiteColor,
                ),
              ),
            );
          } else {
            final users = snapshot.data!.users;
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Image.network(users![0].image.toString()),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
