import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/residence.dart';

class FireBaseServices {
  FirebaseFirestore? _instance;

  Stream<List<Residence>> getStyle(String? Style) {
    _instance = FirebaseFirestore.instance;
    CollectionReference residences = _instance!.collection('Residences');
    return residences.where("Style", isEqualTo: Style).snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) =>
        Residence.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<List<Residence>> getPos(String? Style, String? values) {
    _instance = FirebaseFirestore.instance;
    CollectionReference residences = _instance!.collection('Residences');
    return residences.snapshots().map((QuerySnapshot data) => data.docs.where((element) => element["${values}"][0]["Name"] == Style)
        .map((DocumentSnapshot doc) =>
        Residence.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }
  Stream<List<Residence>> getPos1(String? Style, String? values) {
    _instance = FirebaseFirestore.instance;
    CollectionReference residences = _instance!.collection('Residences');
    return residences.snapshots().map((QuerySnapshot data) => data.docs.where((element) => element["${values}"][0]["Type"] == Style)
        .map((DocumentSnapshot doc) =>
        Residence.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Stream<List<Residence>> getRes() {
    _instance = FirebaseFirestore.instance;
    CollectionReference residences = _instance!.collection('Residences');
    return residences.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) =>
            Residence.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<void> AddResidence(Residence residence) async {
    final resRef = FirebaseFirestore.instance
        .collection('Residences')
        .withConverter<Residence>(
          fromFirestore: (snapshot, _) => Residence.fromJson(snapshot.data()!),
          toFirestore: (residence, _) => residence.toJson(),
        );
    await resRef
        .doc(residence.Id)
        .set(residence)
        .then((value) => print("Residence Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> DeleteResidence(String ID) async {
    final resRef = FirebaseFirestore.instance
        .collection('Residences')
        .withConverter<Residence>(
          fromFirestore: (snapshot, _) => Residence.fromJson(snapshot.data()!),
          toFirestore: (residence, _) => residence.toJson(),
        );
    await resRef
        .doc(ID)
        .delete()
        .then((value) => print("Residence Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> UpdateResidence(String ID,String dataname, String data){
    final resRef = FirebaseFirestore.instance
        .collection('Residences');
    return resRef
    .doc('${ID}')
    .set({
      '${dataname}' : '${data}'
    }
    );
  }

   Future<DocumentSnapshot>readRes(String? Id) async{
    return await FirebaseFirestore.instance.collection('Residences')
        .doc(Id)
        .get();
  }
}
