import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Color textColor;
  final Color hintColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final Function(String)? onChanged;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? onSuffixTap;
  final int maxline;
  const AppTextField({
    Key? key,
    required this.width,
    required this.height,
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textColor = Colors.black,
    this.hintColor = Colors.grey,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.normal,
    this.borderColor = Colors.grey,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.maxline = 1, // default to 1
    this.padding = const EdgeInsets.symmetric(horizontal: 12.0),
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        maxLines: obscureText ? 1 : maxline,  // Enforce single line if obscureText is true
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,
        style: GoogleFonts.openSans(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        decoration: InputDecoration(
          contentPadding: padding,
          hintText: hintText,
          hintStyle: GoogleFonts.openSans(
            color: hintColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: hintColor) : null,
          suffixIcon: suffixIcon != null
              ? GestureDetector(
            onTap: onSuffixTap,
            child: Icon(suffixIcon, color: hintColor),
          )
              : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: borderColor, width: borderWidth),
          ),
        ),
      ),
    );
  }
}
