import 'package:cloudocz/controller/login/login_bloc.dart';
import 'package:cloudocz/view/home.dart';
import 'package:cloudocz/view/signup.dart';
import 'package:cloudocz/widgets/button.dart';
import 'package:cloudocz/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in to continue',
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Form(
                    key: loginKey,
                    child: Column(
                      children: [
                        MyTextField(
                          validator: (value) => null,
                          controller: emailController,
                          hintText: 'Enter Your Email',
                        ),
                        SizedBox(height: size.height * 0.02),
                        MyTextField(
                          validator: (value) => null,
                          controller: passwordController,
                          hintText: 'Enter Your Password',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is LoginSuccessState) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false,
                          );
                        });
                      }
                      return ButtonWidget(
                        title: 'Login',
                        onPress: () {
                          if (loginKey.currentState!.validate()) {
                            Map<String, String> userData = {
                              "email": emailController.text,
                              "password": passwordController.text,
                            };
                            context
                                .read<LoginBloc>()
                                .add(LoginUser(loginData: userData));
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account ? "),
                      GestureDetector(
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen())),
                          child: const Center(
                              child: Text(
                            'Signup',
                            style: TextStyle(color: Colors.blue),
                          ))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
