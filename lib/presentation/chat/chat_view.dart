import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_user/data/Repository/repository.dart';
import 'package:food_user/domain/logic/chat_bloc/chat_cubit.dart';
import 'package:food_user/domain/models/chat.dart';
import 'package:food_user/presentation/resources/color_manager.dart';
import 'package:food_user/presentation/resources/font_manager.dart';
import 'package:food_user/presentation/resources/string_manager.dart';
import 'package:food_user/presentation/resources/values_manager.dart';
import 'package:food_user/presentation/resources/widgets_manager.dart';

import '../../app/di.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _messageBodyController = TextEditingController();
  final _repository = instance<Repository>();
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            _ChatListSection(),
            _bottomSection(),
            Padding(
              padding: const EdgeInsets.all(AppSize.s12),
              child: topBarSection(AppStrings.chat, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ChatListSection() {
    return StreamBuilder(
      stream: _repository.getChatMessages(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
          final data = snapshot.data!.docs.reversed;
          final messages = data.map((message) => MessageDataModel.fromFireStore(message)).toList();
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: AppSize.s60, bottom: AppSize.s10),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(
                    left: AppSize.s14,
                    right: AppSize.s14,
                    top: AppSize.s10,
                    bottom: AppSize.s10),
                child: Align(
                  alignment: (messages[index].senderId != _uid
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      color: (messages[index].senderId != _uid
                          ? Colors.white
                          : AppColors.primary.withOpacity(.7)),
                    ),
                    padding: EdgeInsets.all(AppSize.s16),
                    child: Text(
                      messages[index].messageBody!,
                      style: TextStyle(
                          fontSize: AppFontSizes.f14,
                          color: messages[index].senderId == _uid
                              ? Colors.white
                              : AppColors.black),
                    ),
                  ),
                ),
              );
            },
          );
        }
        else{
          return Container();
        }

      },
    );
  }

  Widget _bottomSection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
            left: AppSize.s10, bottom: AppSize.s10, top: AppSize.s10),
        margin: EdgeInsets.only(
            left: AppSize.s10, right: AppSize.s10, bottom: AppSize.s10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s12),
          color: Colors.white,
        ),
        height: AppSize.s60,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                height: AppSize.s30,
                width: AppSize.s30,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: AppSize.s20,
                ),
              ),
            ),
            SizedBox(
              width: AppSize.s16,
            ),
            Expanded(
              child: TextField(
                controller: _messageBodyController,
                decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: AppSize.s16,
            ),
            FloatingActionButton(
              onPressed: () {
                ChatCubit.get(context).sendMessage(_messageBodyController.text);
                _messageBodyController.clear();
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: AppSize.s18,
              ),
              backgroundColor: AppColors.primary,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
