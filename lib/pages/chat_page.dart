import 'package:chat/pages/chat_widget.dart';
import 'package:chat/pages/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:tflite_audio/tflite_audio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat with TFLite Model',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
            style: IconButton.styleFrom(foregroundColor: Colors.black),
          ),
        ),
        title: const Center(
            child: Text(
          'AI Helper',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        backgroundColor: Colors.indigo,
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthServices.signoutUser(context);
            },
            icon: const Icon(Icons.logout_sharp),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.deepPurple])),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: const ChatWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
