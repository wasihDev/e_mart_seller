import 'dart:developer';

import 'package:e_mart_seller/const/firebase_const.dart';
import 'package:e_mart_seller/const/snackbars.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // Sign in
  Future<UserCredential?> signInMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log("error1 $e");
      errorSnack(e.toString());
    }
    return userCredential;
  }

  // sign out
  signOutMethod() async {
    try {
      await auth.signOut();
    } catch (e) {
      log("error3 $e");
      errorSnack(e.toString());
    }
  }
}
