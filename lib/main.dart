import 'package:climate/screens/loading_screen.dart';
// import 'package:climate/screens/location_screen.dart';
// import 'package:climate/screens/city_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
      },
    );
  }
}
