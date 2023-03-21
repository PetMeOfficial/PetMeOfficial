import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:petme/models/user.dart';
import 'package:petme/screens/FirebaseFunctions/auth_methods.dart';


class OwnerProvider with ChangeNotifier {
  User? _user;
  String? id;
  final AuthMethods _authMethods = AuthMethods();

  OwnerProvider(this.id) {
    _getOwner();
  }


  void _getOwner() {
    FirebaseFirestore.instance
        .collection('Adopters')
        .doc(id)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) async {
      _user = User.fromSnap(documentSnapshot);
      notifyListeners();
    });
  }

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}