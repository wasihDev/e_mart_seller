import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/const/firebase_const.dart';
import 'package:e_mart_seller/const/snackbars.dart';
import 'package:e_mart_seller/controller/home_controller.dart';
import 'package:e_mart_seller/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductsController extends GetxController {
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var isLoading = false.obs;

  var categoryList = <String>[].obs;
  var subcatergoryList = <String>[].obs;
  List<Category> catergory = [];
  var pImagesLinks = [];
  var pimageList = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories() async {
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var cat = categoryModelFromJson(data);
    catergory = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in catergory) {
      categoryList.add(item.name);
    }
  }

  populateSubCategoryList(cat) {
    subcatergoryList.clear();
    var data = catergory.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcatergoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) {
        return;
      } else {
        pimageList[index] = File(img.path);
      }
    } catch (e) {
      errorSnack(e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pimageList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference rf = FirebaseStorage.instance.ref(destination);
        await rf.putFile(item);
        var n = await rf.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProduct() async {
    var store = firestore.collection(products).doc();
    await store.set({
      "is_featured": false,
      "p_category": categoryValue.value,
      "p_subcategory": subcategoryValue.value,
      "p_colors": FieldValue.arrayUnion(
          [Colors.red.value.toString(), Colors.brown.value.toString()]),
      "p_image": FieldValue.arrayUnion(pImagesLinks),
      "p_desc": pdescController.text,
      "p_name": pnameController.text,
      "p_price": ppriceController.text,
      "p_quantity": pquantityController.text,
      "p_rating": "5.0",
      "p_seller": Get.find<HomeController>().username,
      "p_wishlist": FieldValue.arrayUnion([]),
      "vender_id": currentUser!.uid,
      "featured_id": '',
    });
    isLoading(false);
    successSnack("Product Uplaoded");
  }

  addFeatures(docId) async {
    await firestore.collection(products).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': true,
    }, SetOptions(merge: true));
  }

  removeFeatures(docId) async {
    await firestore.collection(products).doc(docId).set({
      'featured_id': '',
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  clearValues() {
    // pimageList.clear();
    subcatergoryList.clear();

    pnameController.clear();
    pdescController.clear();
    ppriceController.clear();
    pquantityController.clear();
  }

  removeProduct(docId) async {
    await firestore.collection(products).doc(docId).delete();
  }
}
