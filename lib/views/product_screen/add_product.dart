import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/controller/products_controller.dart';
import 'package:e_mart_seller/views/product_screen/component/product_dropdown.dart';
import 'package:e_mart_seller/views/product_screen/component/product_widget.dart';
import 'package:e_mart_seller/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(() {
      return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  controller.isLoading(true);
                  await controller.uploadImages();
                  await controller.uploadProduct();
                  Navigator.pop(context);
                  controller.clearValues();
                },
                child: controller.isLoading.value
                    ? const Text(
                        'loading..',
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextfiled(
                  hint: 'Product name', controller: controller.pnameController),
              CustomTextfiled(
                  hint: 'Description', controller: controller.pdescController),
              CustomTextfiled(
                  hint: 'Price', controller: controller.ppriceController),
              CustomTextfiled(
                  hint: 'quantity', controller: controller.pquantityController),
              const SizedBox(height: 5),
              productDropdown("Category", controller.categoryList,
                  controller.categoryValue, controller),
              const SizedBox(height: 15),
              productDropdown("SubCategory", controller.subcatergoryList,
                  controller.subcategoryValue, controller),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Choose product images',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              Obx(() {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(3, (index) {
                      return controller.pimageList[index] != null
                          ? SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.file(
                                controller.pimageList[index],
                                fit: BoxFit.cover,
                              ).onTap(() {
                                controller.pickImage(index);
                              }))
                          : productImages(
                              label: '${index + 1}',
                              onPress: () {
                                controller.pickImage(index);
                              });
                    }));
              }),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('First image will be your thumbnail image',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const SizedBox(height: 10),
              Obx(() {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                      9,
                      (index) => Stack(
                            alignment: Alignment.center,
                            children: [
                              VxBox()
                                  .color(Vx.randomPrimaryColor)
                                  .roundedFull
                                  .size(65, 65)
                                  .make()
                                  .onTap(() {
                                controller.selectedColorIndex.value == index;
                              }),
                              controller.selectedColorIndex.value == index
                                  ? const Icon(Icons.done, color: Colors.white)
                                  : const SizedBox()
                            ],
                          )),
                );
              })
            ],
          ),
        ),
      );
    });
  }
}
