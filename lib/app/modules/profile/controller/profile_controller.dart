import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:here_now/app/utils/api_utils.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  RxString imagePath = "".obs;
  final user = Rxn<UserModel>();
  RxBool isLoading = false.obs;
  void storeDataInField(String firstName, String lastName, String email) {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    emailController.text = email;
  }

  Future<void> getProfileData() async {
    try {
      isLoading.value = true;
      final response = await ApiClient().get(ApiEndPoints.userDetail);
      log("Response is $response return type is ${response.runtimeType}");

      // Parse the response into the UserResponse model
      final userResponse =
          UserResponse.fromJson(response as Map<String, dynamic>);
      log("Parsed User First Name: ${userResponse.data.firstName}");
      log("Parsed User Email: ${userResponse.data.email}");
      user.value = userResponse.data;
    } catch (e) {
      ShortMessageUtils.showError("$e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }
}
