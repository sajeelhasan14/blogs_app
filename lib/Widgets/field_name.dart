import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';

class FieldName extends StatelessWidget {
  final String title;
  const FieldName({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: "Inter",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: greyColor,
      ),
    );
  }
}
