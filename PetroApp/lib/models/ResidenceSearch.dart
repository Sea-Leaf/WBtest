import 'package:cloud_firestore/cloud_firestore.dart';

class ResidenceS{
  String? Id;
  Timestamp? BuildDate;
  String? Name;
  String? Info;
  String? imgPath;
  GeoPoint? Location;

  ResidenceS({
    this.Id,
    this.BuildDate,
    this.Name,
    this.Info,
    this.imgPath,
    this.Location,
  });

  factory ResidenceS.fromJson(Map<String, dynamic> json) {
    return ResidenceS(
        Id: json['Id'] as String,
        BuildDate: json['BuildDate'] as Timestamp,
        Name: json['Name'] as String,
        Info: json['Info'] as String,
        imgPath: json['imgPath'] as String,
        Location: json['Location'] as GeoPoint);
  }

  Map<String, Object?> toJson() {
    return {
      'Id': Id,
      'BuildDate': BuildDate,
      'Name': Name,
      'Info': Info,
      'imgPath': imgPath,
      'Location': Location
    };
  }

  List<ResidenceS> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return ResidenceS(
        Id: dataMap['Id'],
        BuildDate: dataMap['BuildDate'],
        Name: dataMap['Name'],
        Info: dataMap['Info'],
        imgPath: dataMap['ImgPath'],
        Location: dataMap['Location'],);
    }).toList();}
}
