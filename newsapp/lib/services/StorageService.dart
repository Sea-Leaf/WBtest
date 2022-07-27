import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import'package:firebase_core/firebase_core.dart' as firebase_core;
class StorageService{
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> UploadFile(
      String filePath,
      String fileName,
      String newsID
      ) async{
    File file = File(filePath);

    try{
      await storage.ref('Images/${newsID}/${fileName}').putFile(file);
    } on firebase_core.FirebaseException catch(e){
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async{
    firebase_storage.ListResult result = await storage.ref('Images').listAll();
    result.items.forEach((firebase_storage.Reference ref) {print('found file: ${ref}');});
    return result;
  }

  Future<String> downloadURL(String imgName, String newsID) async {
    String downloadURL = await storage.ref('Images/${newsID}/${imgName}').getDownloadURL();

    return downloadURL;
  }

  deleteFile(String newsID){
    storage.ref('Images/${newsID}').listAll().then((value){
      value.items.forEach((element) {
        storage.ref(element.fullPath).delete();
      });
    });
  }
}