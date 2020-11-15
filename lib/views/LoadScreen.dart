import 'package:flutter/material.dart';
import 'package:hinergi_v9/views/HinergiApp.dart';

class loadScreen extends StatefulWidget {
  @override
  _loadScreenState createState() => _loadScreenState();
}

class _loadScreenState extends State<loadScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // body: MyApp(),
        // body: LoginPage(),
        body: HinergiApp(),
      ),
    );
  }
}