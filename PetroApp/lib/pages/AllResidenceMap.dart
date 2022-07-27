import 'dart:async';
import 'package:flutter/material.dart';
import 'package:petroapp/services/FireBaseService.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../models/residence.dart';
import '../services/Residenceselectedservice.dart';
import '../widgets/residencecard.dart';

class AllResidenceMap extends StatefulWidget {
  const AllResidenceMap({Key? key}) : super(key: key);

  @override
  State<AllResidenceMap> createState() => _AllResidenceMapState();
}

class _AllResidenceMapState extends State<AllResidenceMap> {
  Completer<YandexMapController> _completer = Completer();
  late final List<MapObject> mapObjects = [];
  List<Placemark> AllRes = [];
  List<MapObjectId> MarksId = [];
  var index;
  @override
  Widget build(BuildContext context) {
    ResidenceSelectedService resSelection =
    Provider.of<ResidenceSelectedService>(context, listen: false);
    FireBaseServices resService =
    Provider.of<FireBaseServices>(context, listen: true);
    return StreamBuilder<List<Residence>>(
      stream: resService.getRes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var _residences = snapshot.data;
          void _onMapCreated(YandexMapController controller) {
            _completer.complete(controller);
            for (int i = 0; i < _residences!.length; i++) {
              MarksId.add(MapObjectId("${_residences[i].Name}"));
              AllRes.add(Placemark(mapId: (MarksId[i]),
                  point: Point(latitude: _residences[i].Location.latitude,
                      longitude: _residences[i].Location.longitude), icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image:
            BitmapDescriptor.fromAssetImage('assets/icons/place.png')
                  )
                  ),
                  consumeTapEvents: true,

                onTap: (Placemark placemark, Point point){
                 setState(() {
                   index = i;
                 });
                  }
              )
              );
              setState(() {
                mapObjects.add(AllRes[i]);
              });
            };
            controller.moveCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: Point(latitude:59.945494, longitude:30.313329))));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/ResidencePage');
                  }),
              title: Text("Карта резиденций"),
            ),
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  Expanded(
                    child: YandexMap(
                      onMapCreated: _onMapCreated,
                      mapObjects: mapObjects,
                    ),
                  ),
                  Builder(
                      builder: (BuildContext context){
                        if(index == null){
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blueGrey,
                              child: Text("Выберите маркер на карте", style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'RougeScript',
                                color: Colors.white,
                              ), textAlign: TextAlign.center,
                              )
                          );
                        }
                        return ResidenceCard(
                            residence: _residences![index],
                            onCardClick: () {
                              resSelection.selectedResidence =
                              _residences[index];
                              Navigator.of(context)
                                  .pushNamed('/SelectedResidencePage');
                            });
                      }
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

