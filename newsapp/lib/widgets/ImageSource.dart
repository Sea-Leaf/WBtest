import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowImageSource {

  Future<ImageSource?> showImageSource (BuildContext context) async{
    return showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          height: 115,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Камера'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.image_search),
                title: Text('Галлерея'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        )
    );
  }
}
