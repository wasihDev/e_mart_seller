import 'package:flutter/material.dart';

Widget productImages({
  required label,
  onPress,
}) {
  return InkWell(
    onTap: onPress,
    child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )),
  );
}
