import 'package:app_skeleton/screens/auth.dart';
import 'package:app_skeleton/screens/uploads.dart';
import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() {
    return _ImageScreenState();
  }
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {

    void _onLogoutTap() async {
    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AuthScreen(),
      ),
    );
  }

    return Scaffold(
      appBar: AppBar(
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
