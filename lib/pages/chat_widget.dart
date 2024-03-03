import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

TextEditingController message = TextEditingController();
ScrollController _scrollController = ScrollController();

Future<dynamic> makePostRequest(String text) async {
  var url = Uri.parse('https://127.0.0.1:8000/chat');

  // This is an example JSON body. Replace it with your actual request body.
  var body = {"message": text};
  final jsonbody = jsonEncode(body);

  try {
    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonbody, // Encode your body to JSON format
    );

    if (response.statusCode == 200) {
      print('POST request successful');
      print('Response: ${response.body}');
    } else {
      print('POST request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('POST request failed: $e');
  }
}

String _text = '';
ChatUser user = ChatUser(
  id: '1',
  firstName: 'Charles',
  lastName: 'Leclerc',
);
ChatUser model = ChatUser(
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

// Future<void> audio_permission() async {
//   await Permission.microphone.request();
//   // await Permission.audio.request();
//   // await Permission.manageExternalStorage.request();
//   // await Permission.accessMediaLocation.request();
// }

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  void _sendMessage(String? text, bool isAudio) async {
    if (text!.trim().isNotEmpty || !isAudio || text != null) {
      // Pass input to TFLite model

      // Add message to chat UI

      setState(() {
        messages.insert(
            0,
            ChatMessage(
              text: text,
              user: user,
              createdAt: DateTime.now(),
            ));
      });
      await makePostRequest(text);
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } else {
      print("no message");
    }
  }

  @override
  void initState() {
    super.initState();
    // audio_permission();
  }

  @override
  Widget build(BuildContext context) {
    return DashChat(
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
                borderSide: const BorderSide(color: Colors.transparent))),
        sendOnEnter: true,
        alwaysShowSend: true,
        sendButtonBuilder: (send) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.transparent, // Set your desired color here
              shape: BoxShape.circle, // Or any other shape you prefer
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
                  color: Colors.white, // Adjust icon color if needed
                  onPressed: () => _sendMessage(
                      message.text, false), // Replace with your send logic
                ),
              ],
            ),
          );
        },
      ),
      typingUsers: [model],
      currentUser: user,
      messageOptions: MessageOptions(
        onPressMessage: (p0) {
          return Container(
            height: 16,
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.transparent)),
            child: Text(p0.createdAt.toString()),
          );
        },
        messageDecorationBuilder: (message, previousMessage, nextMessage) {
          if (message.user == user) {
            return BoxDecoration(
                gradient:
                    const LinearGradient(colors: [Colors.pink, Colors.purple]),
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
    );
  }
}
