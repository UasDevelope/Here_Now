import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:here_now/app/controllers/controller_locator.dart';
import 'package:here_now/app/modules/loading/widget/custom_loading_widget.dart';
import 'package:here_now/app/utils/api_utils.dart';
import 'package:here_now/app/utils/pref_util.dart';
import 'package:here_now/app/utils/short_message_utils.dart';
import 'package:here_now/main.dart';
import '../../../routes/routes.dart';

class AuthController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  void clearAll() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }

  Future<void> loginUser() async {
    try {
      if (globalFormKey.currentState!.validate()) {
        CustomLoadingDialog.showCustomLoadingDialog("Logging in user...");
        final response = await ApiClient().post(ApiEndPoints.login, {
          "email": emailController.text,
          "password": passwordController.text
        });
        log("Response is $response");
        PrefUtil.setString(PrefUtil.token, response["token"]);
        clearAll();
        CustomLoadingDialog.closeLoadingDialog();
        Get.offAllNamed(Routes.bottomNav);
      } else {
        ShortMessageUtils.showError("Please fill all fields");
      }
    } catch (e) {
      ShortMessageUtils.showError("$e");
    } finally {
      CustomLoadingDialog.closeLoadingDialog();
    }
  }

  Future<void> registerUser() async {
    try {
      if (globalFormKey.currentState!.validate()) {
        final controller = ControllerLocator.locationController;
        CustomLoadingDialog.showCustomLoadingDialog(
            "Creating user account....");
        final Map<String, dynamic> payload = {
          "firstName": firstNameController.text.trim(),
          "lastName": lastNameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
          "lat": controller.latitude.value,
          "long": controller.longitude.value,
          "locationName": controller.userLocation['locationName'],
        };
        String endPoint = ApiEndPoints.register;
        final response = await ApiClient().post(endPoint, payload);
        CustomLoadingDialog.closeLoadingDialog();
        ShortMessageUtils.showSuccess("${response["message"]}");
        clearAll();
        Get.toNamed(Routes.login);
      } else {
        ShortMessageUtils.showError("Please fill all fields");
      }
    } catch (e) {
      CustomLoadingDialog.closeLoadingDialog();
      ShortMessageUtils.showError("$e");
    } finally {}
  }
}
