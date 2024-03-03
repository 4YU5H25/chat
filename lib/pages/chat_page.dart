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
  TextEditingController message = TextEditingController();
  ScrollController _scrollController = ScrollController();

  String _text = '';
  static ChatUser user = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );
  static ChatUser model = ChatUser(
    id: '2',
    firstName: 'AI',
    lastName: 'Helper',
  );

  List<ChatMessage> messages = <ChatMessage>[
    ChatMessage(
      text: 'Hey!',
      user: user,
      createdAt: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    audio_permission();
  }

  Future<void> audio_permission() async {
    await Permission.audio.request();
    await Permission.manageExternalStorage.request();
    await Permission.microphone.request();
    await Permission.accessMediaLocation.request();
  }

  void _sendMessage(String text, bool isAudio) async {
    if (text.trim().isNotEmpty || !isAudio) {
      // Pass input to TFLite model

      // Add message to chat UI
      setState(() {
        messages.add(ChatMessage(
          text: text,
          user: user,
          createdAt: DateTime.now(),
        ));
      });
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                child: DashChat(
                  onSend: (ChatMessage message) {
                    _sendMessage(message.text, false);
                  },
                  messages: messages,
                  inputOptions: InputOptions(
                    textController: message,
                    autocorrect: true,
                    inputDecoration: InputDecoration(
                        border: InputBorder.none, // Assuming you want no border

                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                            borderSide:
                                const BorderSide(color: Colors.transparent))),
                    sendOnEnter: true,
                    alwaysShowSend: true,
                    sendButtonBuilder: (send) {
                      return Container(
                        decoration: const BoxDecoration(
                          color:
                              Colors.transparent, // Set your desired color here
                          shape:
                              BoxShape.circle, // Or any other shape you prefer
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.mic),
                              splashColor: Colors.grey,
                              style: IconButton.styleFrom(
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                // Add your logic to start recording audio here
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.send_outlined),
                              color:
                                  Colors.white, // Adjust icon color if needed
                              onPressed: () => _sendMessage(message.text,
                                  false), // Replace with your send logic
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  typingUsers: [model],
                  currentUser: user,
                  messageOptions: MessageOptions(
                    messageDecorationBuilder:
                        (message, previousMessage, nextMessage) {
                      if (message.user == user) {
                        return BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Colors.pink, Colors.purple]),
                            borderRadius: BorderRadius.circular(20));
                      } else {
                        return BoxDecoration(
                          // Default style for received messages
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TfliteAudio.stopAudioRecognition();
    super.dispose();
  }
}
