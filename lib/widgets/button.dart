import 'package:flutter/material.dart';

class MyLoadingButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final bool isLoading;
  const MyLoadingButton(
      {super.key, this.onTap, required this.title, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
            height: 52,
            padding: const EdgeInsets.only(left: 20, right: 20),
            // margin: const EdgeInsets.symmetric(horizontal: 25),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: isLoading
                    ? Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(color: Colors.white))
                    : Text(title, style: TextStyle(color: Colors.white)))));
  }
}
