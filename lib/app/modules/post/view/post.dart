import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';

class Postscreen extends StatelessWidget {
  const Postscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          spacing: 15,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                AppString.createnewpost,
                style: AppStyle.openSans(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align vertically
                    children: [
                      CircleAvatar(
                        radius: 20, // Size of the circular image
                        backgroundImage: AssetImage(
                            Images.person), // Replace with your image path
                      ),
                      SizedBox(
                          width: 10), // Add spacing between the image and name
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text(
                              'John Doe',
                              style: AppStyle.openSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800),
                            ),
                            Text(
                              'Location',
                              style: AppStyle.openSans(
                                  color: AppColors.textfieldborder,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    AppString.addpicturevides,
                    style: AppStyle.openSans(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w800),
                  ),
                  Image.asset(
                    Images.addimage,
                    height: 40,
                  ),
                  AppTextField(
                      obscureText: false,
                      maxline: 6,
                      width: Get.width,
                      height: Get.height / 2.8,
                      hintText: AppString.typesomething,
                      controller: TextEditingController()),
                  Center(
                    child: AppButton(
                      height: 50,
                      textWeight: FontWeight.w800,
                      textSize: 20,
                      width: Get.width / 1.2,
                      text: AppString.postnow,
                      textColor: AppColors.white,
                      borderRadius: 10,
                      onTap: () {
                        // Get.toNamed(Routes.bottomNav);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
