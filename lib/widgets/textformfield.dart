import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/colors.dart';

class textformfield extends StatefulWidget {
  final String hintText;
  final Color color;
  final double opacity;
  final bool isDate;
  final TextInputType inputType;
  final TextEditingController controller;

  const textformfield(
      {super.key,
      required this.hintText,
      required this.color,
      required this.opacity,
      required this.isDate,
      required this.inputType,
      required this.controller});

  @override
  State<textformfield> createState() => _textformfieldState();
}

class _textformfieldState extends State<textformfield> {
  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate = DateTime.now();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime(2015),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != selectedDate) {
        setState(() {
          selectedDate = pickedDate;
          widget.controller.value = TextEditingValue(
              text:
                  "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}");
        });
        print(selectedDate);
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * 0.03,
        vertical: Get.height * 0.015,
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        cursorColor: AppColors.cream,
        style: TextStyle(
          color: AppColors.cream,
          fontSize: Get.width * 0.04,
        ),
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: AppColors.cream,
              fontSize: Get.width * 0.04,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: AppColors.cream,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: AppColors.cream,
                width: 1.0,
              ),
            ),
            suffixIcon: widget.isDate
                ? InkWell(
                    onTap: () {
                      _selectDate(context);
                      print(selectedDate);
                    },
                    child: const Icon(
                      Icons.calendar_today,
                      color: AppColors.cream,
                    ),
                  )
                : null),
      ),
    );
  }
}
