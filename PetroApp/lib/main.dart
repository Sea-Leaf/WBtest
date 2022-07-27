import 'package:firebase_core/firebase_core.dart';
import 'package:petroapp/pages/AllResidenceMap.dart';
import 'package:petroapp/pages/ArchitectPage.dart';
import 'package:petroapp/pages/MapPage.dart';
import 'package:petroapp/pages/ObjectPage.dart';
import 'package:petroapp/pages/ResFiltrPage.dart';
import 'package:petroapp/pages/ResidenceArchList.dart';
import 'package:petroapp/pages/ResidenceControlPage.dart';
import 'package:petroapp/pages/ResidenceObjectList.dart';
import 'package:petroapp/pages/ResidencePage.dart';
import 'package:petroapp/pages/ResidenceUpdate.dart';
import 'package:petroapp/pages/SelectedResidencePage.dart';
import 'package:petroapp/pages/WelcomePage.dart';
import 'package:petroapp/services/FireBaseService.dart';
import 'package:petroapp/services/LoginService.dart';
import 'package:petroapp/services/Residenceselectedservice.dart';
import 'package:petroapp/widgets/ExpansionPanel.dart';
import 'package:petroapp/widgets/SideMenu.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(PetroApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class PetroApp extends StatefulWidget {
  @override
  _PetroAppState createState() => _PetroAppState();
}

class _PetroAppState extends State<PetroApp> {
  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => LoginService(),
          ),
          ChangeNotifierProvider(create: (_) => ResidenceSelectedService()),
          Provider(create: (_) => FireBaseServices())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => WelcomePage(),
              '/Welcomepage': (context) => WelcomePage(),
              '/ResidencePage': (context) => ResidencePage(),
              '/MapPage': (context) => MapPage(),
              '/SelectedResidencePage': (context) => SelectedResidencePage(),
              '/ResidenceArchList': (context) => ResidenceArchitect(),
              '/ResidenceObjectList': (context) => ResidenceObjects(),
              '/ObjectPage': (context) => ObjectPage(),
              '/ResidenceCntrPage': (context) => ResidenceCntrPage(),
              '/ArchPage': (context) => ArchPage(),
              '/ResidenceUpdate': (context) => ResidenceUpdate(),
              '/FiltrationPage': (context) => FiltrationPage(),
              '/AllMap': (context) => AllResidenceMap(),
              '/Admin': (context) => SideMenu()
            }));
  }
}
