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
