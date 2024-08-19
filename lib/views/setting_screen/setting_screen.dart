import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controller/auth_controller.dart';
import 'package:e_mart_seller/services/profile_controller.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:e_mart_seller/views/auth_screen/login_screen.dart';
import 'package:e_mart_seller/views/messages_screen/messages_screen.dart';
import 'package:e_mart_seller/views/setting_screen/edit_profile.dart';
import 'package:e_mart_seller/views/shop_screen.dart/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const EditProfile());
              },
              icon: const Icon(Icons.edit, color: Colors.white),
            ),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signOutMethod();
                  Get.offAll(() => loginScreen());
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: FutureBuilder(
            future: StoreServices.getProfile(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                controller.snapshotData = snapshot.data!.docs[0];
                return Obx(() {
                  return Column(
                    children: [
                      ListTile(
                        leading: controller.snapshotData['imageUrl'] == ''
                            ? const CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/product.jpg'))
                            : controller
                                    .profileImgPath.value.isNotEmptyAndNotNull
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundImage: FileImage(
                                        File(controller.profileImgPath.value)))
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        controller.snapshotData['imageUrl'])),
                        title: Text(
                          controller.snapshotData['vendor_name'].toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          controller.snapshotData['email'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Divider(color: Colors.grey[700]),
                      Column(
                          children: List.generate(2, (index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const ShopScreen());
                                break;
                              case 1:
                                Get.to(() => const MessagesScreen());
                                break;
                              default:
                            }
                          },
                          leading: Icon(myData['icon']![index] as IconData?,
                              color: Colors.white),
                          title: Text(
                            myData['title']![index].toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      })),
                    ],
                  );
                });
              }
            }));
  }

  var myData = {
    'icon': [Icons.settings, Icons.message],
    'title': ['Shop Settings', 'Messages']
  };
}
