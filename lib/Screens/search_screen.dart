import 'package:blogs_app/Provider/tags_stories_provider.dart';
import 'package:blogs_app/Widgets/tags_data_card.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TagPostsScreen extends StatefulWidget {
  TagPostsScreen({super.key});

  final List<String> tags = [
    "All Stories",
    "Life",
    "Nature",
    "French",
    "Love",
    "Books",
  ];

  @override
  State<TagPostsScreen> createState() => _TagPostsScreenState();
}

class _TagPostsScreenState extends State<TagPostsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TagsStoriesProvider>(
        context,
        listen: false,
      ).fetchTagsData("all");
    });
  }

  @override
  Widget build(BuildContext context) {
    final tagProvider = Provider.of<TagsStoriesProvider>(context);

    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        centerTitle: true,
        title: Text(
          "Search",
          style: TextStyle(
            fontFamily: "inter",
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
          // 🔍 Search bar
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: greyColor,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search stories...",
                hintStyle: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: greyColor,
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                context.read<TagsStoriesProvider>().updateSearchQuery(value);
              },
            ),
          ),

          // 🔹 Tags Row
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(widget.tags.length, (index) {
              final isSelected = tagProvider.selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  tagProvider.setIndex(index);
                  widget.tags[index].toLowerCase() == 'all stories'
                      ? tagProvider.fetchTagsData("all")
                      : tagProvider.fetchTagsData(
                          widget.tags[index].toLowerCase(),
                        ); // ✅ fetch specific tag
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue : Colors.grey[900],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.tags[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 15),

          // 🔹 Posts list
          Expanded(
            child: Consumer<TagsStoriesProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: SpinKitThreeBounce(color: whiteColor),
                  );
                }
                if (provider.search.isEmpty) {
                  return const Center(child: Text("No posts available"));
                }
                return ListView.builder(
                  itemCount: provider.search.length,
                  itemBuilder: (context, index) {
                    final post = provider.search[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TagsDataCard(
                        title: post.title!,
                        body: post.body!,
                        likes: post.reactions!.likes!,
                        dislikes: post.reactions!.dislikes!,
                        views: post.views!,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
