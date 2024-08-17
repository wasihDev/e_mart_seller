import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/const/styles.dart';
import 'package:e_mart_seller/controller/home_controller.dart';
import 'package:e_mart_seller/views/home_screen/home_screen.dart';
import 'package:e_mart_seller/views/order_screen/order_screen.dart';
import 'package:e_mart_seller/views/product_screen/product_screen.dart';
import 'package:e_mart_seller/views/setting_screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItem = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/products.png',
            width: 22,
            color: darkGrey,
          ),
          label: 'Products'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/orders.png',
            width: 22,
            color: darkGrey,
          ),
          label: 'Orders'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/profile.png',
            width: 22,
            color: darkGrey,
          ),
          label: 'Settings'),
    ];

    var navBody = [
      HomeScreen(),
      ProductScreen(),
      const OrderScreen(),
      SettingScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              )),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: white,
            items: navbarItem,
            onTap: (val) {
              controller.currentNavIndex.value = val;
            }),
      ),
    );
  }
}
