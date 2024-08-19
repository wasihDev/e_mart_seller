import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/const/snackbars.dart';
import 'package:e_mart_seller/services/profile_controller.dart';
import 'package:e_mart_seller/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(() {
      return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            'Shop Screen',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            controller.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                          shopMobile: controller.shopMobileController.text,
                          shopWeb: controller.shopWebsiteController.text,
                          shopaddress: controller.shopAddressController.text,
                          shopdes: controller.shopDescController.text,
                          shopname: controller.shopNameController.text);
                      successSnack('Shop Updated');
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ))
          ],
        ),
        body: Column(
          children: [
            CustomTextfiled(
                hint: 'Shop Name', controller: controller.shopNameController),
            CustomTextfiled(
                hint: 'Shop address',
                controller: controller.shopAddressController),
            CustomTextfiled(
                hint: 'Shop Mobile',
                controller: controller.shopMobileController),
            CustomTextfiled(
                hint: 'Shop website link',
                controller: controller.shopWebsiteController),
            CustomTextfiled(
                hint: 'Description', controller: controller.shopDescController),
          ],
        ),
      );
    });
  }
}
