import 'package:flutter/cupertino.dart';
import 'package:petroapp/models/architect.dart';
import 'package:petroapp/models/objects.dart';
import '../models/residence.dart';

class ResidenceSelectedService extends ChangeNotifier {
  late Residence _selectedResidence;

  Residence get selectedResidence => _selectedResidence;

  set selectedResidence(Residence value) {
    _selectedResidence = value;
  }

  late Architect _selectedArchitect;
  late Objct _selectedObject;
  late List<Architect> _selectedList;

  Architect get selectedArchitect => _selectedArchitect;

  set selectedArchitect(Architect value) {
    _selectedArchitect = value;
  }

  Objct get selectedObject => _selectedObject;

  set selectedObject(Objct value) {
    _selectedObject = value;
  }

  List<Architect> get selectedList => _selectedList;

  set selectedList(List<Architect> value) {
    _selectedList = value;
  }
}