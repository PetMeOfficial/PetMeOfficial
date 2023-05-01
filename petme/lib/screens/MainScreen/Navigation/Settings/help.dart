import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';


class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     centerTitle: false,
      //     title: Align(
      //       alignment: Alignment.centerLeft,
      //       child: Text('Help & Support'), // Set the background color
      //     )
      //
      // ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Text(
              'If you have any questions or concerns about our pet adoption app, please feel free to contact us through the following channels:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email: support@petme.com',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Phone: +91 79770 16965',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Address: Sector 29, Nigdi Pradhikaran, Akurdi, Pune, Maharashtra 411044',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Report a Problem',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16),
            Text(
              'If you encounter any issues or problems with our app, please let us know by filling out the form below:',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF487776), // Set border color to green when the TextField is focused
                        ),
                      ),

                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF487776), // Set border color to green when the TextField is focused
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // Save the email address to a variable or database
                    },
                  ),

                  SizedBox(height: 8),
                  TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Problem description',
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF487776), // Set border color to green when the TextField is focused
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Get.snackbar("Server Down, Please Try Again!", "or Email Us at: support@petme.com",
                          colorText: Color(0xFF487776),
                          backgroundColor: Color(0xFFF5F5DC));
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                      // padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                      padding: const EdgeInsets.fromLTRB(
                          80, 10, 80, 10),
                      backgroundColor: Color(0xFF487776),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
