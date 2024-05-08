import 'package:flutter/material.dart';
import 'package:fluttor_app/config/config.dart';
import 'package:fluttor_app/utils/validator.dart';
import 'package:fluttor_app/widget/commonAppBar.dart';
import 'package:fluttor_app/widget/commonDrawer.dart';
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
      appBar:  CommonAppBar(),
      drawer: CommonDrawer(),
      //body: Center(child: Loader()),
    );
  }
}