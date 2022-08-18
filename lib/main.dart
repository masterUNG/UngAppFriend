import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ungappfriend/states/authen.dart';
import 'package:ungappfriend/utility/my_constant.dart';

void main() {
  HttpOverrides.global = MyHttpOverride();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: MyConstant.dark,
          elevation: 0,
        ),
      ),
      home: Authen(),
    );
  }
}

class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // TODO: implement createHttpClient
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
