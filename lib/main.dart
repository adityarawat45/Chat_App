import 'package:chat_app04/Auth_screens/login_screen.dart';
import 'package:chat_app04/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  build(BuildContext context) {
    return MaterialApp(
      home: const Splashscreen(),
    );
  }
}
