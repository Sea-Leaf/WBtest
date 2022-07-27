import 'package:cloud_firestore/cloud_firestore.dart';

class Objct {
  String Id;
  String Name;
  String Type;
  String Info;
  Timestamp CreateDate;

  Objct.add(this.Id, this.Name, this.Type, this.Info, this.CreateDate);

  Objct({
    required this.Id,
    required this.Name,
    required this.Type,
    required this.Info,
    required this.CreateDate,
  });

  Objct.fromJson(Map<String, Object?> json)
      : this(
            Id: json['Id'] as String,
            Name: json['Name'] as String,
            Type: json['Type'] as String,
            Info: json['Info'] as String,
            CreateDate: json['CreateDate'] as Timestamp);

  Map<String, Object?> toJson() {
    return {
      'Id': Id,
      'Name': Name,
      'Type': Type,
      'Info': Info,
      'CreateDate': CreateDate
    };
  }
}
