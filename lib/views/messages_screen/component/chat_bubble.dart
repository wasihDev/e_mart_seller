import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/const/styles.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data, color) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Container(
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20))),
    child: Column(
      children: [
        Text(
          data['msg'],
          style: TextStyle(
            color: white,
            fontSize: 16,
            fontFamily: (semibold),
          ),
        ),
        10.heightBox,
        Text(
          time,
          style: TextStyle(color: white),
        ),
      ],
    ),
  );
}
