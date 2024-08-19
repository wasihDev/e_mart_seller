import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:e_mart_seller/controller/order_controller.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:e_mart_seller/views/order_screen/order_details_screen.dart';
import 'package:e_mart_seller/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(OrderController());
    return Scaffold(
      appBar: appBarWidget('Orders'),
      body: SafeArea(
          child: SingleChildScrollView(
        child: StreamBuilder(
            stream: StoreServices.getOrders(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var itemData = snapshot.data!.docs;

                return Column(
                  children: List.generate(itemData.length, (index) {
                    var time = itemData[index]['order_date'].toDate();
                    return Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        onTap: () {
                          Get.to(() => OrderDetailsScreen(
                                dataItem: itemData[index],
                              ));
                        },
                        tileColor: Colors.grey[300],
                        // leading: Image.asset('assets/product.jpg'),
                        title: Text(
                          itemData[index]['order_code'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.calendar_month),
                                const SizedBox(width: 8),
                                // order_date
                                Text(intl.DateFormat().add_yMd().format(time))
                              ],
                            ),
                            const Row(
                              children: [
                                Icon(Icons.payment),
                                SizedBox(width: 8),
                                Text(
                                  'Unpaid',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.red),
                                )
                              ],
                            )
                          ],
                        ),
                        trailing: Text(
                          '\$${itemData[index]['orders'][index]['t_price'].toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    );
                  }),
                );
              }
            }),
      )),
    );
  }
}
