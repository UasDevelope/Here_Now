import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'We value your privacy and are committed to protecting your personal information. Below are some key points:',
              style: TextStyle(fontSize: 16.0, height: 1.5),
            ),
            SizedBox(height: 10),
            Text(
              '- **Data Collection:** We collect data to enhance your user experience.\n'
                  '- **Data Usage:** Your data is used only for the purposes mentioned in our policy.\n'
                  '- **Third-Party Sharing:** We do not sell your data to third parties.',
              style: TextStyle(fontSize: 16.0, height: 1.7),
            ),
            SizedBox(height: 20),
            Text(
              'For more detailed information, please read the complete Privacy Policy available on our website.',
              style: TextStyle(fontSize: 16.0, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
