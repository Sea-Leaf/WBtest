import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:provider/provider.dart';
import 'package:weather/dataset.dart';
import 'package:weather/detailPage.dart';
import 'package:weather/extraWeather.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:weather/provider/theme_provider.dart';

Weather currentTemp;
Weather tomorrowTemp;
List<Weather> todayWeather;
List<Weather> sevenDay;
// String lat = "55.7617";
// String lon = "37.6067";
// String city = "Москва";

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage(this.cityList, {this.city, this.callback});
  Set<String> cityList;
  CityModel city;
  final Function callback;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<dynamic>> getData(CityModel city) async {
    return fetchData(city.lat, city.lon, city.name);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Neumorphic(
          style: NeumorphicStyle(
            depth: 0,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(0),
            ),
          ),
          child: Drawer(
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.only(left: 30),
                children: [
                  const Text(
                    "Weather App",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.settings,
                              size: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Настройки",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/favourite');
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.favorite_border_outlined,
                              size: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Избранные",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/about');
                        },
                        child: Row(
                          children: const [
                            Icon(
                              Icons.account_circle_outlined,
                              size: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15.0),
                              child: Text(
                                "О приложении",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: getData(widget.city),
          builder: (context, snapshot) {
            // log(snapshot.toString(), name: 'future');
            if (snapshot.hasData) {
              currentTemp = snapshot.data[0];
              todayWeather = snapshot.data[1];
              tomorrowTemp = snapshot.data[2];
              sevenDay = snapshot.data[3];
              if (!widget.cityList.contains(widget.city.name))
                Future.delayed(Duration.zero, () {
                  setState(() {
                    widget.cityList.add(widget.city.name);
                  });
                });
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(themeProvider.isDarkMode
                        ? 'assets/images/dark_bg.png'
                        : 'assets/images/light_bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: CurrentWeather(
                  widget.callback,
                  city: widget.city,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}

class CurrentWeather extends StatefulWidget {
  final Function callback;
  CurrentWeather(this.callback, {@required this.city});
  final CityModel city;

  @override
  _CurrentWeatherState createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  bool searchBar = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // var _dateNow = DateFormat.yMMMMd('ru').format(DateTime.now());
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (searchBar)
                setState(() {
                  searchBar = false;
                });
            },
            child: Container(
              // color: Colors.white,
              // height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: searchBar
                        ? TextField(
                            focusNode: focusNode,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor: Theme.of(context)
                                    .drawerTheme
                                    .backgroundColor,
                                filled: true,
                                hintText: "Введите название города"),
                            textInputAction: TextInputAction.search,
                            onSubmitted: (value) async {
                              CityModel temp = await fetchCity(value);
                              log(temp.toString());
                              if (temp == null) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Color(0xff030317),
                                        title: Text("Город не найден"),
                                        content:
                                            Text("Проверьте название города"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Ok"))
                                        ],
                                      );
                                    });
                                searchBar = false;
                                return;
                              }
                              log(temp.toString());
                              setState(() {
                                // city = temp.name;
                                // lat = temp.lat;
                                // lon = temp.lon;
                                widget.callback(temp);
                              });
                              searchBar = false;
                            },
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Icon(
                                  CupertinoIcons.square_grid_2x2,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      searchBar = true;
                                      setState(() {});
                                      focusNode.requestFocus();
                                    },
                                    child: Text(
                                      " " + widget.city.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/favourite');
                                  },
                                  child: Icon(Icons.more_vert,
                                      color: Colors.white))
                            ],
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   margin: EdgeInsets.only(top: 10),
                  //   padding: EdgeInsets.all(10),
                  //   decoration: BoxDecoration(
                  //       border: Border.all(width: 0.2, color: Colors.white),
                  //       borderRadius: BorderRadius.circular(30)),
                  //   child: Text(
                  //     updating ? "Обновление" : "Обновлено",
                  //     style: TextStyle(fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  Container(
                    height: 100,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  currentTemp.current.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      height: 1,
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  currentTemp.day,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          LimitedBox(
            maxHeight: 500,
            child: ExpandableBottomSheet(
              persistentContentHeight: 148,
              background: Container(),
              expandableContent: Container(
                height: 400,
                width: double.infinity,
                color: Theme.of(context).drawerTheme.backgroundColor,
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 3),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherWidget(todayWeather[0]),
                              WeatherWidget(todayWeather[1]),
                              WeatherWidget(todayWeather[2]),
                              WeatherWidget(todayWeather[3])
                            ]),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ExtraWeather(currentTemp),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 85),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return DetailPage(tomorrowTemp, sevenDay);
                                },
                              ),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Прогноз на неделю",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[400]),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.grey[300],
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              persistentHeader: Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Theme.of(context).drawerTheme.backgroundColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
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

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  WeatherWidget(this.weather);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 80,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Theme.of(context).drawerTheme.backgroundColor,
          border: Border.all(width: 0.6, color: Colors.grey[300]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 2,
            )
          ]),
      child: Column(
        children: [
          Text(
            weather.current.toString() + "\u00B0",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Image(
            image: AssetImage(weather.image),
            width: 50,
            height: 50,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            weather.time,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
