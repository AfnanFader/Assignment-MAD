import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:assignment_project/model/pet.dart';

class PetNotifier with ChangeNotifier {
  List<Pet> _petslist = [];
  Pet _currentpet;

  UnmodifiableListView<Pet> get petlist => UnmodifiableListView(_petslist);

  Pet get currentpet => _currentpet;

  set petlist(List<Pet> petlist) {
    _petslist = petlist;
    notifyListeners();
  }

  set currentPet(Pet pet) {
    _currentpet = pet;
    notifyListeners();
  }
}
