import 'package:blogs_app/Provider/auth_provider.dart';
import 'package:blogs_app/Provider/post_provider.dart';
import 'package:blogs_app/Provider/user_post_provider.dart';
import 'package:blogs_app/Screens/login_screen.dart';
import 'package:blogs_app/Widgets/profile_card.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();

    // Fetch user posts once the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      context.read<PostProvider>().fetchPosts();

      final userPostsProvider = Provider.of<UserPostsProvider>(
        context,
        listen: false,
      );
      final firebasePosts = Provider.of<PostProvider>(context, listen: false);

      if (authProvider.user != null && authProvider.user!.id != null) {
        
        firebasePosts.fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userPostsProvider = Provider.of<UserPostsProvider>(context);
    final firebasePosts = Provider.of<PostProvider>(context, listen: false);

    final user = authProvider.user;

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontFamily: "inter",
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: whiteColor,
          ),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: whiteColor),
            onPressed: () async {
              await authProvider.logout();
              userPostsProvider.clearPosts();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: authProvider.authLoading
          ? const Expanded(
              flex: 1,
              child: SpinKitThreeBounce(color: whiteColor),
            )
          : user == null
          ? const Center(child: Text("No user data available"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.image!),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${user.firstName} ${user.lastName}",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: whiteColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email ?? "No Email",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: greyColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ReusableColumn(
                          placeHolder: firebasePosts.firebasePosts.length
                              .toString(),

                          holderName: "Posts",
                        ),
                        ReusableColumn(
                          placeHolder: "2.4K",
                          holderName: "Likes",
                        ),
                        ReusableColumn(placeHolder: "3M", holderName: "Views"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  userPostsProvider.isLoading
                      ? const SpinKitThreeBounce(color: whiteColor)
                      : userPostsProvider.error != null
                      ? Text(userPostsProvider.error!)
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              firebasePosts.firebasePosts.length,
                          itemBuilder: (context, index) {
                            final post =
                                firebasePosts.firebasePosts[index];
                            return ProfileCard(body: post.body?? 'something might wrong', user: user,index: index,);
                          },
                        ),
                ],
              ),
            ),
    );
  }
}

class ReusableColumn extends StatelessWidget {
  final String placeHolder;
  final String holderName;
  const ReusableColumn({
    required this.placeHolder,
    required this.holderName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          placeHolder,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: whiteColor,
          ),
        ),
        Text(
          holderName,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: greyColor,
          ),
        ),
      ],
    );
  }
}
