import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/services/StorageService.dart';


class ImagePick{
 File? image;
  Future pickImage(ImageSource source, String newsID) async{
   try {
     final image = await ImagePicker().pickImage(source: source);
     if (image == null) return;

     final path = image.path;
     final fileName = image.name;
     StorageService().deleteFile(newsID);
     StorageService().UploadFile(path, fileName, newsID);
     return path;
   } on Exception catch (e) {
     print("Ошибка получения изображения:  $e");
   }
 }
}