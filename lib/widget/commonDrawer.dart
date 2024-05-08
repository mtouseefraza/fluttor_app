import 'package:flutter/material.dart';
import 'package:fluttor_app/screens/login.dart';
class CommonDrawer extends StatefulWidget {
  const CommonDrawer({Key? key}) : super(key: key);

  @override
  State<CommonDrawer> createState() => _CommonDrawer();
}

class _CommonDrawer extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
     return  Drawer(
       child: (
           ListView(
             padding: EdgeInsets.all(0),
             children: [
               DrawerHeader(
                 decoration: BoxDecoration(
                   color:Colors.green,
                 ),
                 child: UserAccountsDrawerHeader(
                   decoration: BoxDecoration(color: Colors.green),
                   margin: EdgeInsets.all(0),
                   accountName: Text(
                     "Abhishek Mishra",
                     style: TextStyle(fontSize: 16),
                   ),
                   accountEmail: Text("abhishekm977@gmail.com"),
                   currentAccountPictureSize: Size.square(50),
                   currentAccountPicture: CircleAvatar(
                     backgroundColor: Color.fromRGBO(255, 165, 255, 137),
                     child: Text('A',style: TextStyle(fontSize: 25,color: Colors.blue)),
                   ),
                 ),
               ),
               ListTile(
                 title: Text('Home'),
                 leading: Icon(Icons.home),
                 onTap: (){
                   Navigator.pop(context);
                 },
               ),
               ListTile(
                 title: Text('Mail'),
                 leading: Icon(Icons.mail),
                 onTap: (){
                   Navigator.pop(context);
                 },
               ),
               ListTile(
                 leading: const Icon(Icons.logout),
                 title: const Text('LogOut'),
                 onTap: () {
                   Navigator.pushReplacement(
                       context, MaterialPageRoute(
                           builder: (context) => const LoginScreen()
                       )
                   );
                 },
               ),
             ],
           )
       ),
     );
  }
}
