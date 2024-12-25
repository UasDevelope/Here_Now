import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildFAQItem(
              question: 'How do I reset my password?',
              answer: 'Go to the settings page and click on "Reset Password". Follow the instructions sent to your email.',
            ),
            SizedBox(height: 10),
            _buildFAQItem(
              question: 'Can I delete my account?',
              answer: 'Yes, go to Account Settings, scroll to the bottom, and click "Delete Account". Keep in mind this action is irreversible.',
            ),
            SizedBox(height: 10),
            _buildFAQItem(
              question: 'How can I contact customer support?',
              answer: 'You can reach us via the "Contact Us" page, or send an email to support@ourapp.com.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({required String question, required String answer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          answer,
          style: TextStyle(fontSize: 16.0, height: 1.5),
        ),
      ],
    );
  }
}
