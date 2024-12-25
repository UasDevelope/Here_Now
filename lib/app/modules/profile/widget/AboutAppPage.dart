import 'package:flutter/material.dart';
import 'package:here_now/app/utils/widgets.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About App',
          style: AppStyle.openSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white, // White background for AppBar
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Consistent padding for the page
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Heading
            Text(
              'About This App',
              style: AppStyle.openSans(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16), // Space after heading

            // Welcome Text
            Text(
              'Welcome to our app! Our mission is to provide a seamless and intuitive experience for our users. Here are some features that make our app unique:',
              style: AppStyle.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.textfieldborder, // Subtle dark grey for body text
              ),
            ),
            SizedBox(height: 24), // Space before the feature list

            // Features List
            RichText(
              text: TextSpan(
                style: AppStyle.openSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textfieldborder,
                ),
                children: [
                  TextSpan(
                    text: '• User-Friendly Design: ',
                    style: AppStyle.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text:
                      'A clean and modern interface for effortless navigation.\n'),
                  TextSpan(
                    text: '• Powerful Features: ',
                    style: AppStyle.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text:
                      'Tools that simplify your daily tasks and enhance productivity.\n'),
                  TextSpan(
                    text: '• Secure Platform: ',
                    style: AppStyle.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text:
                      'Your data is protected with state-of-the-art security measures.'),
                ],
              ),
            ),
            SizedBox(height: 32), // Space after the feature list

            // Closing Text
            Text(
              'Thank you for choosing our app. We’re committed to exceeding your expectations and continuously improving your experience!',
              style: AppStyle.openSans(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.buttonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
