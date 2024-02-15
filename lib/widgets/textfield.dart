import 'package:flutter/material.dart';
import 'package:get/get.dart';

class textfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const textfield({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  State<textfield> createState() => _textfieldState();
}

class _textfieldState extends State<textfield> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.9,
      height: Get.height * 0.065,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.hintText == 'Password' ||
                widget.hintText == 'Confirm Password'
            ? obscureText
            : !obscureText,
        decoration: InputDecoration(
          suffixIcon: widget.hintText == 'Password'
              ? InkWell(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  child: Icon(obscureText == false
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                )
              : null,
          hintText: widget.hintText,
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
