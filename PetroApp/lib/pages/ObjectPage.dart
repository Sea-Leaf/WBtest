import 'package:flutter/material.dart';
import 'package:petroapp/models/objects.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/Residenceselectedservice.dart';

class ObjectPage extends StatelessWidget {
  late Objct selectedObj;

  @override
  Widget build(BuildContext context) {
    ResidenceSelectedService resSelection =
        Provider.of<ResidenceSelectedService>(context, listen: false);
    selectedObj = resSelection.selectedObject;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(selectedObj.Name),
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
                    child: Icon(Icons.account_balance, color: Colors.white,),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  child: Text(
                    this.selectedObj.Name,
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
                    Text('Тип: '),
                    Text(this.selectedObj.Type),
                    SizedBox(width: 40),
                    Text('Дата создания: '),
                    Text(DateFormat.y()
                        .format(this.selectedObj.CreateDate.toDate()))
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
                child: ListView(
    children: [ Text(this.selectedObj.Info),],
    )
              ),
            ],
          ),
        ));
  }
}
