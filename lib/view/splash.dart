// ignore_for_file: use_build_context_synchronously
import 'package:cloudocz/data/shared_preference/shared_preference.dart';
import 'package:cloudocz/utils/logger.dart';
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
          'CloudocZ',
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
    final token = SharedPreference.instance.getToken();
    if (token != null) {
      Logger.log(token, type: LogType.info);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }
}
