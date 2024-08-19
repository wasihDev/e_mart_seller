import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/controller/products_controller.dart';
import 'package:get/get.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return Obx(() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DropdownButtonHideUnderline(
              child: DropdownButton(
        hint: Text(hint),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        onChanged: (val) {
          if (hint == 'Category') {
            controller.subcategoryValue.value = '';
            controller.populateSubCategoryList(val.toString());
          }
          dropvalue.value = val.toString();
        },
      ))
          .box
          .white
          .padding(EdgeInsets.symmetric(horizontal: 4))
          .roundedSM
          .make(),
    );
  });
}
