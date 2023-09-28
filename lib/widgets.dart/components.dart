import 'package:flutter/material.dart';

Widget appBarIcon(IconData icon, ontap) {
  return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
        ),
      ));
}
