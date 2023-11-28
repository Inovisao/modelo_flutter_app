import 'package:app_skeleton/screens/images.dart';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //TODO: set variables for account validation and login

  //TODO: create submit method for Firebase storage of information, and error handling

  void _onLoginTap() async {
    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ImageScreen(),
      ),
    );
  }

  void _onRegisterTap() async {
    Navigator.of(context).pop();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ImageScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 500,
                child: const Image(
                  image: NetworkImage(
                    'https://pbs.twimg.com/media/F7GAY2ZWgAACQbX.jpg', //TODO: obtain generic image for app/INOVISAO logo
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _onLoginTap,
                child: const Text('Login com Google'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _onRegisterTap,
                child: const Text('Criar com Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
