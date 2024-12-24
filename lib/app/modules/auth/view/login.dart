import 'package:flutter/material.dart';
import 'package:here_now/app/utils/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            spacing: 7,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                  child: Image.asset(
                Images.login,
                height: Get.height / 2.2,
                width: Get.width,
                fit: BoxFit.cover,
              )),
              Text(
                AppString.login,
                style: AppStyle.openSans(
                    fontSize: 30, fontWeight: FontWeight.w800),
              ),
              Text(
                AppString.email,
                style: AppStyle.openSans(
                    fontSize: 12, fontWeight: FontWeight.w800),
              ),
              AppTextField(
                width: Get.width,
                height: 60,
                hintText: AppString.enterYourEmail,
                controller: TextEditingController(),
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
                controller: TextEditingController(),
                keyboardType: TextInputType.name,
                textColor: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                borderColor: AppColors.textfieldborder,
                borderRadius: 10.0,
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppString.dontHaveAnAccount,
                    style: AppStyle.openSans(
                        fontSize: 15,
                        color: Color(0xffBDBDBD),
                        fontWeight: FontWeight.w800),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.signup);
                    },
                    child: Text(
                      AppString.signup,
                      style: AppStyle.openSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppColors.underline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: AppButton(
                  height: 50,
                  textWeight: FontWeight.w800,
                  textSize: 20,
                  width: Get.width / 1.2,
                  text: AppString.login,
                  textColor: AppColors.white,
                  borderRadius: 10,
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
