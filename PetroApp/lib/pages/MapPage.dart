import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:petroapp/models/residence.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../services/Residenceselectedservice.dart';
import 'package:geolocator/geolocator.dart';


class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late YandexMapController Geocontroller;
  Position? position;
  Future<bool> get locationPermissionNotGranted async => !(await Permission.location.request().isGranted);
  void _showMessage(BuildContext context, Text text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text));
  }
  final List<DrivingSessionResult> results = [];
  bool progress = true;
  Completer<YandexMapController> _completer = Completer();
 late final List<MapObject> mapObjects = [];
  final MapObjectId placemarkId = MapObjectId('Petehof');
  late Residence selectedResidence;

  @override
  Widget build(BuildContext context) {
    ResidenceSelectedService resSelection =
        Provider.of<ResidenceSelectedService>(context, listen: false);
    selectedResidence = resSelection.selectedResidence;
    void _onMapCreated(YandexMapController controller) async{
      _completer.complete(controller);
      Geocontroller = controller;
      var x = this.selectedResidence.Location.latitude;
      var y = this.selectedResidence.Location.longitude;
      final placemark = Placemark(
          mapId: (placemarkId),
          point: Point(latitude: x, longitude: y),
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image:
                  BitmapDescriptor.fromAssetImage('assets/icons/place.png'))));
      controller.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: Point(latitude: x, longitude: y))));

      setState(() {
        mapObjects.add(placemark);
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(selectedResidence.Name),
      ),
      body: Stack(
        children: <Widget>[
          Expanded(
            child: YandexMap(
              onMapCreated: _onMapCreated,
              mapObjects: mapObjects,
              onUserLocationAdded: (UserLocationView view) async {
                return view.copyWith(
                    pin: view.pin.copyWith(
                        icon: PlacemarkIcon.single(
                            PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('assets/icons/user.png'))
                        )
                    ),
                    arrow: view.arrow.copyWith(
                        icon: PlacemarkIcon.single(
                            PlacemarkIconStyle(image: BitmapDescriptor.fromAssetImage('assets/icons/user.png'))
                        )
                    ),
                    accuracyCircle: view.accuracyCircle.copyWith(
                        fillColor: Colors.green.withOpacity(0.5)
                    ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 600),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 10,),
                      ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black),onPressed: (){_requestRoutes();}, child: Text("Построить маршрут"),),
                      SizedBox(width: 10,),
                      Text("Маршрут: "),
                      Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _getList(),
                            )
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black),
                                    onPressed: () async {
                                      if (await locationPermissionNotGranted) {
                                        _showMessage(context, const Text('Location permission was NOT granted'));
                                        return;
                                      }
                                      _determinePosition();
                                      await Geocontroller.toggleUserLayer(visible: true);
                                    },
                                    child: Text("Показать Геолокацию"),
                                  ),
                                  ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.black),
                                    onPressed: () async {
                                      if (await locationPermissionNotGranted) {
                                        _showMessage(context, const Text(
                                            'Location permission was NOT granted'));
                                        return;
                                      }
                                      await Geocontroller.toggleUserLayer(visible: false);
                                    },
                                    child:Text("Скрыть Геолокацию"),
                                  )
                                ],
                              ),
                            ]
                        )
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> _requestRoutes() async {
    var x = this.selectedResidence.Location.latitude;
    var y = this.selectedResidence.Location.longitude;
    final placemark = Placemark(
        mapId: (placemarkId),
        point: Point(latitude: x, longitude: y),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image:
            BitmapDescriptor.fromAssetImage('assets/icons/place.png'))));
    var resultWithSession = YandexDriving.requestRoutes(
        points: [
          RequestPoint(point: placemark.point, requestPointType: RequestPointType.wayPoint),
          RequestPoint(point: Point(longitude: position!.longitude, latitude: position!.latitude), requestPointType: RequestPointType.wayPoint),
        ],
        drivingOptions: DrivingOptions(
            initialAzimuth: 0,
            routesCount: 1,
            avoidTolls: true
        )
    );
    Future<DrivingSessionResult> result = resultWithSession.result;
    DrivingSession session = resultWithSession.session;
    await session.close();
    await _handleResult(await result);
  }
  List<Widget> _getList() {
    final list = <Widget>[];

    if (results.isEmpty) {
      list.add((Text('Постройте маршрут')));
    }

    for (var r in results) {
      list.add(Container(height: 20));

      r.routes!.asMap().forEach((i, route) {
        list.add(Text('Route $i: ${route.metadata.weight.timeWithTraffic.text}'));
      });

      list.add(Container(height: 20));
    }

    return list;
  }
  Future<void> _handleResult(DrivingSessionResult result) async {
    setState(() { progress = false; });

    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }

    setState(() { results.add(result); });
    setState(() {
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(Polyline(
          mapId: MapObjectId('route_${i}_polyline'),
          coordinates: route.geometry,
          strokeColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
          strokeWidth: 3,
        ));
      });
    });
  }
}
