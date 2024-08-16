import 'package:e_mart_seller/const/colors.dart';
import 'package:get/get.dart';

SnackbarController errorSnack(String error) {
  return Get.snackbar("Error", error,
      backgroundColor: red,
      colorText: white,
      snackPosition: SnackPosition.BOTTOM);
}

SnackbarController successSnack(String msg) {
  return Get.snackbar(
    'Updated',
    msg,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: green,
    colorText: white,
  );
}
