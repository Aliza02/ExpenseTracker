import 'package:flutter/material.dart';
import 'package:get/get.dart';

class textfield extends StatelessWidget {
  final String hintText;
  const textfield({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      height: Get.height * 0.065,
      child: TextFormField(
        obscureText: hintText == 'Password' ? true : false,
        decoration: InputDecoration(
          suffixIcon: hintText == 'Password'
              ? const Icon(Icons.visibility_off_outlined)
              : null,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Get.width * 0.02),
            borderSide: const BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Get.width * 0.02),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 2.0,
              )),
        ),
      ),
    );
  }
}
