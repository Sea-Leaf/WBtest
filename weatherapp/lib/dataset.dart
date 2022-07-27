import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class Weather {
  final int feelLike;
  final int current;
  final String name;
  final String day;
  final int wind;
  final int humidity;
  final int pressure;
  final String image;
  final String time;
  final String location;

  Weather(
      {this.feelLike,
      this.name,
      this.day,
      this.wind,
      this.humidity,
      this.pressure,
      this.image,
      this.current,
      this.time,
      this.location});

  @override
  String toString() {
    return 'Weather{feelLike: $feelLike, current: $current, name: $name, day: $day, wind: $wind, humidity: $humidity, pressure: $pressure, image: $image, time: $time, location: $location}';
  }
}

String appId = "4b20cec8749a546aa87b35ebe47baec0";
//https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$appId
//https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json

Future<List> fetchData(String lat, String lon, String city) async {
  var url =
      "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$appId";
  var response = await http.get(Uri.parse(url));
  DateTime date = DateTime.now();
  if (response.statusCode == 200) {
    var res = json.decode(response.body);
    //current
    var current = res["current"];
    var month = DateFormat("MMMM").format(date);
    var year = DateFormat("y").format(date);
    var day = DateFormat("d").format(date);
    switch (month) {
      case "January":
        month = "Январь";
        break;
      case "February":
        month = "Февраль";
        break;
      case "March":
        month = "Март";
        break;
      case "April":
        month = "Апрель";
        break;
      case "May":
        month = "Май";
        break;
      case "June":
        month = "Июнь";
        break;
      case "July":
        month = "Июль";
        break;
      case "August":
        month = "Август";
        break;
      case "September":
        month = "Сентябрь";
        break;
      case "October":
        month = "Октябрь";
        break;
      case "November":
        month = "Ноябрь";
        break;
      case "December":
        month = "Декабрь";
        break;
      default:
        month = month;
    }

    Weather currentTemp = Weather(
        current: current["temp"]?.round() ?? 0,
        name: current["weather"][0]["main"].toString(),
        day: month + " " + day + " " + year,
        feelLike: current["feels_like"]?.round() ?? 0,
        wind: current["wind_speed"]?.round() ?? 0,
        humidity: current["humidity"]?.round() ?? 0,
        pressure: current["pressure"]?.round() ?? 0,
        location: city,
        image: findIcon(current["weather"][0]["main"].toString(), true));

    //today
    List<Weather> todayWeather = [];
    int hour = int.parse(DateFormat("H").format(date));
    if (hour + 1 == 24) {
      hour = 0;
    }
    for (var i = 0; i < 4; i++) {
      var temp = res["hourly"];
      var hourly = Weather(
          current: temp[i]["temp"]?.round() ?? 0,
          image: findIcon(temp[i]["weather"][0]["main"].toString(), false),
          time: Duration(hours: hour + i + 1).toString().split(":")[0] + ":00");

      todayWeather.add(hourly);
    }

    //Tomorrow
    var daily = res["daily"][0];
    Weather tomorrowTemp = Weather(
        feelLike: daily["feels_like"]["day"]?.round() ?? 0,
        image: findIcon(daily["weather"][0]["main"].toString(), true),
        name: daily["weather"][0]["main"].toString(),
        wind: daily["wind_speed"]?.round() ?? 0,
        pressure: daily["pressure"]?.round() ?? 0);

    //Seven Day
    List<Weather> sevenDay = [];
    for (var i = 1; i < 8; i++) {
      String day = DateFormat('EEEE')
          .format(DateTime(date.year, date.month, date.day + i + 1))
          .substring(0, 3);

      switch (day) {
        case "Mon":
          day = "Пн";
          break;
        case "Tue":
          day = "Вт";
          break;
        case "Wed":
          day = "Ср";
          break;
        case "Thu":
          day = "Чт";
          break;
        case "Fri":
          day = "Пт";
          break;
        case "Sat":
          day = "Сб";
          break;
        case "Sun":
          day = "Вс";
          break;
        default:
          day = day;
      }
      var temp = res["daily"][i];
      var hourly = Weather(
          feelLike: temp["temp"]["day"]?.round() ?? 0,
          wind: temp["wind_speed"]?.round() ?? 0,
          humidity: temp["humidity"] ?? 0,
          pressure: temp["pressure"]?.round() ?? 0,
          image: findIcon(temp["weather"][0]["main"].toString(), false),
          name: temp["weather"][0]["main"].toString(),
          day: day);
      sevenDay.add(hourly);
    }
    return [currentTemp, todayWeather, tomorrowTemp, sevenDay];
  }
  return [null, null, null, null];
}

// ignore: missing_return
// String findName(String condition) {
//   switch (condition) {
//     case "Clouds":
//       condition = "Облачно";
//       break;
//     case "Rain":
//       condition = "Дождь";
//       break;
//     case "Drizzle":
//       condition = "Морось";
//       break;
//     case "Thunderstorm":
//       condition = "Гроза";
//       break;
//     case "Snow":
//       condition = "Снег";
//       break;
//     default:
//       condition = "Облачно";
//   }
// }

String findIcon(String name, bool type) {
  if (type) {
    switch (name) {
      case "Clouds":
        return "assets/sunny.png";
        break;
      case "Rain":
        return "assets/rainy.png";
        break;
      case "Drizzle":
        return "assets/rainy.png";
        break;
      case "Thunderstorm":
        return "assets/thunder.png";
        break;
      case "Snow":
        return "assets/snow.png";
        break;
      default:
        return "assets/sunny.png";
    }
  } else {
    switch (name) {
      case "Clouds":
        return "assets/sunny_2d.png";
        break;
      case "Rain":
        return "assets/rainy_2d.png";
        break;
      case "Drizzle":
        return "assets/rainy_2d.png";
        break;
      case "Thunderstorm":
        return "assets/thunder_2d.png";
        break;
      case "Snow":
        return "assets/snow_2d.png";
        break;
      default:
        return "assets/sunny_2d.png";
    }
  }
}

class CityModel {
  final String name;
  final String lat;
  final String lon;
  CityModel({this.name, this.lat, this.lon});

  @override
  String toString() {
    return 'CityModel{name: $name, lat: $lat, lon: $lon}';
  }
}

var cityJSON;

Future<CityModel> fetchCity(String cityName) async {
  String link =
      "http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=5&units=metric&appid=$appId";
  var response = await http.get(Uri.parse(link));
  if (response.statusCode == 200) {
    cityJSON = json.decode(response.body);
  }

  for (var i = 0; i < cityJSON.length; i++) {
    if (cityJSON[i]["local_names"]["ru"].toString().toLowerCase() ==
        cityName.toLowerCase()) {
      return CityModel(
          name: cityJSON[i]["local_names"]["ru"].toString(),
          lat: cityJSON[i]["lat"].toString(),
          lon: cityJSON[i]["lon"].toString());
    }
  }
  return null;
}





// Future<CityModel> fetchCity(String cityName) async {
//   if (cityJSON == null) {
//     String link =
//         "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/cities.json";
//     var response = await http.get(Uri.parse(link));
//     if (response.statusCode == 200) {
//       cityJSON = json.decode(response.body);
//     }
//   }
//   for (var i = 0; i < cityJSON.length; i++) {
    // if (cityJSON[i]["name"].toString().toLowerCase() ==
    //     cityName.toLowerCase()) {
//       return CityModel(
//           name: cityJSON[i]["name"].toString(),
//           lat: cityJSON[i]["latitude"].toString(),
//           lon: cityJSON[i]["longitude"].toString());
//     }
//   }
//   return null;
// }