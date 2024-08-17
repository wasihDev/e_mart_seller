import 'package:e_mart_seller/const/const.dart';
import 'package:flutter/material.dart';

Widget productDropdown() {
  return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
    hint: const Text('Select Category'),
    value: null,
    isExpanded: true,
    items: [],
    onChanged: (val) {},
  )).box.white.padding(EdgeInsets.symmetric(horizontal: 4)).roundedSM.make();
}
