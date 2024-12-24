import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height / 7,
      decoration: BoxDecoration(color: AppColors.appColor),
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Row(
          spacing: 10,
          children: [
            Image.asset(
              Images.logo,
              height: 75,
              fit: BoxFit.fill,
            ),
            Image.asset(
              Images.search,
              height: 30,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.porofile);
              },
              child: Image.asset(
                Images.setting,
                height: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
