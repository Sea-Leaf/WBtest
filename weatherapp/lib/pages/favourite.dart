import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather/dataset.dart';

import '../homePage.dart';

// ignore: camel_case_types, must_be_immutable
class favouriteCity extends StatefulWidget {
  favouriteCity(this.cityList, this.setCityList, {this.setCity});
  List<String> cityList;
  final Function setCity;
  Function(Set<String> cities) setCityList;

  @override
  _favouriteCityState createState() => _favouriteCityState();
}

// ignore: camel_case_types
class _favouriteCityState extends State<favouriteCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Избранные",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cityList.length,
                itemBuilder: (context, index) => CityNameList(
                  city: widget.cityList.elementAt(index),
                  index: index,
                  setCity: widget.setCity,
                  remove: (index) {
                    setState(() {
                      widget.cityList.removeAt(index);
                      widget.setCityList(widget.cityList.toSet());
                    });
                  },
                  updateData: () {
                    setState(() {
                      widget.setCityList(widget.cityList.toSet());
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CityNameList extends StatefulWidget {
  final Function() updateData;
  final Function setCity;
  CityNameList(
      {this.city, this.remove, this.index, this.updateData, this.setCity});

  String city;
  Function remove;
  int index;

  @override
  _CityNameListState createState() => _CityNameListState();
}

class _CityNameListState extends State<CityNameList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // устанавливаем индекс выделенного элемента
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 25, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: widget.city.isEmpty ? false : true,
              child: GestureDetector(
                onTap: () async {
                  log(widget.city);
                  widget.setCity(await fetchCity(widget.city));
                  // city = widget.city;
                  widget.updateData();
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    widget.city,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.remove(widget.index);
                });
              },
              icon: const Icon(Icons.favorite_sharp,
                  color: Colors.deepOrangeAccent),
            )
          ],
        ),
      ),
    );
  }
}
