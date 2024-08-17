import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Shop Screen',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          CustomTextfiled(hint: 'Shop Name'),
          CustomTextfiled(hint: 'Shop address'),
          CustomTextfiled(hint: 'Shop Mobile'),
          CustomTextfiled(hint: 'Shop website link'),
          CustomTextfiled(hint: 'Description'),
        ],
      ),
    );
  }
}
