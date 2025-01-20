import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';

class Postscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = ControllerLocator.postController;
    return Obx(() => Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              spacing: 2,
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
                              width:
                                  10), // Add spacing between the image and name
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
                      Text(
                        AppString.title,
                        style: AppStyle.openSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey, width: 1), // Add border
                          borderRadius:
                              BorderRadius.circular(10), // Rounded corners
                          color: Colors
                              .white, // Background color for better contrast
                        ),
                        child: DropdownButton<String>(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          value: controller
                              .selectedCategory.value, // Selected category
                          isExpanded: true,
                          underline:
                              const SizedBox(), // Removes the default underline
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.updateSelectedCategory(newValue);
                            }
                          },
                          items: controller.categoryToNewsType.keys
                              .map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                        ),
                      ),

                      // Show News Type dropdown only when there are news type options available
                      if (controller.currentNewsTypeOptions.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Select News Type:",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 1), // Border added
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                                color: Colors
                                    .white, // Background color for better contrast
                              ),
                              child: DropdownButton<String>(
                                value: controller.selectedNews.value.isEmpty
                                    ? null
                                    : controller.selectedNews
                                        .value, // Selected news type
                                hint: const Text("Select News Type"),
                                isExpanded: true,
                                underline:
                                    const SizedBox(), // Removes the default underline
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    controller.updateSelectedNews(newValue);
                                  }
                                },
                                items: controller.currentNewsTypeOptions
                                    .map((String newsType) {
                                  return DropdownMenuItem<String>(
                                    value: newsType,
                                    child: Text(newsType),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),

                      AppTextField(
                          obscureText: false,
                          maxline: 4,
                          width: Get.width,
                          height: Get.height / 16,
                          hintText: AppString.title,
                          controller: TextEditingController()),
                      Text(
                        AppString.description,
                        style: AppStyle.openSans(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
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
        ));
  }
}
