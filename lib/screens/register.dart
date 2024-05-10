import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fluttor_app/services/api_client.dart';
import 'package:fluttor_app/utils/validator.dart';
import 'package:fluttor_app/screens/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key?key}) : super(key:key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm_password = TextEditingController();
  final ApiClient _apiClient = ApiClient();

  bool _showPassword = false;


  Future<void> registration() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));

      Map data = {};
      data['Status'] = 1;
      data['Email'] = email.text;
      data['Password'] = password.text;
      data['Mobile'] = mobile.text;
      data['Name'] = name.text;
      dynamic res = await _apiClient.registration(data);
      print(res);
      if (res['status'] == 1 && res['data']!=null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res['message']),
          backgroundColor: Colors.green.shade300,
        ));

        Navigator.push(
            context, MaterialPageRoute(
          builder: (context) => LoginScreen(),
        )
        );
      }else{
         if(res['error'].isNotEmpty && res['error'].containsKey('Email')){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(res['error']['Email']),
            backgroundColor: Colors.red.shade300,
          ));
        }else if(res['error'].isNotEmpty && res['error'].containsKey('Mobile')){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(res['error']['Mobile']),
            backgroundColor: Colors.red.shade300,
          ));
        }else if(res['message'].isNotEmpty) {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             content: Text(res['message']),
             backgroundColor: Colors.red.shade300,
           ));
         }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                                  'Registration',
                                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue),
                                ),
                              ),
                              SizedBox(height: size.height * 0.06),
                              TextFormField(
                                controller: name,
                                validator:(value) {
                                  return Validator.validateName(value ?? "");
                                },
                                decoration: InputDecoration(
                                    hintText: "Name",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    suffixIcon: GestureDetector(
                                        child: Icon(Icons.person,color:Colors.grey)
                                    )
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              TextFormField(
                                controller:mobile,
                                keyboardType: TextInputType.number,
                                validator:(value) {
                                  return Validator.validateMobile(value ?? "");
                                },
                                decoration: InputDecoration(
                                    hintText: "Mobile",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    suffixIcon: GestureDetector(
                                        child: Icon(Icons.phone,color:Colors.grey)
                                    )
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
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
                                    suffixIcon: GestureDetector(
                                        child: Icon(Icons.email,color:Colors.grey)
                                    )
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
                              SizedBox(height: size.height * 0.03),
                              TextFormField(
                                  controller: confirm_password,
                                  validator:(value) {
                                    return Validator.validateConfirmPassword(value ?? "",password.text ?? "");
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      child: Icon(Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    hintText: "Confirm Password",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                        onPressed: registration,
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:Colors.indigo,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            padding: EdgeInsets.symmetric(horizontal: 40,vertical:15)
                                        ),
                                        child: Text(
                                          'Registration',
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget> [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(fontSize: 14,color: Colors.blueGrey,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
                                    ),
                                    onPressed: (){
                                      Navigator.push(
                                          context, MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      )
                                      );
                                    },
                                    child: const Text('Login Now'),
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

