import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weather/dataset.dart';

class DetailPage extends StatefulWidget {
  final Weather tomorrowTemp;
  final List<Weather> sevenDay;
  DetailPage(this.tomorrowTemp, this.sevenDay);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [
          TomorrowWeather(widget.tomorrowTemp),
          SevenDays(widget.sevenDay)
        ],
      ),
    );
  }
}

class TomorrowWeather extends StatelessWidget {
  final Weather tomorrowTemp;
  TomorrowWeather(this.tomorrowTemp);
  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      color: Color(0xff00A1FF),
      glowColor: Color(0xff00A1FF),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    Text(
                      " Неделя",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Завтра",
                      style: TextStyle(
                          fontSize: 30,
                          height: 0.1,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      height: 105,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tomorrowTemp.feelLike.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 100,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(tomorrowTemp.image))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  final List<Weather> sevenDay;
  SevenDays(this.sevenDay);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: sevenDay.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 25),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              sevenDay[index].day,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.thermometer,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  sevenDay[index].feelLike.toString() +
                                      "\u00B0",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(
                                  CupertinoIcons.wind,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  sevenDay[index].wind.toString() + " Км/ч",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  CupertinoIcons.drop,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  sevenDay[index].humidity.toString() + " %",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  CupertinoIcons.speedometer,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  sevenDay[index].pressure.toString() + " мм",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Container(
                          height: 117,
                          margin: EdgeInsets.only(left: 60),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // SizedBox(width: 15),
                              Text(
                                sevenDay[index].name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Image(
                                image: AssetImage(sevenDay[index].image),
                                width: 50,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
