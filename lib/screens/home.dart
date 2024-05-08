import 'package:flutter/material.dart';
import 'package:fluttor_app/config/config.dart';
import 'package:fluttor_app/utils/validator.dart';
import 'package:fluttor_app/widget/appbar.dart';
import 'package:fluttor_app/screens/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  //final ApiClient _apiClient = ApiClient();

  Future<void> checkLogin() async{
    var check = Validator.ischeckLogin();
    if(check == true){
      Navigator.push(
        context, MaterialPageRoute(
          builder: (context) => LoginScreen(),
        )
      );
    }
  }

  /*Future<Map<String, dynamic>> getUserData() async {
    dynamic userRes;
    userRes = await _apiClient.getUserProfileData(widget.accesstoken);
    return userRes;
  }*/

  /*Future<void> logout() async {
    await _apiClient.logout(widget.accesstoken);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }*/

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: null,
              tooltip: "Comment",
              icon: Icon(Icons.comment)
          ),
          IconButton(
            onPressed: (){

            },
            tooltip: 'Setting',
            icon:  Icon(Icons.settings,semanticLabel: 'settings',),
          )
        ],
        elevation: 50,
        title: Text(Config.appName),
        backgroundColor: Colors.greenAccent[400]
      ),
      drawer: Drawer(
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
                    Navigator.pop(context);
                  },
                ),
              ],
            )
        ),
      ),
      body: Center(child: Loader()),
    );
  }
}