import 'package:flutter/material.dart';
import 'package:app_skeleton/screens/auth.dart';

void main() {
  // TODO: Firebase initialization
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Skeleton',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      // TODO: change home value for Streambuilder when firebase is running
      // TODO: auth or choose image screen dependning if the use r is logged in or not
      home: const AuthScreen(),
    );
  }
}
