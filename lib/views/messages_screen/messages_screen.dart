import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/const/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                      itemCount: 10,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 5),
                      itemBuilder: (context, index) {
                        // var itemData = snapshot.data!.docs[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Get.to(() => const ChatScreen());
                              // arguments: [
                              //   itemData['friend_name'].toString(),
                              //   itemData['toId'].toString(),
                              // ]);
                            },
                            title: const Text(
                              'username',
                              style: TextStyle(
                                  color: darkGrey, fontFamily: (semibold)),
                            ),
                            subtitle: Text(
                              'last message',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                  fontFamily: (semibold)),
                            ),
                            leading: const CircleAvatar(
                                backgroundColor: red,
                                child: Icon(
                                  Icons.person,
                                  color: white,
                                )),
                            trailing: Text('11:40 Pm'),
                          ),
                        );
                      }))
            ],
          )),
    );
  }
}
