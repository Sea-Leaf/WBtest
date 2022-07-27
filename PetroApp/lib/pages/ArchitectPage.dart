import 'package:flutter/material.dart';
import 'package:petroapp/models/architect.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/Residenceselectedservice.dart';

class ArchPage extends StatelessWidget {
  late Architect selectedArch;

  @override
  Widget build(BuildContext context) {
    ResidenceSelectedService resSelection =
        Provider.of<ResidenceSelectedService>(context, listen: false);
    selectedArch = resSelection.selectedArchitect;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(selectedArch.Name),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Center(
                child: ClipOval(
                  child: Container(
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Icon(Icons.accessibility_new_sharp, color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  child: Text(
                    this.selectedArch.Name,
                    style: TextStyle(
                        color: Colors.black, fontSize: 30, fontFamily: 'Buyan'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1.5, color: Colors.black),
                  ),
                ),
                child: Row(
                  children: [
                    Text('Дата рождения: '),
                    Text(
                        DateFormat.y().format(this.selectedArch.Birth.toDate()))
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.5, color: Colors.black),
                  ),
                ),
                child: Text('Описание:', style: TextStyle(fontSize: 16)),
              ),
              Container(
                height: 500,
                padding: EdgeInsets.only(top: 10),
                child:  ListView(
              children: [Text(this.selectedArch.Info),]
              )
              ) ,
            ],
          ),
        ));
  }
}
