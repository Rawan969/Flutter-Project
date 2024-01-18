import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterproject/provider/my_provider.dart';
import 'package:flutterproject/screens/home_page.dart';
import 'package:flutterproject/screens/login_page.dart';
import 'package:flutterproject/screens/welcome_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid? await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDModyrdLFtBmVe8W89rLNrBjtA5dBNl0o', 
      appId: '1:54110458393:android:68c71b3529ed22ebc39088', 
      messagingSenderId: '54110458393', 
      projectId: 'tastefood-70a2e')
  )
  :
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff2b2b2b),
          appBarTheme: AppBarTheme(
            color: Color(0xff2b2b2b),
          ),
        ),
        home: WelcomePage(),
        //home: HomePage(),
        /* home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
             builder: (index, sncpshot) {
              if (sncpshot.hasData) {
                 return HomePage();
               }
               return LoginPage();
             }), */
      ),
    );
  }
}
