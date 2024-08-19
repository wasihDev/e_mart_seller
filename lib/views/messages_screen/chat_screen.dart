import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/const/const.dart';
import 'package:e_mart_seller/const/firebase_const.dart';
import 'package:e_mart_seller/controller/chat_controller.dart';
import 'package:e_mart_seller/services/store_services.dart';
import 'package:e_mart_seller/views/messages_screen/component/chat_bubble.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'chats',
          style: TextStyle(color: darkGrey),
        ),
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.chatDocId.value.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: StreamBuilder(
                                stream: StoreServices.getChats(
                                    controller.chatDocId.value.toString()),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return const Center(
                                      child: Text('Send a message....'),
                                    );
                                  } else {
                                    return ListView(
                                      children: snapshot.data!.docs
                                          .mapIndexed((currentValue, index) {
                                        var itemdata =
                                            snapshot.data!.docs[index];
                                        return Align(
                                            alignment: itemdata['uid'] ==
                                                    currentUser!.uid
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: senderBubble(
                                                itemdata,
                                                itemdata['uid'] ==
                                                        currentUser!.uid
                                                    ? red
                                                    : Colors.black));
                                      }).toList(),
                                    );
                                  }
                                })),
                        Container(
                          height: 80,
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextFormField(
                                controller: controller.msgController,
                                decoration: const InputDecoration(
                                  hintText: "Type Message here",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: textfieldGrey,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: textfieldGrey,
                                    ),
                                  ),
                                ),
                              )),
                              IconButton(
                                  onPressed: () {
                                    // setState(() {
                                    controller
                                        .sendMsg(controller.msgController.text);
                                    // controller.chatDocId;
                                    // log('docID ${controller.chatDocId.value}');
                                    // });
                                  },
                                  icon: const Icon(Icons.send))
                            ],
                          ),
                        )
                      ],
                    ));
      }),
    );
  }
}
