// ignore_for_file: use_build_context_synchronously

import 'package:cloudocz/data/shared_preference.dart';
import 'package:cloudocz/view/home.dart';
import 'package:cloudocz/view/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    loginCheck(context);
    return const Scaffold(
      body: Center(
        child: Text(
          'Cumins360',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
    );
  }

  loginCheck(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 2500));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
