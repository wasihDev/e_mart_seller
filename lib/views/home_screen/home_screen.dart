import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:e_mart_seller/views/product_screen/product_details.dart';
import 'package:e_mart_seller/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: StreamBuilder(
          stream: StoreServices.getProducts(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) =>
                  b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return data[index]['p_wishlist'].length == 0
                            ? SizedBox()
                            : ListTile(
                                onTap: () {
                                  Get.to(() => ProductDetails(
                                      data: snapshot.data!.docs[index]));
                                },
                                leading: SizedBox(
                                    height: 50,
                                    width: 80,
                                    child: Image.network(
                                      data[index]['p_image'][0],
                                      fit: BoxFit.fill,
                                    )),
                                title: Text(data[index]['p_name']),
                                subtitle: Text('\$${data[index]['p_price']}'),
                                trailing: const Icon(Icons.arrow_forward_ios),
                              );
                      })
                ],
              );
            }
          }),
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
