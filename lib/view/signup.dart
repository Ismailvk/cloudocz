import 'package:cloudocz/view/login.dart';
import 'package:cloudocz/widgets/button.dart';
import 'package:cloudocz/widgets/textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> signupKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600),
                    ),
                    SizedBox(height: size.height / 14),
                    Form(
                      key: signupKey,
                      child: Column(
                        children: [
                          MyTextField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Enter Your Name';
                              } else {
                                return null;
                              }
                            },
                            controller: nameController,
                            hintText: 'Enter Your Name',
                          ),
                          SizedBox(height: size.height * 0.02),
                          MyTextField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Enter Your Email';
                              } else {
                                return null;
                              }
                            },
                            controller: emailController,
                            hintText: 'Enter Your Email',
                          ),
                          SizedBox(height: size.height * 0.02),
                          MyTextField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'Enter Your Password';
                              } else {
                                return null;
                              }
                            },
                            controller: passwordController,
                            hintText: 'Enter Your Password',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    ButtonWidget(
                      title: 'Create Account',
                      onPress: () {},
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ? '),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen())),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
