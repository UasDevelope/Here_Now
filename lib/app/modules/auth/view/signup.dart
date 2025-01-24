import 'package:flutter/material.dart';
import 'package:here_now/app/utils/validator_utils.dart';

import '../../../utils/widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerLocator.authController;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            child: Column(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.09,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/images/herenow.jpg"),
                  ),
                ),
                Text(
                  AppString.signup,
                  style: AppStyle.openSans(
                      fontSize: 30, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: Get.height * 0.01,
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
                      width: Get.width / 2.3,
                      height: 60,
                      validator:
                          Validators.validateRequired(AppString.firstname),
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
                      width: Get.width / 2.3,
                      height: 60,
                      validator:
                          Validators.validateRequired("AppString.lastname"),
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
                  maxline: 1,
                  width: Get.width,
                  validator: Validators.validateEmail,
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
                Text(
                  AppString.password,
                  style: AppStyle.openSans(
                      fontSize: 12, fontWeight: FontWeight.w800),
                ),
                AppTextField(
                  obscureText: true,
                  width: Get.width,
                  height: 60,
                  hintText: AppString.enterYourPassword,
                  controller: controller.passwordController,
                  keyboardType: TextInputType.name,
                  textColor: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  borderColor: AppColors.textfieldborder,
                  borderRadius: 10.0,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Center(
                  child: AppButton(
                    height: 50,
                    textWeight: FontWeight.w800,
                    textSize: 20,
                    width: Get.width / 1.2,
                    text: AppString.register,
                    textColor: AppColors.white,
                    borderRadius: 10,
                    onTap: () {
                      controller.registerUser();
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppString.alreadyHaveAndAccount,
                      style: AppStyle.openSans(
                          fontSize: 15,
                          color: Color(0xffBDBDBD),
                          fontWeight: FontWeight.w800),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.login);
                      },
                      child: Text(
                        AppString.login,
                        style: AppStyle.openSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.underline),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
