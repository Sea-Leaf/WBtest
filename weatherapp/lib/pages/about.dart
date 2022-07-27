import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider/theme_provider.dart';

// ignore: camel_case_types
class aboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 5,
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
                      "О приложении",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 240),
              child: Neumorphic(
                style: NeumorphicStyle(
                  depth: -2,
                  shadowLightColorEmboss: Colors.white,
                  shadowDarkColorEmboss: Colors.black,
                  lightSource: LightSource.topLeft,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(20),
                  ),
                ),
                child: Container(
                  color: Theme.of(context).drawerTheme.backgroundColor,
                  height: 65,
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Weather App",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            LimitedBox(
              maxHeight: 400,
              child: Neumorphic(
                style: NeumorphicStyle(
                  depth: 1,
                  shadowLightColorEmboss: Colors.white,
                  lightSource: themeProvider.isDarkMode
                      ? LightSource.top
                      : LightSource.bottom,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(20),
                  ),
                ),
                child: Container(
                  // margin: EdgeInsets.only(top: 200),
                  height: 346,
                  width: double.infinity,
                  color: Theme.of(context).drawerTheme.backgroundColor,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "By ITMO University",
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Версия 1.0",
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 235),
                        child: Text(
                          "От 30 сентября 2021",
                          style: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Text(
                        "All rights reserved",
                        style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
