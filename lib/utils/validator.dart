import 'dart:convert';
import 'package:fluttor_app/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Validator {
  static String? validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex =  RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '* Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validateDropDefaultData(value) {
    if (value == null) {
      return '* Please select an item.';
    } else {
      return null;
    }
  }

  static String? validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex =  RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '* Password must be at least 6 characters.';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String value,String value2) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex =  RegExp(pattern as String);
    if (!regex.hasMatch(value)) {
      return '* Password must be at least 6 characters.';
    }else if(value != value2){
      return '* Confirmation password do not match.';
    } else {
      return null;
    }
  }

  static String? validateMobile(String value) {
    // Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  static String? validateName(String value) {
    if (value.length < 3) {
      return '* Username is too short.';
    } else {
      return null;
    }
  }

  static String? validateText(String value) {
    if (value.isEmpty) {
      return '* Text is too short.';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String value) {
    if (value.length != 11) {
      return '* Phone number is not valid.';
    } else {
      return null;
    }
  }
  static Future<bool> ischeckLogin() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic user = prefs.getString('user');
    final userTimestamp = prefs.getString('user_timestamp');
    if (user != null && userTimestamp != null) {
      final timestamp = DateTime.parse(userTimestamp);
      final currentTime = DateTime.now();
      final sessionDuration = currentTime.difference(timestamp);
      const Duration UserExpirationDuration = Duration(minutes: Config.session_time);
      user = json.decode(user);
      if (sessionDuration <= UserExpirationDuration && user.containsKey('token')) {
        return true;
      }else{
        await prefs.remove('user');
      }
    }
    return false;
  }

  static Future<Map> loginUserData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic user = prefs.getString('user') ?? '{}';
    user = json.decode(user);
    return user;
  }

}