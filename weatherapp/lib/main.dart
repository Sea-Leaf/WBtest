import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/homePage.dart';
import 'package:weather/pages/settings.dart';
import 'package:weather/pages/favourite.dart';
import 'package:weather/pages/about.dart';
import 'package:weather/provider/theme_provider.dart';

import 'dataset.dart';
import 'pages/pressure.dart';
import 'pages/temp.dart';
import 'pages/wind.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Set<String> cityList = {};
  var city = CityModel(name: 'Москва', lat: '55.7617', lon: '37.6067');

  setCity(CityModel cityNew) {
    setState(() {
      city = cityNew;
    });
  }

  setCityList(Set<String> cities) {
    setState(() {
      cityList = cities;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: myThemes.lightTheme,
          darkTheme: myThemes.darkTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => HomePage(
                  cityList,
                  city: city,
                  callback: setCity,
                ),
            '/settings': (context) => settingsApp(),
            '/favourite': (context) => favouriteCity(
                  cityList.toList(),
                  setCityList,
                  setCity: setCity,
                ),
            '/about': (context) => aboutApp(),
            '/temp': (context) => temp(),
            '/wind': (context) => wind(),
            '/pressure': (context) => pressure(),
          },
        );
      },
    );
  }
}
