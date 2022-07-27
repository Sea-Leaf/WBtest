import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapp/models/Comments.dart';
import 'package:newsapp/models/users.dart';


class News{
  String Id;
  String imgPath;
  String Title;
  String Body;
  List<Comt>? Comments;
  List<Users>? Favorite;
  Timestamp Date;

  News({
    required this.Id,
    required this.imgPath,
    required this.Title,
    required this.Body,
    this.Comments,
    this.Favorite,
    required this.Date,
  });

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'imgPath': imgPath,
      'Title': Title,
      'Body': Body,
      'Comments': Comments?.map((e) => e.toMap()).toList(),
      'Favorite': Favorite?.map((e) => e.toMap()).toList(),
      'Date': Date,
    };
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      Id: map['Id'] as String,
      imgPath: map['imgPath'] as String,
      Title: map['Title'] as String,
      Body: map['Body'] as String,
      Comments: (map['Comments'] as List).map((e) => Comt.fromMap(e)).toList(),
      Favorite: (map['Favorite'] as List).map((e) => Users.fromMap(e)).toList(),
      Date: map['Date'] as Timestamp,
    );
  }
}