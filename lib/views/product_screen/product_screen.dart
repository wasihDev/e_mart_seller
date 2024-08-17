import 'package:e_mart_seller/views/product_screen/add_product.dart';
import 'package:e_mart_seller/views/product_screen/product_details.dart';
import 'package:e_mart_seller/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      appBar: appBarWidget('Products'),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: List.generate(10, (index) {
            return ListTile(
                onTap: () {
                  Get.to(() => ProductDetails());
                },
                leading: Image.asset('assets/product.jpg'),
                title: const Text('Product title'),
                subtitle: const Row(
                  children: [
                    Text('\$43.0'),
                    SizedBox(width: 10),
                    Text(
                      'Featured',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    // your logic
                  },
                  itemBuilder: (BuildContext bc) {
                    return const [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.featured_play_list),
                            SizedBox(width: 5),
                            Text("Featured"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 5),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 5),
                            Text("Remove"),
                          ],
                        ),
                      )
                    ];
                  },
                ));
          }),
        ),
      )),
    );
  }
}
