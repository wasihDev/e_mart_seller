import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextfiled extends StatelessWidget {
  String hint;
  TextEditingController? controller;
  CustomTextfiled({super.key, required this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(10)),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
