import 'package:flutter/material.dart';
import 'package:here_now/app/utils/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.1, // Top spacing
              ),
              Center(
                child: Text(
                  AppString.login,
                  style: AppStyle.openSans(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.08, // Spacing below title
              ),
              // Email Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppString.email,
                  style: AppStyle.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              AppTextField(
                width: Get.width,
                height: 60,
                hintText: AppString.enterYourEmail,
                controller: TextEditingController(),
                keyboardType: TextInputType.emailAddress,
                textColor: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                borderColor: AppColors.textfieldborder,
                borderRadius: 10.0,
              ),
              SizedBox(height: 20),
              // Password Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppString.password,
                  style: AppStyle.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(height: 10),
              AppTextField(
                obscureText: true,
                width: Get.width,
                height: 60,
                hintText: AppString.enterYourPassword,
                controller: TextEditingController(),
                keyboardType: TextInputType.text,
                textColor: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                borderColor: AppColors.textfieldborder,
                borderRadius: 10.0,
              ),
              SizedBox(
                height: Get.height * 0.3, // Spacing above button
              ),
              // Login Button
              Center(
                child: AppButton(
                  height: 50,
                  textWeight: FontWeight.w800,
                  textSize: 20,
                  width: Get.width * 0.8,
                  text: AppString.login,
                  textColor: AppColors.white,
                  borderRadius: 10,
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: Get.height * 0.02, // Spacing before footer
              ),
              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppString.dontHaveAnAccount,
                    style: AppStyle.openSans(
                      fontSize: 15,
                      color: Color(0xffBDBDBD),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.signup);
                    },
                    child: Text(
                      AppString.signup,
                      style: AppStyle.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.05, // Bottom padding
              ),
            ],
          ),
        ),
      ),
    );
  }
}
