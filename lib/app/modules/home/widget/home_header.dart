import 'package:flutter/material.dart';

import '../../../utils/widgets.dart';

class HomeHeader extends StatelessWidget {
  final bool isNews;
  const HomeHeader({super.key, this.isNews = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height / 7,
      decoration: BoxDecoration(color: AppColors.appColor),
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Row(
          spacing: 20,
          children: [
            Image.asset(
              Images.logo,
              height: 75,
              fit: BoxFit.fill,
            ),
            InkWell(
              onTap: () {
                final newsController = ControllerLocator.homeController;
                if (isNews) {
                  newsController.changeSelectedNewsType("");
                  newsController.filteredNewsList.value =
                      newsController.newsList;
                }
                Get.toNamed(Routes.search, arguments: {"isNews": isNews});
              },
              child: Image.asset(
                Images.search,
                height: 30,
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.profile);
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
