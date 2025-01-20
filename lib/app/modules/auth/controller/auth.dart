import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:here_now/app/services/tost.dart';
import 'package:here_now/app/utils/pref.dart';
import 'package:here_now/app/utils/string.dart';
import '../../../routes/routes.dart';
import '../../../services/api.dart';
import '../repository/auth.dart';

class AuthController extends GetxController {
  // TextEditingControllers for form inputs
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPassword = TextEditingController();
  // For Login
  TextEditingController loginEmailOrPhone = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  // Loading state
  RxBool showLoading = RxBool(false);

  // User registration function
  Future<void> registerUser() async {
    try {
      showLoading.value = true;

      var body = {
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim(),
        "email": signupEmail.text.trim(),
        "password": signupPassword.text.trim(),
        "lat": 234, // Static for now
        "long": 23632.435, // Static for now
        "locationName": "Pakistan", // Static for now
      };

      debugPrint("::::BODY-------->>$body");

      var response = await AuthRepo().authPost(ApiServices.registration, body);
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Log the response for debugging
        debugPrint("API RESPONSE====>${response.body}");
        print(response.statusCode);
        // Parse the response body

        // Show success toast with message
        CustomToast.showSuccess(
            responseBody["message"] ?? "Registration successful!");

        // Navigate to the next screen
        Get.toNamed(Routes.login);
      } else {
        CustomToast.showError(
            responseBody["message"] ?? "Registration successful!");
      }
    } catch (e) {
      CustomToast.showError("An error occurred: $e");
      debugPrint("Error: $e");
    } finally {
      showLoading.value = false; // Hide loading indicator
    }
  }

  Future<void> login() async {
    try {
      showLoading.value = true;

      // Ensure email and password are not empty
      if (loginEmailOrPhone.text.isEmpty || loginPassword.text.isEmpty) {
        CustomToast.showError("Please enter both email and password");
        return;
      }

      var body = {
        "email": loginEmailOrPhone.text.trim(),
        "password": loginPassword.text.trim(),
      };

      debugPrint("::::BODY-------->>$body");

      var response = await AuthRepo().authPost(ApiServices.login, body);
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      print(responseBody);
      // Ensure we parse the response body safely
      if (response.statusCode == 200) {
        // Safely check if the 'token' key exists and is not null
        if (responseBody.containsKey('token') &&
            responseBody['token'] != null) {
          String token = responseBody['token'];

          // Save the token to preferences
          await PrefUtil.setString(PrefUtil.changeToken, token);

          CustomToast.showSuccess(
              responseBody['message'] ?? "Login successful!");
          Get.toNamed(Routes.bottomNav);
        } else {
          CustomToast.showError("Token is missing in the response.");
        }
      } else {
        CustomToast.showError(responseBody['message'] ?? "An error occurred");
      }
    } catch (e) {
      CustomToast.showError("Error: $e");
      debugPrint("Error: $e");
    } finally {
      showLoading.value = false;
    }
  }
}
