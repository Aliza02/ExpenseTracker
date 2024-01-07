import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  final String buttonTitle;
  final Function onPressed;
  const Button({super.key, required this.buttonTitle,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          surfaceTintColor: const Color.fromARGB(255, 162, 188, 209),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        child: Text(
          buttonTitle,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: Get.width * 0.04,
          ),
        ),
      ),
    );
  }
}
