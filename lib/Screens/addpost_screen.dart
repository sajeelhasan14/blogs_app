import 'package:blogs_app/Provider/tag_creator_provider.dart';
import 'package:blogs_app/Services/addpost_service.dart';
import 'package:blogs_app/Widgets/field_name.dart';
import 'package:blogs_app/Widgets/reusable_textfields.dart';
import 'package:blogs_app/Provider/post_provider.dart';
import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({super.key});

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _tagController = TextEditingController();
  @override
  void dispose() {
    // Clean memory jab screen destroy ho
    _titleController.dispose();
    _bodyController.dispose();
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: backColor,
        centerTitle: true,
        title: Text(
          "Add Post",
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldName(title: "Title"),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 25),
                child: ReusableTextField(
                  controller: _titleController,
                  size: 63,
                  hintTitle: "Enter post title...",
                ),
              ),
              FieldName(title: "Body"),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 25),
                child: ReusableTextField(
                  controller: _bodyController,
                  size: 230,
                  hintTitle: "Enter your post content...",
                ),
              ),
              FieldName(title: "Tags"),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Consumer<TagCreatorProvider>(
                              builder: (context, tagProvider, child) {
                                return Wrap(
                                  spacing: 8,
                                  children: tagProvider.tags
                                      .map(
                                        (tag) => Chip(
                                          label: Text(
                                            tag,
                                            style: TextStyle(color: whiteColor),
                                          ),
                                          backgroundColor: Colors.blue,
                                          deleteIcon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                          onDeleted: () =>
                                              tagProvider.removeTag(tag),
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: TextField(
                                  controller: _tagController,
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: greyColor,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: cardColor,
                                    hintText: "Add a tag...",
                                    hintStyle: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                      color: greyColor,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: backColor),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: whiteColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {},
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                final tagText = _tagController.text.trim();
                                if (tagText.isNotEmpty) {
                                  Provider.of<TagCreatorProvider>(
                                    context,
                                    listen: false,
                                  ).addTag(tagText);
                                  _tagController
                                      .clear(); // ✅ clear after adding
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    final title = _titleController.text.trim();
                    final body = _bodyController.text.trim();

                    if (title.isEmpty || body.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please fill in both Title and Body before saving.",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // 👈 stop execution here
                    }

                    final success = await AddpostService().addPostFirestore(
                      title,
                      body,
                    );

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          success
                              ? "Post saved successfully!"
                              : "Failed to add post",
                        ),
                        backgroundColor: success ? Colors.green : Colors.red,
                      ),
                    );

                    if (success && mounted) {
                      await context.read<PostProvider>().fetchPosts();
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save, color: whiteColor),
                        SizedBox(width: 10),
                        Text(
                          "Save Post",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
