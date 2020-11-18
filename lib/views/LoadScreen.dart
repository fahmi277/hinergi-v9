import 'package:flutter/material.dart';
import 'package:hinergi_v9/login/view/LoginPage.dart';
import 'package:hinergi_v9/setting/view/SettingPage.dart';
import 'package:hinergi_v9/views/HinergiApp.dart';
import 'package:hinergi_v9/views/HistoryPage.dart';

class loadScreen extends StatefulWidget {
  @override
  _loadScreenState createState() => _loadScreenState();
}

class _loadScreenState extends State<loadScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // debugShowMaterialGrid: true,
      home: Scaffold(
        // body: MyApp(),
        body: LoginPage(),
        // body: HinergiApp(),
        // body:SettingPage(),
      ),
      routes: <String, WidgetBuilder>{
        '/login' : (BuildContext context) => new LoginPage(),
        '/setting' : (BuildContext context) => new SettingPage(),
        '/home' : (BuildContext context) => new HinergiApp(),
        '/history' : (BuildContext context) => new HistoryPage()
      },
    );
  }
}
