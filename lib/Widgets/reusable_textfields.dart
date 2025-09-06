import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? size;
  final String hintTitle;
  const ReusableTextField({
    required this.controller,
    this.size,
    required this.hintTitle,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: size,
      child: TextField(
        controller: controller,
        maxLines: null, // allows unlimited lines
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
          fontFamily: "Inter",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: greyColor,
        ),
        decoration: InputDecoration(
          fillColor: cardColor,
          filled: true,
          hintText: hintTitle,
          hintStyle: TextStyle(
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: greyColor,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: backColor),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // ✅ same radius
            borderSide: BorderSide(color: whiteColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
