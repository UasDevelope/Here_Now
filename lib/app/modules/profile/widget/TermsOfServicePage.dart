import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms of Service',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'By using our application, you agree to the following terms and conditions:',
              style: TextStyle(fontSize: 16.0, height: 1.5),
            ),
            SizedBox(height: 10),
            Text(
              '- You must not use the app for any unlawful purposes.\n'
              '- Any misuse of the app may result in account suspension.\n'
              '- We reserve the right to modify or terminate services at any time.',
              style: TextStyle(fontSize: 16.0, height: 1.7),
            ),
            SizedBox(height: 20),
            Text(
              'For more details, please visit our website or contact support.',
              style: TextStyle(fontSize: 16.0, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
