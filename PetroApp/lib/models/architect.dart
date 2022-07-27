import 'package:cloud_firestore/cloud_firestore.dart';

class Architect {
  String Id;
  String Name;
  String Info;
  Timestamp Birth;

  Architect(
      {required this.Id,
      required this.Name,
      required this.Info,
      required this.Birth});

  Architect.add(this.Id, this.Name, this.Info, this.Birth);

  Architect.fromJson(Map<String, Object?> json)
      : this(
            Id: json['Id'] as String,
            Name: json['Name'] as String,
            Info: json['Info'] as String,
            Birth: json['Birth'] as Timestamp);

  Map<String, Object?> toJson() {
    return {'Id': Id, 'Name': Name, 'Info': Info, 'Birth': Birth};
  }
}




