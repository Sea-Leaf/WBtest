import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:newsapp/models/Comments.dart';
import 'package:newsapp/models/users.dart';
import 'package:newsapp/services/EditNewsService.dart';
import 'package:newsapp/services/ImagePickService.dart';
import 'package:newsapp/widgets/ImageSource.dart';
import 'package:provider/provider.dart';

import '../models/news.dart';

class EditNewsPage extends StatefulWidget {
  const EditNewsPage({Key? key}) : super(key: key);

  @override
  State<EditNewsPage> createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final NewsTitleController = TextEditingController();
  final NewsBodyController = TextEditingController();
  final NewsImageController = TextEditingController();
  final List<Comt> comment = [];
  final List<Users> favorite = [];

  @override
  void dispose(){
    NewsTitleController.dispose();
    NewsBodyController.dispose();
    NewsImageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    File? images;
    EditNewsService newsService = Provider.of<EditNewsService>(context, listen: true);
    ImagePick imagePick = Provider.of<ImagePick>(context, listen: true);

    return SafeArea(child: Scaffold(
      appBar: AppBar(),
      body: FormBuilder(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: 5),
            FormBuilderTextField(
              name: "Title",
              controller: NewsTitleController,
              decoration: const InputDecoration(labelText: "Заголовок блока",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: Colors.black)
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 5),
            FormBuilderTextField(
              name: "Body",
              controller: NewsBodyController,
              decoration: const InputDecoration(labelText: "Тескт блока",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: Colors.black)
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 5),
            FormBuilderTextField(
              name: "Image",
              controller: NewsImageController,
              enabled: false,
              readOnly: true,
              decoration: const InputDecoration(labelText: "Путь до обложки",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 4, color: Colors.black)
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 5),
          StreamBuilder<List<News>>(
            stream: newsService.GetNews(),
            builder: (context, snapshot) {
            if (snapshot.hasData) {
              var _news = snapshot.data!;
              return Column(
                children: [
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                      onPressed: () async{
                        final source = await ShowImageSource().showImageSource(context);
                        if (source == null) return;
                        imagePick.pickImage(source, (_news.length + 1).toString());
                      },
                      icon: Icon(Icons.image, size: 30),
                      label: Text("Добавить изображение", style: TextStyle(fontSize: 20),)
                  ),
                  SizedBox(height: 5),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                      onPressed: (){
                        News news = News(
                            Id: (_news.length + 1).toString(),
                            imgPath: NewsImageController.text,
                            Title: NewsTitleController.text,
                            Body: NewsBodyController.text,
                            Comments: comment,
                            Favorite: favorite,
                            Date: Timestamp.fromDate(DateTime.now())
                        );
                        EditNewsService().EditNews(news);
                        Navigator.of(context).pushReplacementNamed('/HomePage');
                      },
                      icon: Icon(Icons.save_alt, size: 30),
                      label: Text("Добавить новость", style: TextStyle(fontSize: 20),)
                  ),
                ],
              );}
            else {return Container(); }
            },
          ),
          ],
        ),
      ),
    ));
  }
}
