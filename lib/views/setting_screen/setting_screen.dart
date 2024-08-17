import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/views/messages_screen/messages_screen.dart';
import 'package:e_mart_seller/views/setting_screen/edit_profile.dart';
import 'package:e_mart_seller/views/shop_screen.dart/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          const ListTile(
            leading: CircleAvatar(
                radius: 40, backgroundImage: AssetImage('assets/product.jpg')),
            title: Text(
              'Vender name',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Vender@gmail.com',
              style: TextStyle(color: Colors.white),
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
      ),
    );
  }

  var myData = {
    'icon': [Icons.settings, Icons.message],
    'title': ['Shop Settings', 'Messages']
  };
}
