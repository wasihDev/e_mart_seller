import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/firebase_const.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var orders = [];
  var confirmed = false.obs;
  var ondevlivery = false.obs;
  var delivered = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vender_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeStatus({title, status, docID}) async {
    var store = firestore.collection('orders').doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
