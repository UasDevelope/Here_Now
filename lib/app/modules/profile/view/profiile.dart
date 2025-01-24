import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:here_now/app/modules/events/widget/button.dart';
import 'package:here_now/app/modules/profile/widget/profile_shimmer_effect.dart';
import 'package:here_now/app/pages/pages.dart';
import 'package:here_now/app/utils/pref_util.dart';
import 'package:here_now/app/utils/widgets.dart';

import '../widget/profilerow.dart';

class ProfiileScreen extends StatelessWidget {
  const ProfiileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ControllerLocator.profileController;
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
                  AppString.settings,
                  style: AppStyle.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Divider(),
          Obx(() {
            if (controller.isLoading.value) {
              return ProfileShimmerEffect();
            } else {
              final data = controller.user.value!;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 30,
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Align vertically
                      children: [
                        CircleAvatar(
                          radius: 35, // Size of the circular image
                          backgroundImage: data.image == null
                              ? AssetImage(Images.person)
                              : NetworkImage(
                                  data.image!), // Replace with your image path
                        ),
                        SizedBox(
                            width:
                                10), // Add spacing between the image and name
                        Column(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data.firstName} ${data.lastName}",
                              style: AppStyle.openSans(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                              overflow:
                                  TextOverflow.ellipsis, // Handle long text
                              maxLines: 1,
                            ),
                            // Row(
                            //   spacing: 10,
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Image.asset(
                            //       Images.phone,
                            //       height: 20,
                            //     ),
                            //     Text(
                            //       '(+44)  20 1234 5629',
                            //       style: AppStyle.openSans(
                            //           color: Colors.black,
                            //           fontSize: 14,
                            //           fontWeight: FontWeight.w800),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              spacing: 4,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  Images.mail,
                                  height: 20,
                                ),
                                Text(
                                  data.email,
                                  style: AppStyle.openSans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                  overflow:
                                      TextOverflow.ellipsis, // Handle long text
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            log("data is $data");
                            Get.toNamed(Routes.editprofile, arguments: {
                              "data": data,
                            });
                          },
                          child: Image.asset(
                            Images.edit,
                            height: 70,
                          ),
                        )
                      ],
                    ),
                    EventButton(
                      text: AppString.logout,
                      textColor: AppColors.buttonColor,
                      width: Get.width / 1.1,
                      onPressed: () async {
                        await PrefUtil.remove(PrefUtil.token);
                        Get.offAllNamed(Routes.login);
                      },
                      buttonColor:
                          Color.fromRGBO(254, 61, 80, 0.06), // 6% alpha
                      imagePath: Images.logout,
                    ),
                    customProfileRow(
                        imagePath: Images.security,
                        text: AppString.security,
                        onPressed: () {
                          Get.toNamed(Routes.security);
                        }),
                    customProfileRow(
                        imagePath: Images.fqa,
                        text: AppString.fqa,
                        onPressed: () {
                          Get.toNamed(Routes.fqa);
                        }),
                    customProfileRow(
                        text: AppString.terrmofservice,
                        onPressed: () {
                          Get.toNamed(Routes.termsOfService);
                        }),
                    customProfileRow(
                        text: AppString.privacypolicy,
                        onPressed: () {
                          Get.toNamed(Routes.privacyPolicy);
                        }),
                    customProfileRow(
                        text: AppString.aboutapp,
                        onPressed: () {
                          Get.toNamed(Routes.aboutApp);
                        }),
                  ],
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
