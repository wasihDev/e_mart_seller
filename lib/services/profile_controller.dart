import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/firebase_const.dart';
import 'package:e_mart_seller/const/snackbars.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImageLink = '';
  late QueryDocumentSnapshot snapshotData;

  var isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  // shop controller
  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescController = TextEditingController();
  changeImage() async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      errorSnack(e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
    log("ImageLink $profileImageLink");
  }

  uploadProfileData({name, password}) {
    var store = firestore.collection(vendorCollection).doc(currentUser!.uid);
    store.set({
      'vendor_name': name,
      'password': password,
      'imageUrl': profileImageLink
    }, SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
      isLoading(false);
    }).catchError((err) {
      log(err);
    });
  }

  updateShop({shopname, shopaddress, shopdes, shopWeb, shopMobile}) async {
    var store = firestore.collection(vendorCollection).doc(currentUser!.uid);
    store.set({
      'shop_name': shopname,
      'shop_address': shopaddress,
      'shop_desc': shopdes,
      'shop_website': shopWeb,
      'shop_mobile': shopMobile,
    }, SetOptions(merge: true));
    isLoading(false);
  }
}
