import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_app/src/services/auth_service.dart';

import '../utils/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Start or join a meeting',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38.0),
            child: Image.asset('assets/images/onboarding.jpg'),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              onPressed: () =>
                  context.read<AuthService>().signInWithGoogle(context),
              child: const Text(
                'Google Sign In',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: buttonColor,
                minimumSize: const Size(
                  double.infinity,
                  50,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: buttonColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
