import 'dart:io';

import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/const/snackbars.dart';
import 'package:e_mart_seller/services/profile_controller.dart';
import 'package:e_mart_seller/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          'Edit profile',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Obx(() {
            return TextButton(
                onPressed: () async {
                  controller.isLoading(true);

                  // if image is not selected
                  if (controller.profileImgPath.value.isNotEmpty) {
                    await controller.uploadProfileImage();
                  } else {
                    controller.profileImageLink =
                        controller.snapshotData['imageUrl'];
                  }
                  // if old password matched database
                  if (controller.snapshotData['password'] ==
                      controller.oldPasswordController.text) {
                    await controller.changeAuthPassword(
                        email: controller.snapshotData['email'],
                        password: controller.oldPasswordController.text,
                        newpassword: controller.newPasswordController.text);
                    await controller.uploadProfileData(
                      password: controller.newPasswordController.text,
                      name: controller.nameController.text,
                    );

                    successSnack('Data Updated');
                    controller.isLoading(false);
                  } else if (controller
                          .oldPasswordController.text.isEmptyOrNull &&
                      controller.newPasswordController.text.isEmptyOrNull) {
                    await controller.uploadProfileData(
                        password: controller.snapshotData['password'],
                        name: controller.snapshotData['vendor_name']);
                    successSnack('Data Updated');
                    controller.isLoading(false);
                  } else {
                    errorSnack('Wrong old password');
                    controller.isLoading(false);
                  }
                },
                child: Text(
                  controller.isLoading.value ? 'loading....' : 'Save',
                  style: TextStyle(color: Colors.white),
                ));
          })
        ],
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            controller.snapshotData['imageUrl'] == '' &&
                    controller.profileImgPath.isEmpty
                ? const CircleAvatar(
                    radius: 42.0,
                    backgroundImage: AssetImage(
                      'assets/product.jpg',
                    ),
                  )
                : controller.snapshotData['imageUrl'] != '' &&
                        controller.profileImgPath.isEmpty
                    ? CircleAvatar(
                        radius: 42.0,
                        backgroundImage:
                            NetworkImage(controller.snapshotData['imageUrl']),
                      )
                    : CircleAvatar(
                        radius: 42.0,
                        backgroundImage:
                            FileImage(File(controller.profileImgPath.value))),
            const SizedBox(height: 10),
            Container(
              height: 45,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              child: MaterialButton(
                  onPressed: () {
                    controller.changeImage();
                  },
                  child: const Center(
                    child: Text('Change Image'),
                  )),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey[700]),
            CustomTextfiled(
                hint: 'Username', controller: controller.nameController),
            CustomTextfiled(
                hint: 'Old password',
                controller: controller.oldPasswordController),
            CustomTextfiled(
                hint: 'New password',
                controller: controller.newPasswordController),
          ],
        );
      }),
    );
  }
}
