//import 'dart:ui';
import 'dart:core';
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttor_app/services/api_client.dart';
import 'package:fluttor_app/utils/validator.dart';
import 'package:fluttor_app/screens/home.dart';
import 'package:fluttor_app/screens/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key?key}) : super(key:key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final ApiClient _apiClient = ApiClient();

  bool _showPassword = false;
  bool _isRembemerMe = false;


  Future<void> _loadLoginInfo() async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isRembemerMe =  prefs.getBool('_isRembemerMe') ?? false;
      if (_isRembemerMe) {
        email.text = prefs.getString('email') ?? '';
        password.text = prefs.getString('password') ?? '';
      }
    });
  }


  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('_isRembemerMe', _isRembemerMe);
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      dynamic res = await _apiClient.login(
        email.text, password.text
      );

      if (res['status'] == 1 && res['data']!=null) {
        await prefs.setString('user', json.encode(res['data']));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res['message']),
          backgroundColor: Colors.green.shade300,
        ));
        if (_isRembemerMe) {
          await prefs.setString('email', email.text);
          await prefs.setString('password', password.text);
        }
        Navigator.push(
            context, MaterialPageRoute(
              builder: (context) => HomeScreen(),
            )
        );
      }else{
        if(res['message'].isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(res['message']),
            backgroundColor: Colors.red.shade300,
          ));
        }
      }
    }
  }

  static Future<bool> getisRembemerMe() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.getBool('_isRembemerMe') ?? false;
    return value;
  }

  @override
  void initState() {
    super.initState();
    _loadLoginInfo();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(_isRembemerMe);
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width * 0.85,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: SingleChildScrollView(
                    child:   Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue),
                            ),
                          ),
                          SizedBox(height: size.height * 0.06),
                          TextFormField(
                            controller: email,
                            validator:(value) {
                              return Validator.validateEmail(value ?? "");
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)
                              ),

                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          TextFormField(
                              controller: password,
                              validator:(value) {
                                return Validator.validatePassword(value ?? "");
                              },
                              obscureText: _showPassword,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: Icon(
                                    _showPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: "Password",
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                          ),
                          CheckboxListTile(
                            checkColor: Theme.of(context).primaryColor,
                            activeColor: Colors.red,
                            value: _isRembemerMe,
                            onChanged: (bool? value) {
                              if(value != null) {
                                setState(() {
                                  _isRembemerMe = value;
                                });
                              }
                            },
                            //value: _isRembemerMe,
                            title: Text(
                              "Remember me",
                              style: TextStyle(color: Colors.red),
                            ), controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.only(left: 0, top: 0),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: ElevatedButton(
                                    onPressed: login,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:Colors.indigo,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 40,vertical:15)
                                    ),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget> [
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 14,color: Colors.blue,fontWeight: FontWeight.bold),
                                ),
                                onPressed: null,
                                child: const Text('Forgot Password?'),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 14,color: Colors.blueGrey,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                                ),
                                onPressed: (){
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                          builder: (context) => RegistrationScreen(),
                                    )
                                  );
                                },
                                child: const Text('Registration Now'),
                              ),
                            ],
                          ),
                        ],
                      )
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}

