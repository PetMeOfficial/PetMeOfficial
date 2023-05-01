import 'package:flutter/material.dart';
import 'package:petme/models/posts.dart';
import 'package:petme/screens/FirebaseFunctions/firestore_methods.dart';

class PetsProvider extends ChangeNotifier {
  List<Post> _pets = [];

  List<Post> get pets => _pets;

  set pets(List<Post> value) {
    _pets = value;
    notifyListeners();
  }

  Future<void> fetchPets() async {
    final firebaseService = FirestoreMethods();
    pets = await firebaseService.loadPets();
  }

  List<Post> get dogs {
    return pets.where((pet) => pet.petType == "Dog").toList();
  }

  List<Post> get cats {
    return pets.where((pet) => pet.petType == "Cat").toList();
  }

  List<Post> get birds {
    return pets.where((pet) => pet.petType == "Bird").toList();
  }

  List<Post> get other {
    return pets.where((pet) => pet.petType == "Other").toList();
  }

}
