import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/const/styles.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title:
              '${data["p_name"]}'.text.color(darkGrey).fontFamily(bold).make(),
        ),
        body: Column(children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        VxSwiper.builder(
                            autoPlay: true,
                            height: 350,
                            itemCount: data['p_image'].length,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1.0,
                            itemBuilder: (context, index) {
                              return Image.network(
                                data['p_image'][index],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              );
                            }),
                        10.heightBox,
                        '${data['p_name']}'
                            .text
                            .size(16)
                            .color(darkGrey)
                            .bold
                            .fontFamily(semibold)
                            .make(),
                        10.heightBox,
                        Row(
                          children: [
                            'Category'
                                .text
                                .size(16)
                                .color(darkGrey)
                                .bold
                                .fontFamily(bold)
                                .make(),
                            const SizedBox(width: 10),
                            '${data['p_category']}'
                                .text
                                .size(16)
                                .color(darkGrey)
                                .fontFamily(semibold)
                                .make(),
                          ],
                        ),
                        10.heightBox,
                        VxRating(
                          onRatingUpdate: (val) {},
                          value: double.parse(data['p_rating'].toString()),
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          size: 25,
                          isSelectable: false,
                          maxRating: 5,
                        ),
                        10.heightBox,
                        "\$${data['p_price']}"
                            .text
                            .color(red)
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        10.heightBox,
                        SizedBox(
                          child: "Descrption:   "
                              .text
                              .color(Colors.black)
                              .bold
                              .make(),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text('${data['p_desc']}'))
                          ],
                        ).box.padding(const EdgeInsets.all(2)).make(),
                        10.heightBox,
                        Column(children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(
                                child:
                                    "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                  data['p_colors'].length,
                                  (index) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Color(int.parse(
                                              data['p_colors'][index])))
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .make()
                                          .onTap(() {}),
                                      const Visibility(
                                        visible: true,
                                        child: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              "Quantity:".text.color(Colors.black).bold.make(),
                              const SizedBox(width: 8),
                              "(${data['p_quantity']} available)"
                                  .text
                                  .color(textfieldGrey)
                                  .make(),
                            ],
                          ).box.make(),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     "Total:   ".text.color(Colors.black).make(),
                          //     const Text(
                          //       '\$100',
                          //       style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.red),
                          //     )
                          //   ],
                          // ).box.padding(const EdgeInsets.all(8)).make(),
                        ])
                      ])))),
        ]));
  }
}
