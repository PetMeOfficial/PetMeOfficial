import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  // Adding image to firebase storage
  Future<String> uploadImageToStorage(String childname, Uint8List file, bool isPost) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    Reference ref = storage.ref().child(childname).child(auth.currentUser!.uid);
    if(isPost){
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}