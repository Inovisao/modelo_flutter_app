import 'package:flutter/material.dart';

// Tela de espera para carregamento
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading page'),
      ),
      body: const Center(
        child: Text('Loading...'),
      ),
    );
  }
}
