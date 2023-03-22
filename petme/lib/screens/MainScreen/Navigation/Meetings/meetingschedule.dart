// // import 'package:flutter/material.dart';
// // import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:firebase_messaging/firebase_messaging.dart';
// //
// class MeetingSchedulingPage extends StatefulWidget {
//   final String petName;
//   final String ownerId;
//
//   MeetingSchedulingPage({required this.petName, required this.ownerId});
//
//   @override
//   _MeetingSchedulingPageState createState() => _MeetingSchedulingPageState();
// }
// //
// // class _MeetingSchedulingPageState extends State<MeetingSchedulingPage> {
// //   late DateTime _selectedDate;
// //   late TimeOfDay _selectedTime;
// //   late DatabaseReference _databaseRef;
// //   late FirebaseMessaging _fcm;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _selectedDate = DateTime.now();
// //     _selectedTime = TimeOfDay.now();
// //     _databaseRef = FirebaseDatabase.instance.reference().child('meetings');
// //     _fcm = FirebaseMessaging.instance;
// //   }
// //
// //   void _scheduleMeeting() {
// //     // Save the selected date and time to database
// //     _databaseRef.push().set({
// //       'petName': widget.petName,
// //       'ownerId': widget.ownerId,
// //       'date': _selectedDate.toString(),
// //       'time': _selectedTime.format(context),
// //       'status': 'Pending'
// //     }).then((value) {
// //       // Send a push notification to the owner's device using FCM
// //       _fcm.send(
// //         to: 'owner_device_token',
// //         notification: Notification(
// //           title: 'New Adoption Request',
// //           body: 'You have a new adoption request for ${widget.petName}',
// //         ),
// //       );
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           title: Text('Adoption Page'),
// //         ),
// //         body: Center(
// //             child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //             Text('Selected Date: ${_selectedDate.toLocal()}'),
// //         Text('Selected Time: ${_selectedTime.format(context)}'),
// //         SizedBox(height: 20),
// //         ElevatedButton(
// //           onPressed: () {
// //             DatePicker.showDatePicker(
// //               context,
// //               showTitleActions: true,
// //               minTime: DateTime.now(),
// //               maxTime: DateTime.now().add(Duration(days: 30)),
// //               onConfirm: (date) {
// //                 setState(() {
// //                   _selectedDate = date;
// //                 });
// //                 DatePicker.showTimePicker(
// //                   context,
// //                   showTitleActions: true,
// //                   onConfirm: (time) {
// //                     setState(() {
// //                       _selectedTime = time;
// //                     });
// //                   },
// //                   currentTime: _selectedTime,
// //                 );
// //               },
// //               currentTime: _selectedDate,
// //               locale: LocaleType.en,
// //             );
// //           },
// //           child: Text('Select Meeting Date & Time'),
// //         ),
// //         SizedBox(height: 20),
// //         ElevatedButton(
// //         onPressed: () {
// //       _scheduleMeeting();
// //       showDialog(
// //           context: context,
// //           builder: (context) => AlertDialog(
// //           title: Text('Adoption Request Sent'),
// //           content: Text(
// //               'Your adoption request has been sent to the owner.'),
// //           actions: [
// //               TextButton(
// //               onPressed: () {
// //         // Show a dialog to get the meeting date and time from the user
// //         showDialog(
// //         context: context,
// //         builder: (BuildContext context) {
// //           DateTime selectedDate = DateTime.now();
// //           TimeOfDay selectedTime = TimeOfDay.now();
// //           return AlertDialog(
// //             title: Text('Schedule Meeting'),
// //             content: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 // Date picker
// //                 ListTile(
// //                   title: Text('Date'),
// //                   subtitle: Text(
// //                     '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
// //                   ),
// //                   onTap: () async {
// //                     final DateTime? picked = await showDatePicker(
// //                       context: context,
// //                       initialDate: selectedDate,
// //                       firstDate: DateTime.now(),
// //                       lastDate: DateTime(2100),
// //                     );
// //                     if (picked != null && picked != selectedDate) {
// //                       setState(() {
// //                         selectedDate = picked;
// //                       });
// //                     }
// //                   },
// //                 ),
// //                 // Time picker
// //                 ListTile(
// //                   title: Text('Time'),
// //                   subtitle: Text('${selectedTime.format(context)}'),
// //                   onTap: () async {
// //                     final TimeOfDay? picked = await showTimePicker(
// //                       context: context,
// //                       initialTime: selectedTime,
// //                     );
// //                     if (picked != null && picked != selectedTime) {
// //                       setState(() {
// //                         selectedTime = picked;
// //                       });
// //                     }
// //                   },
// //                 ),
// //               ],
// //             ),
// //             actions: [
// //               // Cancel button
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.pop(context);
// //                 },
// //                 child: Text('CANCEL'),
// //               ),
// //               // Schedule button
// //               TextButton(
// //                 onPressed: () {
// //                   // TODO: Save the meeting schedule and notify the owner via email
// //                   Navigator.pop(context);
// //                 },
// //                 child: Text('SCHEDULE'),
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //     },
// //     child: Text('ADOPT'),
// //     ),

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:petme/screens/MainScreen/main_page.dart';

