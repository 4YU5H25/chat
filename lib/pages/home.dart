import 'package:chat/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:chat/pages/firebase_auth_service.dart';

class Home extends StatefulWidget {
  Home(this.mail);
  String mail = '';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var W = MediaQuery.of(context).size.width;
    var H = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            AuthServices.signoutUser(context);
          },
          icon: const Icon(Icons.logout_sharp),
        ),
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 9, 171),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.jpg'), fit: BoxFit.fitWidth),
        ),
        height: H,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.transparent,
                ),
                color: const Color.fromARGB(
                    96, 96, 125, 139), // Suitable color for the first column
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white,
                  ),
                  Text(
                    "Email: ${widget.mail}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: H,
              width: 4.5 * W / 6,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: H / 5,
                          width: W / 5,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(85, 0, 170, 255),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                              child: Text(
                            "Go to Chatbot",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ChatPage()),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
