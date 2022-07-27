import 'package:flutter/material.dart';
import 'package:petroapp/models/residence.dart';
import 'package:provider/provider.dart';

import '../services/Residenceselectedservice.dart';

class ResidenceArchitect extends StatelessWidget {
  late Residence selectedResidence;

  @override
  Widget build(BuildContext context) {
    ResidenceSelectedService resSelection =
        Provider.of<ResidenceSelectedService>(context, listen: false);
    selectedResidence = resSelection.selectedResidence;
    return Scaffold(
      appBar: AppBar(
        title: ClipOval(
          child: Container(
            child: Image.asset('assets/images/peter.png',
                fit: BoxFit.cover, scale: 10, alignment: Alignment.center),
            padding: EdgeInsets.all(9),
            margin: EdgeInsets.only(left: 97),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Text(
                this.selectedResidence.Name,
                style: TextStyle(
                    color: Colors.black, fontSize: 25, fontFamily: 'Buyan'),
              ),
            ),
            SizedBox(height: 40),
            Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(this.selectedResidence.Arch.length,
                        (index) {
                      return GestureDetector(
                          onTap: () {
                            resSelection.selectedArchitect =
                                this.selectedResidence.Arch[index];
                            Navigator.of(context).pushNamed('/ArchPage');
                          },
                          child: Container(
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Container(
                                    color: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    child: Icon(Icons.accessibility, color: Colors.white,)
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: 100,
                                  child: Text(
                                    this.selectedResidence.Arch[index].Name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Buyan'),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    })))
          ],
        ),
      ),
    );
  }
}
