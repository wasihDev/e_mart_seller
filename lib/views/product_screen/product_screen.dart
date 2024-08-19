import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/services/store_services.dart';
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
        child: StreamBuilder(
            stream: StoreServices.getProducts(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return const Text('no products');
              } else {
                return Column(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    var itemData = snapshot.data!.docs[index];
                    return ListTile(
                        onTap: () {
                          Get.to(() => ProductDetails(data: itemData));
                        },
                        leading: SizedBox(
                            height: 50,
                            width: 80,
                            child: Image.network(itemData['p_image'][0])),
                        title: Text(itemData['p_name']),
                        subtitle: Row(
                          children: [
                            Text('\$${itemData['p_price']}'),
                            const SizedBox(width: 10),
                            Text(
                              '${itemData['is_featured'] == true ? "Featured" : ""}',
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
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
                );
              }
            }),
      )),
    );
  }
}
