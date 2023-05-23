import 'package:ejrili_yammi/Login/LoginPage.dart';
import 'package:ejrili_yammi/Screen/WelcomePage.dart';
import 'package:ejrili_yammi/emergency/RasaChatPage.dart';
import 'package:ejrili_yammi/Animations/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // colorSchemeSeed: Color.fromARGB(255, 35, 212, 64),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
