import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/snackbars.dart';
import 'package:e_mart_seller/controller/products_controller.dart';
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
    var controller = Get.put(ProductsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
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
                            child: Image.network(
                              itemData['p_image'][0],
                              fit: BoxFit.fill,
                            )),
                        title: Text(itemData['p_name']),
                        subtitle: Row(
                          children: [
                            Text('\$${itemData['p_price']}'),
                            const SizedBox(width: 10),
                            Text(
                              itemData['is_featured'] == true ? "Featured" : "",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            print(value);
                            // if (itemData['is_featured'] && value == true) {
                            //   controller.removeFeatures(itemData.id);
                            // } else {
                            //   controller.addFeatures(itemData.id);
                            // }
                          },
                          itemBuilder: (BuildContext bc) {
                            return [
                              PopupMenuItem(
                                onTap: () {
                                  if (itemData['is_featured'] == true) {
                                    controller.removeFeatures(itemData.id);
                                  } else {
                                    controller.addFeatures(itemData.id);
                                  }
                                },
                                child: const Row(
                                  children: [
                                    Icon(Icons.featured_play_list),
                                    SizedBox(width: 5),
                                    Text("Featured"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                child: const Row(
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 5),
                                    Text("Edit"),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  controller.removeProduct(itemData.id);
                                  successSnack("PRODUCT REMOvED");
                                },
                                child: const Row(
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
