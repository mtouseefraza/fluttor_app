import 'package:flutter/material.dart';
class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
     return  AppBar(
        title: Text('GeeksforGeeks'),
        backgroundColor: Color(0xFF4CAF50),
        centerTitle: true,
     );
  }
}
