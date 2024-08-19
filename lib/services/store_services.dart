import 'package:e_mart_seller/const/firebase_const.dart';

class StoreServices {
  static getProfile() {
    return firestore
        .collection(vendorCollection)
        .where('uid', isEqualTo: currentUser!.uid)
        .get();
  }

  static getMessages() {
    return firestore
        .collection(chatCollection)
        .where('toId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getOrders() {
    return firestore
        .collection('orders')
        .where('vendors', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getChats(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getProducts() {
    return firestore
        .collection('products')
        .where('vender_id', isEqualTo: currentUser!.uid)
        .snapshots();
  }
}
