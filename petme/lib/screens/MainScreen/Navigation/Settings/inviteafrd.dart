import 'package:flutter/material.dart';
import 'package:share/share.dart';

class InviteFriendPage extends StatelessWidget {
  const InviteFriendPage({Key? key}) : super(key: key);

  Future<void> shareApp() async {
    await Share.share(
        'Check out our Pet Adoption App! https://www.example.com/app');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Invite a Friend'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invite Friends to Our Pet Adoption App',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Share our app with your friends and help more pets find their forever homes!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'How to Invite a Friend:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '1. Open the app and navigate to the Invite a Friend page.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '2. Tap the "Invite" button.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '3. Choose your preferred method of sharing (email, text message, social media, etc.).',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '4. Send the invitation and wait for your friend to join!',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => shareApp(),
              style: ElevatedButton.styleFrom(
                // padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                padding: const EdgeInsets.fromLTRB(
                    80, 10, 80, 10),
                backgroundColor: const Color(0xFF487776),
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(10.0)),
              ),
              child: const Text('Share App'),
            ),
          ],
        ),
      ),
    );
  }
}