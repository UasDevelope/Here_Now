import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';

Widget customProfileRow({
  String? imagePath,
  required String text,
  required VoidCallback onPressed,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: InkWell(
      onTap: onPressed,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              if (imagePath != null) ...[
                Image.asset(
                  imagePath,
                  height: 20,
                ),
                const SizedBox(width: 15),
              ],
              Text(
                text, // Text argument
                style: AppStyle.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          // Forward Icon
          const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Colors.black,
          ),
        ],
      ),
    ),
  );
}
