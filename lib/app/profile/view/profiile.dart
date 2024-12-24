import 'package:flutter/material.dart';
import 'package:here_now/app/modules/events/widget/button.dart';

import '../../utils/widgets.dart';

class ProfiileScreen extends StatelessWidget {
  const ProfiileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            spacing: 50,
            children: [
              Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
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
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Align vertically
                  children: [
                    CircleAvatar(
                      radius: 30, // Size of the circular image
                      backgroundImage: AssetImage(
                          Images.person), // Replace with your image path
                    ),
                    SizedBox(
                        width: 10), // Add spacing between the image and name
                    Column(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'John Doe',
                          style: AppStyle.openSans(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                        Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.phone,
                              height: 20,
                            ),
                            Text(
                              '(+44)  20 1234 5629',
                              style: AppStyle.openSans(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              Images.mail,
                              height: 20,
                            ),
                            Text(
                              'thomas.abc.inc@gmail.com',
                              style: AppStyle.openSans(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      Images.edit,
                      height: 70,
                    ),
                  ],
                ),
                EventButton(
                  text: AppString.logout,
                  textColor:AppColors.buttonColor,
                  width:Get.width/1.1,
                  onPressed: () {},
                  buttonColor: Color.fromRGBO(254, 61, 80, 0.06), // 6% alpha
                  imagePath: Images.logout,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
