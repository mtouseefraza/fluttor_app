import 'package:flutter/material.dart';
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;

  @override
  Widget build(BuildContext context) {
     return  AppBar(
        title: Text('GeeksforGeeks'),
        backgroundColor: Color(0xFF4CAF50),
        centerTitle: true,
     );
  }
}
