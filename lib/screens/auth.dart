import 'package:app_skeleton/widgets/auth_handler.dart';
import 'package:app_skeleton/widgets/logos.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _onLoginTap() async {
    // First, user authenticates using Google Account
    signInWithGoogle();
    // The check to see if someone is authenticated is
    // on main.dart, in the stream for authState

    // If user is not logged in, stop the function.
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    }
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
              const LogosContainers(
                  imageLeft:
                      Image(image: AssetImage('assets/images/inovisao.png')),
                  imageRight:
                      Image(image: AssetImage('assets/images/k_com_text.png'))),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              const LogosContainers(
                  imageLeft: Image(image: AssetImage('assets/images/ucdb.png')),
                  imageRight: Image(
                      image: AssetImage('assets/images/fundacao_ms.png'))),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              ElevatedButton(
                onPressed: _onLoginTap,
                child: const Text('Login com Google'),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
