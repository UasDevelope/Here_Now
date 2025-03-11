import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:here_now/app/modules/profile/controller/profile_controller.dart';
import 'package:here_now/app/modules/profile/widget/profile_shimmer_effect.dart';
import '../../../utils/widgets.dart';
import '../widget/location_picker_bottom_sheet.dart';

class Postscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Get.put(ProfileController());
    final controller = ControllerLocator.postController;
    final locationController = ControllerLocator.locationController;
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
                                  controller.showImageSourceDialog();
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
                                  height: Get.height / 5.9,
                                  hintText: AppString.typesomething,
                                  controller: controller.descriptionController),
                              Text(
                                AppString.location,
                                style: AppStyle.openSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800),
                              ),
                              AppTextField(
                                  readOnly: true,
                                  onTap: () {
                                    Get.bottomSheet(
                                      LocationPickerBottomSheet(),
                                      isScrollControlled:
                                          true, // To make sure the bottom sheet is not full height
                                    );
                                  },
                                  obscureText: false,
                                  maxline: 4,
                                  width: Get.width,
                                  height: Get.height / 18,
                                  hintText: AppString.location,
                                  controller:
                                      locationController.locationController),
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
                              ),
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
