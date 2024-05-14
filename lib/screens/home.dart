import 'package:flutter/material.dart';
import 'package:fluttor_app/widget/commonAppBar.dart';
import 'package:fluttor_app/widget/commonDrawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  int count  =0;
  //final ApiClient _apiClient = ApiClient();

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
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  CommonAppBar(),
      drawer: CommonDrawer(),
      body: RefreshIndicator(
          onRefresh: () => Future.sync(
            // Refresh through page controllers
                () => setState(() {
                  count = count + 1;
                })
          ),
          child:SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: Center(
                child: Text('Hello World ${count}'),
              ),
              height: MediaQuery.of(context).size.height,
            ),
          ),
      ),
    );
  }
}