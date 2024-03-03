import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(255, 0, 53, 80),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Column 1'),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color.fromARGB(255, 45, 48, 255),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.green,
                  ),
                  Container(
                    width: 100,
                    color: Colors.blue,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.yellow,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
