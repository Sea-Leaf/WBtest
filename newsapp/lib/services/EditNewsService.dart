import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news.dart';

class EditNewsService {
   FirebaseFirestore? _instance;

   Future<void> EditNews(News news) async {
     final resRef = FirebaseFirestore.instance
         .collection('News')
         .withConverter<News>(
       fromFirestore: (snapshot, _) => News.fromMap(snapshot.data()!),
       toFirestore: (news, _) => news.toMap(),
     );
     await resRef
         .doc(news.Id)
         .set(news)
         .then((value) => print("News Added"))
         .catchError((error) => print("Failed to add news: $error"));
   }

   Stream<List<News>> GetNews() {
     _instance = FirebaseFirestore.instance;
     CollectionReference news = _instance!.collection('News');
     return news.snapshots().map((QuerySnapshot data) => data.docs
         .map((DocumentSnapshot doc) =>
         News.fromMap(doc.data() as Map<String, dynamic>))
         .toList());
   }

   Future<void> DeleteNews(String ID) async {
     final resRef = FirebaseFirestore.instance
         .collection('News')
         .withConverter<News>(
       fromFirestore: (snapshot, _) => News.fromMap(snapshot.data()!),
       toFirestore: (news, _) => news.toMap(),
     );
     await resRef
         .doc(ID)
         .delete()
         .then((value) => print("News Deleted"))
         .catchError((error) => print("Failed to delete news: $error"));
   }

}