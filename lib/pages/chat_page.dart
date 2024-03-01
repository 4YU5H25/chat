import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:permission_handler/permission_handler.dart';
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
    await Permission.audio;
    await Permission.manageExternalStorage;
    await Permission.microphone;
    await Permission.accessMediaLocation;
  }

  void _sendMessage(String text, bool isAudio) async {
    if (text.trim().isNotEmpty || !isAudio) {
      // Pass input to TFLite model
      // var output = await TfliteAudio. runModelOnText(
      //   text: text,
      // );
      // Do something with output
      // print(output);

      // Add message to chat UI
      setState(() {
        messages.add(ChatMessage(
          text: text,
          user: user,
          createdAt: DateTime.now(),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with TFLite Model'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
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
