import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/widgets/app_bar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var myList = {
    'name': ['Products', 'Orders', 'Rating', 'Total Sales'],
    'count': ['60', '15', '60', '15'],
    'images': [
      'assets/icons/products.png',
      'assets/icons/orders.png',
      'assets/icons/orders.png',
      'assets/icons/star.png'
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Dashboard'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 0),
            itemCount: 4,
            itemBuilder: (_, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: ProductWidget(
                title: myList['name']![index],
                image: myList['images']![index],
                itemCount: myList['count']![index],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Popular Products'),
          ),
          ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Image.asset('assets/product.jpg'),
                  title: const Text('Product title'),
                  subtitle: const Text('\$43.0'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                );
              })
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ProductWidget extends StatelessWidget {
  String title;
  String itemCount;
  String image;

  ProductWidget(
      {super.key,
      required this.title,
      required this.image,
      required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
          color: purpleColor, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  itemCount,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
            Image.asset(
              image,
              scale: 1.8,
            )
          ],
        ),
      ),
    );
  }
}
