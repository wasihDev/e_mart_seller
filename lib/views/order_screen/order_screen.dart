import 'package:e_mart_seller/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Orders'),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: List.generate(10, (index) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                tileColor: Colors.grey[300],
                // leading: Image.asset('assets/product.jpg'),
                title: const Text(
                  '34823498230842',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 8),
                        Text(intl.DateFormat().add_yMd().format(DateTime.now()))
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
                trailing: const Text(
                  '\$40.0',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            );
          }),
        ),
      )),
    );
  }
}
