import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:weather/widget/change_theme_button_widget.dart';

// ignore: camel_case_types
class settingsApp extends StatefulWidget {
  @override
  _settingsAppState createState() => _settingsAppState();
}

// ignore: camel_case_types
class _settingsAppState extends State<settingsApp> {
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
                      "Настройки",
                      style: TextStyle(
                        // color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Единицы измерения",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
                height: 160,
                color: Theme.of(context).drawerTheme.backgroundColor,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(15),
                //   color: Colors.blueGrey[50],
                //   boxShadow: [
                //     BoxShadow(
                //         color: Colors.grey.withOpacity(0.4),
                //         spreadRadius: 1,
                //         blurRadius: 3,
                //         offset: const Offset(0, 4))
                //   ],
                // ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/temp');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Температура",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[350],
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white54),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/wind');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Скорость ветра",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[350],
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.white54),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/pressure');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Давление",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[350],
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Системная тема",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
                height: 55,
                color: Theme.of(context).drawerTheme.backgroundColor,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(15),
                //   color: Colors.blueGrey[50],
                //   boxShadow: [
                //     BoxShadow(
                //         color: Colors.grey.withOpacity(0.4),
                //         spreadRadius: 1,
                //         blurRadius: 3,
                //         offset: const Offset(0, 4))
                //   ],
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Светлая/Тёмная",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      ChangeThemeButtonWidget(),
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
