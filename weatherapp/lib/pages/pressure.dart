import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// ignore: camel_case_types
class pressure extends StatefulWidget {
  @override
  _temperatureState createState() => _temperatureState();
}

// ignore: camel_case_types
class _temperatureState extends State<pressure> {
  bool tempC = true;
  bool tempF = false;
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
                      width: 25,
                    ),
                    Text(
                      "Давление",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Neumorphic(
              style: NeumorphicStyle(
                depth: 1,
                shadowLightColorEmboss: Colors.white,
                shadowDarkColorEmboss: Colors.black,
                lightSource: LightSource.topLeft,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(15),
                ),
              ),
              child: Container(
                width: 360,
                height: 100,
                color: Theme.of(context).drawerTheme.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              tempC = true;
                              tempF = false;
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "мм.рт.ст.",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Visibility(
                              visible: tempC,
                              child:
                                  const Icon(Icons.check, color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                      Divider(color: Colors.white54),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            tempC = false;
                            tempF = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "ГпА",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Visibility(
                              visible: tempF,
                              child:
                                  const Icon(Icons.check, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
