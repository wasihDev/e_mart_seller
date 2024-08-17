import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Edit profile',
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
              radius: 50, backgroundImage: AssetImage('assets/product.jpg')),
          const SizedBox(height: 10),
          Container(
            height: 45,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: MaterialButton(
                onPressed: () {},
                child: const Center(
                  child: Text('Change Image'),
                )),
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey[700]),
          CustomTextfiled(hint: 'Email address'),
          CustomTextfiled(hint: 'Old password'),
          CustomTextfiled(hint: 'New password'),
        ],
      ),
    );
  }
}
