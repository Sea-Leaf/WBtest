import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/pages/AuthPage.dart';
import 'package:newsapp/pages/EditNewsPage.dart';
import 'package:newsapp/pages/HomePage.dart';
import 'package:newsapp/pages/UserPage.dart';
import 'package:newsapp/services/AuthService.dart';
import 'package:newsapp/services/EditNewsService.dart';
import 'package:newsapp/services/ImagePickService.dart';
import 'package:newsapp/services/StorageService.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const NewsApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class NewsApp extends StatefulWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          Provider(create: (_) => EditNewsService()),
          Provider(create: (_) => StorageService()),
          Provider(create: (_) => ImagePick()),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot){
                if( snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }else if (snapshot.hasError){
                  return Center(child: Text("Ошибка подключения"));
                } else if(snapshot.hasData){
                  return HomePage();
                } else {
                  return AuthPage();
                }},
              ),
              '/EditNews': (context) => EditNewsPage(),
              '/HomePage': (context) => HomePage(),
            }));
  }
}
