import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:petroapp/models/residence.dart';
import 'package:petroapp/services/Residenceselectedservice.dart';
import 'package:provider/provider.dart';

class ResidenceBar extends StatelessWidget {
  late Residence selectedResidence;

  @override
  Widget build(BuildContext context) {
    ResidenceSelectedService resSelection =
        Provider.of<ResidenceSelectedService>(context, listen: false);
    selectedResidence = resSelection.selectedResidence;
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(0.2),
            offset: Offset.zero)
      ]),
      height: 100,
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Material(
            child: InkWell(
              onTap: () {
                resSelection.selectedResidence = this.selectedResidence;
                Navigator.of(context).pushNamed('/MapPage');
              },
              child: Container(
                height: 30,
                margin: EdgeInsets.only(top: 10),
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CommunityMaterialIcons.map_marker, color: Colors.white,),
                    Text(
                      'Показать на карте',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
          ),
          Material(
            child: InkWell(
              onTap: () {
                resSelection.selectedResidence = this.selectedResidence;
                Navigator.of(context).pushNamed('/ResidenceObjectList');
              },
              child: Container(
                height: 30,
                margin: EdgeInsets.only(top: 10),
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CommunityMaterialIcons.fountain, color: Colors.white,),
                    Text(
                      'Архитектурные объекты',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
