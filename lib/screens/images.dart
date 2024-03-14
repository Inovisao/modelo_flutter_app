import 'package:app_skeleton/screens/uploads.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  State<PhotoScreen> createState() {
    return _PhotoScreenState();
  }
}

class _PhotoScreenState extends State<PhotoScreen> {
  void _onLogoutTap() async {
    // Disconnect from Google services first
    await GoogleSignIn().disconnect();
    // Then disconnect from FirebaseAuth
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Image(
            image: AssetImage('assets/images/logo-alta-resolucao.png')),
        title: const Text('Picture Queue'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: _onLogoutTap,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const UploadsScreen(),
    );
  }
}
