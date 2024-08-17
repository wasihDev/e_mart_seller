import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/views/product_screen/component/product_dropdown.dart';
import 'package:e_mart_seller/views/product_screen/component/product_widget.dart';
import 'package:e_mart_seller/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextfiled(hint: 'Product name'),
            CustomTextfiled(hint: 'Description'),
            CustomTextfiled(hint: 'Price'),
            CustomTextfiled(hint: 'quantity'),
            CustomTextfiled(hint: 'Product name'),
            CustomTextfiled(hint: 'Product name'),
            productDropdown(),
            const SizedBox(height: 10),
            productDropdown(),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Choose product images',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) {
                  return productImages(label: '${index + 1}', onPress: () {});
                })),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('First image will be your thumbnail image',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 10),
            Wrap(
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
                              .make(),
                          Icon(Icons.done, color: Colors.white)
                        ],
                      )),
            )
          ],
        ),
      ),
    );
  }
}
