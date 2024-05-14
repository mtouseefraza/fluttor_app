import 'package:flutter/material.dart';
import 'package:fluttor_app/config/config.dart';
import 'package:fluttor_app/utils/validator.dart';
import 'package:fluttor_app/screens/login.dart';

class CommonAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;
  State<CommonAppBar> createState() => _CommonAppBarState();
}
class _CommonAppBarState extends State<CommonAppBar> {

  Future<void> checkLogin() async{
    var check = await Validator.ischeckLogin();
    if(check == false){
      Navigator.push(
          context, MaterialPageRoute(
        builder: (context) => LoginScreen(),
      )
      );
    }
  }

  void initState() {
    super.initState();
    checkLogin();
  }


  @override
  Widget build(BuildContext context) {
     return  AppBar(
        title: Text(Config.appName, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold
        ),),
        backgroundColor: Color(0xFF4CAF50),
        //centerTitle: true,
        actions: [
           IconButton(
               onPressed: null,
               tooltip: "Comment",
               icon: Icon(Icons.comment,semanticLabel:'Comment')
           ),
           IconButton(
             onPressed: (){

             },
             tooltip: 'Setting',
             icon:  Icon(Icons.settings,semanticLabel: 'settings'),
           )
        ],
     );
  }
}
