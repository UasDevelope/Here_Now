import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:here_now/app/utils/colors.dart';

class CustomToast {
  /// Success Toast
  static void showSuccess(String message) {
    _showToast(message, AppColors.authlabel);
  }

  /// Error Toast
  static void showError(String message) {
    _showToast(message, AppColors.appColor);
  }

  /// Warning Toast
  static void showWarning(String message) {
    _showToast(message, Colors.orange);
  }

  /// Info Toast
  static void showInfo(String message) {
    _showToast(message, Colors.blue);
  }

  /// General private toast method
  static void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // Can be LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // Position: TOP, CENTER, or BOTTOM
      timeInSecForIosWeb: 3, // For iOS/Web duration
      backgroundColor: backgroundColor, // Background color
      textColor: Colors.white, // Text color
      fontSize: 16.0, // Font size
    );
  }
}
