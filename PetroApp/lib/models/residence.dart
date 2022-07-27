import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petroapp/models/architect.dart';
import 'package:petroapp/models/objects.dart';

class Residence {
  String Id;
  Timestamp BuildDate;
  String Style;
  String Name;
  String Info;
  String imgPath;
  List<Architect> Arch;
  List<Objct> Obj;
  GeoPoint Location;

  Residence({
    required this.Id,
    required this.BuildDate,
    required this.Style,
    required this.Name,
    required this.Info,
    required this.imgPath,
    required this.Arch,
    required this.Obj,
    required this.Location,
  });

  factory Residence.fromJson(Map<String, dynamic> json) {
    return Residence(
        Id: json['Id'] as String,
        BuildDate: json['BuildDate'] as Timestamp,
        Style: json['Style'] as String,
        Name: json['Name'] as String,
        Info: json['Info'] as String,
        imgPath: json['imgPath'] as String,
        Arch: (json['Arch'] as List).map((w) => Architect.fromJson(w)).toList(),
        Obj: (json['Obj'] as List).map((w) => Objct.fromJson(w)).toList(),
        Location: json['Location'] as GeoPoint);
  }

  Map<String, Object?> toJson() {
    return {
      'Id': Id,
      'BuildDate': BuildDate,
      'Style': Style,
      'Name': Name,
      'Info': Info,
      'imgPath': imgPath,
      'Arch': Arch.map((w) => w.toJson()).toList(),
      'Obj': Obj.map((w) => w.toJson()).toList(),
      'Location': Location
    };
  }
}



