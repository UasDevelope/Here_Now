import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:here_now/app/modules/profile/model/profile_model.dart';
import 'package:here_now/app/utils/validator_utils.dart';

import '../../../utils/widgets.dart';

class Editprofile extends StatelessWidget {
  const Editprofile({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final controller = ControllerLocator.profileController;
    log("Arguments ${arguments["data"]}");
    UserModel userModel = arguments["data"] as UserModel;
    log("User name ${userModel.firstName}");
    controller.storeDataInField(
        userModel.firstName, userModel.lastName, userModel.email);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 50,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                Text(
                  AppString.editprofile,
                  style: AppStyle.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(Images.person),
                  ),
                ),
                Center(
                  child: Text(
                    "Upload New Picture",
                    style: GoogleFonts.openSans(
                      color: AppColors.appColor, // Text color
                      fontSize: 16, // Font size
                      fontWeight: FontWeight.bold, // Font weight
                      decoration: TextDecoration.underline, // Adds underline
                      decorationColor: Colors.black, // Underline color
                      decorationThickness: 4, // Thickness of underline
                    ),
                  ),
                ),
                Text(
                  AppString.username,
                  style: AppStyle.openSans(
                      fontSize: 12, fontWeight: FontWeight.w800),
                ),
                Row(
                  spacing: 20,
                  children: [
                    AppTextField(
                      validator:
                          Validators.validateRequired(AppString.firstname),
                      width: Get.width / 2.3,
                      height: 60,
                      hintText: AppString.firstname,
                      controller: controller.firstNameController,
                      keyboardType: TextInputType.name,
                      textColor: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      borderColor: AppColors.textfieldborder,
                      borderRadius: 10.0,
                    ),
                    AppTextField(
                      validator:
                          Validators.validateRequired(AppString.lastname),
                      width: Get.width / 2.3,
                      height: 60,
                      hintText: AppString.lastname,
                      controller: controller.lastNameController,
                      keyboardType: TextInputType.name,
                      textColor: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      borderColor: AppColors.textfieldborder,
                      borderRadius: 10.0,
                    ),
                  ],
                ),
                Text(
                  AppString.email,
                  style: AppStyle.openSans(
                      fontSize: 12, fontWeight: FontWeight.w800),
                ),
                AppTextField(
                  validator: Validators.validateRequired(AppString.email),
                  maxline: 1,
                  width: Get.width,
                  height: 60,
                  hintText: AppString.enterYourEmail,
                  controller: controller.emailController,
                  keyboardType: TextInputType.name,
                  textColor: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  borderColor: AppColors.textfieldborder,
                  borderRadius: 10.0,
                ),
                // Text(
                //   AppString.password,
                //   style: AppStyle.openSans(
                //       fontSize: 12, fontWeight: FontWeight.w800),
                // ),
                // AppTextField(
                //   obscureText: true,
                //   width: Get.width,
                //   height: 60,
                //   hintText: AppString.enterYourPassword,
                //   controller: TextEditingController(),
                //   keyboardType: TextInputType.name,
                //   textColor: Colors.black,
                //   fontSize: 11,
                //   fontWeight: FontWeight.w800,
                //   borderColor: AppColors.textfieldborder,
                //   borderRadius: 10.0,
                // ),
              ],
            ),
          ),
          Spacer(),
          Center(
            child: AppButton(
              height: 50,
              textWeight: FontWeight.w800,
              textSize: 20,
              width: Get.width / 1.2,
              text: AppString.savechanges,
              textColor: AppColors.white,
              borderRadius: 10,
              onTap: () {
                Get.toNamed(Routes.bottomNav);
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