class MeetingsSchedulingPage extends StatefulWidget {
  final String petOwnerId;
  final String adopterId;
  final String ownerName;
  final String adopterName;

  MeetingsSchedulingPage({
    required this.petOwnerId,
    required this.ownerName,
    required this.adopterName,
    required this.adopterId
  });

  @override
  _MeetingsSchedulingPageState createState() => _MeetingsSchedulingPageState();
}

class _MeetingsSchedulingPageState extends State<MeetingsSchedulingPage> {
  late DateTime selectedDate = DateTime.now();
  late DateTime selectedTime = DateTime.now();
  late String location;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime as DateTime;
      });
    }
  }

  Future<void> _scheduleMeeting() async {
    if (
        selectedDate == null ||
        selectedTime == null ||
        location == null
    ) {
      // Show an error message if any of the fields are empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in all the fields.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Get.offAll(MainPage());
                }
              ),
            ],
          );
        },
      );
      return;
    }

    // Create a new meeting document in the "Meetings" collection
    DocumentReference meetingRef =
        await FirebaseFirestore.instance.collection('Meetings').add({
      'petOwnerId': widget.petOwnerId,
      'Adopter': widget.adopterName,
      'Pet-Owner': widget.ownerName,
      'adopterId': widget.adopterId,
      'date': Timestamp.fromDate(DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, selectedTime.hour, selectedTime.minute)),
      'location': location,
    });

    // Show a success message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Meeting scheduled!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // Navigator.of(context).pop();
                // Navigator.of(context)
                //     .pop();
                // Navigate back to the previous screen
                Get.offAll(MainPage());
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Meeting'),backgroundColor: Colors.pink[400],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Date: ', style: TextStyle(fontSize: 20),),
                  Text(selectedDate == null
                      ? '-'
                      : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}', style: TextStyle(fontSize: 20),),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                      const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      backgroundColor: Colors.pink[300],
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10.0)),
                    ),
                    child: const Text('Select Date', style: TextStyle(fontSize: 15),),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Time: ', style: TextStyle(fontSize: 20),),
                  Text(selectedTime == null
                      ? '-'
                      : '${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}', style: TextStyle(fontSize: 20),),
                  SizedBox(width: 60),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                      const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      backgroundColor: Colors.pink[300],
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10.0)),
                    ),
                    onPressed: () => _selectTime(context),
                    child: Text('Select Time', style: TextStyle(fontSize: 15),),
                  ),
                ],
              ),
              SizedBox(height: 60),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.pink[400]),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(
                        width: 2.0, color: Colors.pink),
                  )),


                onChanged: (value) => location = value,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  _scheduleMeeting;
                  Get.snackbar("Notification Sent to Owner",
                      "They will reply soon!",
                      colorText: Colors.greenAccent[400],
                      backgroundColor: Colors.white);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.fromLTRB(85, 10, 85, 10),
                  backgroundColor: Colors.pink[300],
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10.0)),
                ),
                child: const Text('Schedule Meeting', style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
