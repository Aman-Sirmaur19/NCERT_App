import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'screens/home_screen.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NCERT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              fontSize: 17,
              letterSpacing: 1,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
