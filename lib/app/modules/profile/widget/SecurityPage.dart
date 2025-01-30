import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Security Matters',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We take your security very seriously. Here are the steps we take to protect your data:',
                style: TextStyle(fontSize: 16.0, height: 1.5),
              ),
              SizedBox(height: 10),
              Text(
                '- **Encryption:** All sensitive data is encrypted using the latest technologies.\n'
                    '- **Secure Authentication:** We use multi-factor authentication to prevent unauthorized access.\n'
                    '- **Regular Updates:** Our systems are regularly updated to ensure maximum security against vulnerabilities.\n'
                    '- **User Awareness:** Stay vigilant by using strong passwords and avoiding sharing your credentials.',
                style: TextStyle(fontSize: 16.0, height: 1.7),
              ),
              SizedBox(height: 20),
              Text(
                'If you notice any suspicious activity, please contact our support team immediately.',
                style: TextStyle(fontSize: 16.0, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
