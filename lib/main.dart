// Provider and basic pakcagess, and auth screen
import 'package:app_skeleton/screens/images.dart';
import 'package:app_skeleton/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:app_skeleton/screens/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Firebase and FirebaseAuth packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  // Inicialization of firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // start of main app and include it within the provider
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Estilizacao do aplicativo base
      title: 'Inophotos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 14, 13, 48), //Colors.pink,
          brightness: Brightness.dark,
        ),
      ),
      
      // Streambuilder para ouvir FirebaseAuth.instance para
      // observar se ha usuario logado ou nao, e agir de acordo
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const SplashScreen();
          }
          if (snapshot.hasData) {
            return const PhotoScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
