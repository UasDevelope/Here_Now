import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:here_now/app/modules/profile/widget/profile_shimmer_effect.dart';
import 'package:here_now/app/utils/image_utils.dart';
import '../../../utils/widgets.dart';

class Postscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = ControllerLocator.profileController;
    final controller = ControllerLocator.postController;
    return Obx(() => Scaffold(
          backgroundColor: AppColors.white,
          body: user.isLoading.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ProfileShimmerEffect(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
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
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align vertically
                                children: [
                                  user.user.value!.image == null
                                      ? CircleAvatar(
                                          radius:
                                              20, // Size of the circular image
                                          backgroundImage: AssetImage(Images
                                              .person), // Replace with your image path
                                        )
                                      : CircleAvatar(
                                          radius:
                                              20, // Size of the circular image
                                          backgroundImage: NetworkImage(
                                              "${user.user.value!.image}"), // Replace with your image path
                                        ),
                                  SizedBox(
                                      width:
                                          10), // Add spacing between the image and name
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.user.value!.firstName +
                                              user.user.value!.lastName,
                                          style: AppStyle.openSans(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        Text(
                                          user.user.value!.locationName,
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

                              InkWell(
                                onTap: () {
                                  ImageUtils.pickAndUpdateImage(
                                      controller.imagePath);
                                },
                                child: Text(
                                  AppString.addpicturevides,
                                  style: AppStyle.openSans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Obx(() => controller.imagePath.isNotEmpty
                                  ? Image.file(
                                      File(
                                        controller.imagePath.value,
                                      ),
                                      height: 40,
                                    )
                                  : Image.asset(
                                      Images.addimage,
                                      height: 40,
                                    )),

                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey,
                                      width: 1), // Add border
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                  color: Colors
                                      .white, // Background color for better contrast
                                ),
                                child: DropdownButton<String>(
                                  dropdownColor: AppColors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  value: controller.selectedCategory
                                      .value, // Selected category
                                  isExpanded: true,
                                  underline:
                                      const SizedBox(), // Removes the default underline
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      controller
                                          .updateSelectedCategory(newValue);
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
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
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
                                        dropdownColor: AppColors.white,
                                        value: controller
                                                .selectedNews.value.isEmpty
                                            ? null
                                            : controller.selectedNews
                                                .value, // Selected news type
                                        hint: const Text("Select News Type"),
                                        isExpanded: true,
                                        underline:
                                            const SizedBox(), // Removes the default underline
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            controller
                                                .updateSelectedNews(newValue);
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
                              Text(
                                AppString.title,
                                style: AppStyle.openSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800),
                              ),
                              if (!controller.currentNewsTypeOptions.isNotEmpty)
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        String? pickedDate =
                                            await controller.pickDate();
                                        if (pickedDate != null) {
                                          controller.startDate.value =
                                              pickedDate;
                                        }
                                      },
                                      child: Obx(() => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.calendar_today,
                                                    color: Colors.blue),
                                                const SizedBox(width: 12),
                                                Text(
                                                  controller.startDate.value
                                                          .isEmpty
                                                      ? 'Select Start Date'
                                                      : '${controller.startDate.value}',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                    const SizedBox(height: 20),

                                    // End Date Picker
                                    GestureDetector(
                                      onTap: () async {
                                        String? endDate =
                                            await controller.pickDate();
                                        if (endDate != null) {
                                          controller.endDate.value = endDate;
                                        }
                                      },
                                      child: Obx(() => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.calendar_month,
                                                    color: Colors.green),
                                                const SizedBox(width: 12),
                                                Text(
                                                  controller
                                                          .endDate.value.isEmpty
                                                      ? 'Select End Date'
                                                      : '${controller.endDate.value}'
                                                          .split(' ')[0],
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black54),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    AppTextField(
                                        obscureText: false,
                                        maxline: 4,
                                        keyboardType: TextInputType.phone,
                                        width: Get.width,
                                        height: Get.height / 18,
                                        hintText: AppString.contantno,
                                        controller:
                                            controller.contactController),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    AppTextField(
                                        obscureText: false,
                                        maxline: 4,
                                        keyboardType: TextInputType.number,
                                        width: Get.width,
                                        height: Get.height / 18,
                                        hintText: AppString.price,
                                        controller: controller.priceController),
                                  ],
                                ),
                              AppTextField(
                                  obscureText: false,
                                  maxline: 4,
                                  width: Get.width,
                                  height: Get.height / 18,
                                  hintText: AppString.title,
                                  controller: controller.titleController),
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
                                  controller: controller.descriptionController),
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
                                    if (controller.selectedCategory.value ==
                                        "Events") {
                                      controller.createEventPost();
                                    } else {
                                      controller.createNewsPost();
                                    }
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
                ),
        ));
  }
}
