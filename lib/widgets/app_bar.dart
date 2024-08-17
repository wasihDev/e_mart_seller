import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

AppBar appBarWidget(title) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(title),
    actions: [
      Text(intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now())),
      SizedBox(width: 5),
    ],
  );
}
