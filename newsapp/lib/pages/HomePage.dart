import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/news.dart';
import '../services/EditNewsService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    EditNewsService newsService = Provider.of<EditNewsService>(context, listen: true);
    return SafeArea(child: Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StreamBuilder<List<News>>(
            stream: newsService.GetNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var _news = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                      itemCount: _news!.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return Column(
                          children: [
                            Text("${_news[index].Id}"),
                            Text("${_news[index].Title}"),
                            Text("${_news[index].Body}"),
                          ],
                        );
                      }),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),

          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: (){
                Navigator.of(context)
                    .pushNamed('/EditNews');
              },
              icon: Icon(Icons.edit, size: 30),
              label: Text("Создать новость", style: TextStyle(fontSize: 20),)
          ),
        ],
      ),
    ));
  }
}
