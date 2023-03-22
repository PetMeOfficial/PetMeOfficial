import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Meeting {
  String id;
  String petOwnerId;
  String adopterId;
  String adopterName;
  String ownerName;
  DateTime date;
  String location;

  Meeting({
    required this.id,
    required this.petOwnerId,
    required this.adopterId,
    required this.adopterName,
    required this.ownerName,
    required this.date,
    required this.location
  });
}

class MeetingsPage extends StatefulWidget {
  @override
  _MeetingsPageState createState() => _MeetingsPageState();
}

class _MeetingsPageState extends State<MeetingsPage> {

  Future<List<Meeting>> getMeetingsFromDatabase() async {
    List<Meeting> meetings = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Meetings').get();
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      meetings.add(Meeting(
        id: doc.id,
        petOwnerId: data['petOwnerId'] as String,
        adopterId: data['adopterId'] as String,
        date: (data['date'] as Timestamp).toDate(),
        location: data['location'] as String,
        adopterName: data['adopterName'] as String,
        ownerName: data['ownerName'] as String,
      ));
    });
    return meetings;
  }

  List<Meeting> meetings = [];

  @override
  void initState() {
    super.initState();
    getMeetings();
  }

  void getMeetings() async {
    meetings = await getMeetingsFromDatabase();
    setState(() {});
  }
  Future<void> deleteMeeting(String meetingId) async {
    await FirebaseFirestore.instance.collection('Meetings').doc(meetingId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child:  Text('Meetings', style: GoogleFonts.notoSans(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),)),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Container(
        color: Colors.deepPurple[300],
        child: ListView.builder(
          itemCount: meetings.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Container(
                height: 170,
                width: 300,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.lightBlueAccent
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListTile(
                    title: Text(
                      "Meeting Id: ${meetings[index].id}",
                      style: TextStyle(color: Colors.white,fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "\nMeeting between ${meetings[index].ownerName.toUpperCase()} "
                        "and ${meetings[index].adopterName.toUpperCase()}\nScheduled for ${meetings[index].date.day}-${meetings[index].date.month}-${meetings[index].date.year} \n"
                            "at Time:- ${meetings[index].date.hour}:${meetings[index].date.minute}\n"
                        "at Location: ${meetings[index].location}",
                      style: const TextStyle(color: Colors.black87, fontSize: 16),),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        // Delete the meeting from the database
                        await deleteMeeting(meetings[index].id);
                        // Remove the meeting from the 'meetings' list
                        meetings.removeAt(index);
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
