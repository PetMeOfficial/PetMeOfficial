import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Privacy Policy'),
      //   backgroundColor: Color(0xFF487776),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy\n',
                style: Theme.of(context).textTheme.headlineSmall,
              ),Text(
                'Introduction',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'We take the privacy and security of your personal information very seriously. This Privacy Policy explains how we collect, use, and protect your personal information when you use our pet adoption app. By using our app, you agree to the terms of this Privacy Policy.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Information We Collect',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'When you use our pet adoption app, we may collect the following types of information:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('• Name'),
                    Text('• Email address'),
                    Text('• Phone number'),
                    Text('• Address'),
                    Text('• Pet preferences'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'How We Use Your Information',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'We may use the information we collect from you to:',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('• Connect you with pet adoption agencies'),
                    Text('• Improve our app and services'),
                    Text('• Communicate with you about your pet adoption preferences'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Information Sharing',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'We may share your information with third-party pet adoption agencies to connect you with adoptable pets.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Data Security',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'We take reasonable measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. However, no method of transmission over the internet or electronic storage is completely secure.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Changes to this Privacy Policy',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                  'We may update this Privacy Policy from time to time. If we make any material changes, we will notify you by email (if you have provided one) or by posting a notice in our app.'),
            ],
          ),
        ),
      ),
    );
  }
}