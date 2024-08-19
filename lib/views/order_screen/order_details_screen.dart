import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/controller/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetailsScreen extends StatefulWidget {
  final dynamic dataItem;
  const OrderDetailsScreen({super.key, required this.dataItem});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  var controller = Get.find<OrderController>();
  @override
  void initState() {
    controller.getOrders(widget.dataItem);
    controller.confirmed.value = widget.dataItem['order_confirmed'];
    controller.ondevlivery.value = widget.dataItem['order_on_delivery'];
    controller.confirmed.value = widget.dataItem['order_delivered'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var time = widget.dataItem['order_date'].toDate();
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Order details'),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: InkWell(
            onTap: () {
              controller.confirmed(true);
              controller.changeStatus(
                  title: 'order_confirmed',
                  status: true,
                  docID: widget.dataItem.id);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              color: purpleColor,
              child: const Center(
                  child: Text(
                'Confirm order',
                style: TextStyle(fontWeight: FontWeight.bold, color: white),
              )),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Order Status:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Visibility(
                visible: controller.confirmed.value,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Placed',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Switch(value: true, onChanged: (val) {})
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Confirmed',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Switch(
                              value: controller.confirmed.value,
                              onChanged: (val) {
                                controller.confirmed.value = val;
                                controller.changeStatus(
                                    title: 'order_confirmed',
                                    status: val,
                                    docID: widget.dataItem.id);
                              })
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'on Delivery',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Switch(
                              value: controller.ondevlivery.value,
                              onChanged: (val) {
                                controller.ondevlivery.value = val;
                                controller.changeStatus(
                                    title: 'order_on_delivery',
                                    status: val,
                                    docID: widget.dataItem.id);
                              })
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Delivered',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Switch(
                              value: controller.delivered.value,
                              onChanged: (val) {
                                controller.delivered.value = val;
                                controller.changeStatus(
                                    title: 'order_delivered',
                                    status: val,
                                    docID: widget.dataItem.id);
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order code',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.dataItem['order_code'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shipping Method',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.dataItem['shipping_method'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(intl.DateFormat().add_yMd().format(time),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Method',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.dataItem['payment_method'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Status',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Unpaid',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Delivery Status',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.dataItem['order_placed'].toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Shipping Address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.dataItem['order_by_name'].toString()),
                      Text(widget.dataItem['order_by_email'].toString()),
                      Text(widget.dataItem['order_by_address'].toString()),
                      Text(widget.dataItem['order_by_state'].toString()),
                      Text(widget.dataItem['order_by_city'].toString()),
                      Text(widget.dataItem['order_by_phone'].toString()),
                      Text(widget.dataItem['order_by_postalcode'].toString()),
                      // Text(dataItem['order_placed'].toString()),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('\$${widget.dataItem['total_amount'].toString()}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red))
                    ],
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 5),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Order Products:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(controller.orders.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.orders[index]['p_name'].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${controller.orders[index]['p_quantity']}(x)",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Color(int.parse(
                                      controller.orders[index]['p_color'])),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$${controller.orders[index]['t_price']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text('Refunable',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ],
                          ),
                        ],
                      ),
                    );
                  })),
              const SizedBox(height: 10)
            ],
          ),
        ),
      );
    });
  }
}
