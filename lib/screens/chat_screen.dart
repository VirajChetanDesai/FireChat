import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firechat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'welcome_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _auth = FirebaseAuth.instance;
  late String messagetext;
  final messageTextClearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> pickImage()async{
    ImagePicker _picker = ImagePicker();
    XFile? pickedFile;
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if(permissionStatus.isGranted){
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      var filepath = File(pickedFile!.path);
      String imageName = filepath.uri.path.split('/').last;
      print(imageName);
    }else{
      print('Permission Not Granted, please manually provide permission');
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.popAndPushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: const Center(child: Text('Chat')),
        backgroundColor: Colors.deepOrange,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextClearController,
                      style: const TextStyle(color: Colors.black),
                      onChanged: (value) {
                        messagetext = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        pickImage();
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.deepOrange,
                      ),
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                  ),
                  IconButton(
                    onPressed: () {
                      messageTextClearController.clear();
                      _firestore.collection('messages').add(
                        {
                          "text": messagetext,
                          "email": loggedInUser.email,
                          "time" : FieldValue.serverTimestamp(),
                          "name": loggedInUser.displayName,
                        },
                      );
                      //Implement send functionality.
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.deepOrange,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageList = [];
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.deepOrange,
            ),
          );
        }
        if (snapshot.hasData) {
          final messages = snapshot.data?.docs.reversed;
          for (var message in messages!) {
            MessageBubble bubble = MessageBubble(message,loggedInUser.email);
            messageList.add(bubble);
          }
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 20),
            children: messageList,
          ),
        );
      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  QueryDocumentSnapshot<Object?> message;
  String? loggedInUser;
  MessageBubble(this.message, this.loggedInUser ,{super.key});
  @override
  Widget build(BuildContext context) {
    String text = message['text'];
    String email = message['email'];
    String displayname = message['name'];
    CrossAxisAlignment axisAlignment = (email == loggedInUser)? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Color bubble = (email == loggedInUser)? Colors.deepOrange : Colors.white;
    Radius topLeft = (email == loggedInUser)? Radius.circular(30):Radius.zero;
    Radius topRight = (email == loggedInUser)? Radius.zero :Radius.circular(30);
    Color textColor = (email == loggedInUser)? Colors.white : Colors.deepOrange;
    return Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: axisAlignment,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
              child: Text('$displayname',style: TextStyle(color: Colors.black54,fontSize: 10),),
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.only(topLeft: topLeft,topRight: topRight,bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
              color: bubble,
              child: Padding(
                padding:EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Text(
                  "$text",
                  style: TextStyle(color: textColor,fontSize: 14),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
