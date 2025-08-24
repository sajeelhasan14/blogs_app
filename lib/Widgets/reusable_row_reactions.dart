import 'package:blogs_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ReusableRow extends StatelessWidget {
  final String text;
  final String path;
  final Color? color;
  const ReusableRow({
    required this.text,
    required this.path,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(path),
        SizedBox(width: 2),
        Text(
          text,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: color ?? whiteColor,
          ),
        ),
      ],
    );
  }
}
