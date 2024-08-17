import 'package:e_mart_seller/const/colors.dart';
import 'package:e_mart_seller/views/messages_screen/component/chat_bubble.dart';

import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'chats',
          style: TextStyle(color: darkGrey),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: ListView(children: [senderBubble(purpleColor)])),
              Container(
                height: 80,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      // controller: controller.msgController,
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
                          // controller
                          //     .sendMsg(controller.msgController.text);
                          // // controller.chatDocId;
                          // log('docID ${controller.chatDocId.value}');
                          // });
                        },
                        icon: const Icon(Icons.send))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
