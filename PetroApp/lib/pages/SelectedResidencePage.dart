import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:petroapp/models/residence.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../services/Residenceselectedservice.dart';
import '../services/StorageService.dart';
import '../widgets/residencePageBottomBar.dart';

class SelectedResidencePage extends StatelessWidget {
  late Residence selectedResidence;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
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
        body: Stack(
          children: [
            Container(
              child: SlidingUpPanel(
                  margin: EdgeInsets.only(bottom: 100),
                  minHeight: 30,
                  header: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedResidence.Name,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Buyan',
                              fontSize: 30),
                        )
                      ],
                    ),
                  ),
                  panel: ListView(
                      padding: EdgeInsets.only(top: 37),
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.5, color: Colors.black),
                                ),
                              ),
                              child: Text('Архитекторы:',
                                  style: TextStyle(fontSize: 16)),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  ClipOval(
                                    child: Material(
                                      color: Colors.black,
                                      child: IconButton(
                                        icon: Icon(
                                            CommunityMaterialIcons.account, color: Colors.white,),
                                        onPressed: () {
                                          resSelection.selectedResidence =
                                              this.selectedResidence;
                                          Navigator.of(context)
                                              .pushNamed('/ResidenceArchList');
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Column(
                                        children: List.generate(
                                            this.selectedResidence.Arch.length,
                                            (index) {
                                      return Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                            "${selectedResidence.Arch[index].Name}",
                                            style: TextStyle(fontSize: 15)),
                                      );
                                    })),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.5, color: Colors.black),
                                ),
                              ),
                              child: Text('Описание:',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(selectedResidence.Info),
                        ),
                      ],
                    ),
                  collapsed: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    child: Center(
                      child: Text(
                        selectedResidence.Name,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Buyan',
                            fontSize: 30),
                      ),
                    ),
                  ),
                  body: Container(
                    height: 10,
                    child: FutureBuilder(
                      future: storage.downloadURL(selectedResidence.imgPath, selectedResidence.Id),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
                        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
                          return Container(
                            child: Image.network(snapshot.data!, fit: BoxFit.cover),
                          );
                        }
                        return Container();
                      },
                    ),
                    /*Image.asset(
                      selectedResidence.imgPath,
                      fit: BoxFit.cover,
                    ),*/
                  ),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
            ),
            Positioned(bottom: 0, left: 0, right: 0, child: ResidenceBar()),
          ],
        ));
  }
}
