import 'package:flutter/material.dart';
import 'package:flutter_application_1/modules/autenticacion/login.dart';
import 'package:get/get.dart';

class App extends StatelessWidget{
  const App({super.key});


 @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginApp(),
      debugShowCheckedModeBanner: false,
      
    );
  }
}