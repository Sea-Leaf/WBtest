import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/images/peterhof.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 180,
                      height: 180,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(right: 9.0),
                      color: Color.fromRGBO(190, 210, 250, 0.3),
                      child: Image.asset(
                        'assets/images/peter.png',
                        scale: 3.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 87,
                      fontFamily: 'RougeScript',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.cyanAccent.withOpacity(0.2),
                          highlightColor: Colors.cyanAccent.withOpacity(0.2),
                          onTap: () {
                            Navigator.of(context).pushNamed('/ResidencePage');
                          },
                          onDoubleTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Text(
                              "Let's start the journey!",
                              style: TextStyle(
                                fontFamily: "RougeScript",
                                fontSize: 48,
                                color: Colors.white,
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(78, 144, 192, 0.6),
                                border: Border.all(
                                    color: Colors.transparent, width: 4)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
