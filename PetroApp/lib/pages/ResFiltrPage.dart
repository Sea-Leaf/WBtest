import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:petroapp/models/residence.dart';
import 'package:petroapp/services/FireBaseService.dart';
import 'package:petroapp/services/LoginService.dart';
import 'package:petroapp/services/Residenceselectedservice.dart';
import 'package:petroapp/widgets/residencebottombar.dart';
import 'package:petroapp/widgets/residencecard.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FiltrationPage extends StatefulWidget {
  @override
  State<FiltrationPage> createState() => _FiltrationPageState();
}

class _FiltrationPageState extends State<FiltrationPage> {
  List<Residence> residences = [];
  bool expand = false;
  final List<String> Style = [
      'Барокко',
      'Классицизм',
      'Сельский стиль',
  ];
  final List<String> Arch = [
    'Леблон, Жан-Батист',
    'Георг Иоганн Маттарнови',
    'Доменико Андреа Трезини',
    'Микетти, Николо',
    'Растрелли, Бартоломео Франческо',
  ];
  final List<String> Objct = [
    'Фонтан',
    'Статуя',
    'Фасад',
    'Интерьер',
  ];
  String? value1;
  String? value2;
  String? value3;
  var filters = 0;
  var array;
  late int i;
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    ResidenceSelectedService resSelection =
    Provider.of<ResidenceSelectedService>(context, listen: false);
    FireBaseServices resService =
    Provider.of<FireBaseServices>(context, listen: true);
    LoginService loginService =
    Provider.of<LoginService>(context, listen: false);
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Builder(
                  builder:(BuildContext context){
                    if(filters ==0){
                     return StreamBuilder<List<Residence>>(
                        stream: resService.getStyle(value1),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var _residences = snapshot.data;
                            return Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.only(bottom: 100),
                                  itemCount: _residences!.length,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return Column(
                                      children: [
                                        ResidenceCard(
                                            residence: _residences[index],
                                            onCardClick: () {
                                              resSelection.selectedResidence =
                                              _residences[index];
                                              Navigator.of(context)
                                                  .pushNamed('/SelectedResidencePage');
                                            }),
                                      ],
                                    );
                                  }),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    }
                    else{
                      if(filters == 2){
                        return StreamBuilder<List<Residence>>(
                          stream: resService.getPos1(value2, array),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var _residences = snapshot.data;
                              return Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 100),
                                    itemCount: _residences!.length,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      return Column(
                                        children: [
                                          ResidenceCard(
                                              residence: _residences[index],
                                              onCardClick: () {
                                                resSelection.selectedResidence =
                                                _residences[index];
                                                Navigator.of(context)
                                                    .pushNamed('/SelectedResidencePage');
                                              }),
                                        ],
                                      );
                                    }),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      }
                      else{
                        return StreamBuilder<List<Residence>>(
                          stream: resService.getPos(value3, array),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var _residences = snapshot.data;
                              return Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 100),
                                    itemCount: _residences!.length,
                                    itemBuilder: (BuildContext ctx, int index) {
                                      return Column(
                                        children: [
                                          ResidenceCard(
                                              residence: _residences[index],
                                              onCardClick: () {
                                                resSelection.selectedResidence =
                                                _residences[index];
                                                Navigator.of(context)
                                                    .pushNamed('/SelectedResidencePage');
                                              }),
                                        ],
                                      );
                                    }),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: SlidingUpPanel(
                minHeight: 30,
                maxHeight: 300,
                panel: Container(
                  padding: EdgeInsets.only(top: 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Center(
                        child: Text("Фильтры"),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Архитектурные стили',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white
                            ),
                          ),
                          items: Style
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white
                                  ),
                                ),
                              ))
                              .toList(),
                          value: value1,
                          onChanged: (value) {
                            setState(() {
                              filters =0;
                              value1 = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 300,
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black
                          ),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black
                          ),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Архитектурные объекты',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white
                            ),
                          ),
                          items: Objct
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                      color: Colors.white
                                  ),
                                ),
                              ))
                              .toList(),
                          value: value2,
                          onChanged: (value) {
                            setState(() {
                              filters =2;
                              array = "Obj";
                              value2 = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 300,
                          buttonDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black
                          ),
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black
                          ),
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(
                            'Архитекторы',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          items: Arch
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                      color: Colors.white
                                  ),
                                ),
                              ))
                              .toList(),
                          value: value3,
                          onChanged: (value) {
                            setState(() {
                              array = "Arch";
                              filters =3;
                              value3 = value as String;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 300,
                          dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black
                          ),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                          ),
                        ),
                      ),
                    ]
                  ),
                ),

                collapsed: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: radius
                  ),
                  child: Center(
                    child: Text(
                      "Фильтры",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                borderRadius: radius,
              ),
            ),
            Positioned(
                bottom: 0, left: 0, right: 0, child: ResidenceBottomBar()),
          ],
        ),
      ),
    );
  }
}
