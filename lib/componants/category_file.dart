// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  Category({super.key, this.text, this.color, this.onTap});
  String? text;
  Color? color;
  Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        color: color,
        height: 70,
        width: double.infinity,
        child: Text(
          text!,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
