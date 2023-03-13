import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              'Q: How do I create an account?\nA: You can create an account by clicking on the "Sign up" button on the app\'s home screen.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 8),
            Text(
              'Q: How do I search for adoptable pets?\nA: You can search for adoptable pets by clicking on the "Find a Pet" button on the app\'s home screen and selecting your preferred search criteria.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 8),
            Text(
              'Q: How do I contact a pet adoption agency?\nA: You can contact a pet adoption agency by clicking on the "Contact Us" button on the pet adoption agency\'s profile page.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions or concerns about our pet adoption app, please contact us at:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: '),
                  Text('Phone: '),
                  Text('Address: '),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}