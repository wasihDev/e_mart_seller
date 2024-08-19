import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/const/styles.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Messages",
          style:
              TextStyle(color: darkGrey, fontFamily: (semibold), fontSize: 18),
        ),
      ),
      body: StreamBuilder(
          stream: StoreServices.getMessages(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.red));
            } else {
              var itemData = snapshot.data!.docs;
              return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                              itemCount: itemData.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 5),
                              itemBuilder: (context, index) {
                                var t = itemData[index]['created_on'] == null
                                    ? DateTime.now()
                                    : itemData[index]['created_on'].toDate();
                                var time = intl.DateFormat("h:mma").format(t);
                                // var itemData = snapshot.data!.docs[index];

                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      // print(
                                      //     'toID ${itemData[index]['fromId'].toString()}');
                                      Get.to(() => const ChatScreen(),
                                          arguments: [
                                            itemData[index]['sender_name']
                                                .toString(),
                                            itemData[index]['fromId']
                                                .toString(),
                                          ]);
                                    },
                                    title: Text(
                                      itemData[index]['sender_name'].toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      itemData[index]['last_msg'],
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    leading: const CircleAvatar(
                                        backgroundColor: red,
                                        child: Icon(
                                          Icons.person,
                                          color: white,
                                        )),
                                    trailing: Text(time),
                                  ),
                                );
                              }))
                    ],
                  ));
            }
          }),
    );
  }
}
