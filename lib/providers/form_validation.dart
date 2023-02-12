import 'package:flutter/material.dart';

class FormValidation with ChangeNotifier {

  String? _name ;
  String? _email ;
   String? _password ;
  String? _confirmpassword ;

  String? get password => _password;
  String? get email => _email;
  String? get name => _name; 
  String? get confrimPassword => _confirmpassword;


  
void  changeConfirmPassword(String confirmPass, String? password) {
      if(confirmPass != password || confirmPass.isEmpty) {
       _confirmpassword =  "Password must be matched";
      } else {
        _confirmpassword = null;
      }
       notifyListeners();
    }
  
void changeEmail(String value) {
    String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value.isEmpty) {
     _email =  "Email format is not valid";
    } else {
      _email = null;
    }
    notifyListeners();
    }

  void changePassword(String value) {
    if (value.length <= 5) {
     _password =  "password must be more than 6 ";
    } 
    else {
      _password = null;
    }
    notifyListeners();
  } 
  void changeName(String value) {
    if (value.length <= 5) {
     _name =  "username must be more than 6 ";
    } 
    else {
      _name = null;
    }
    notifyListeners();
  }
} 