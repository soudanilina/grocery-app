import 'package:flutter/material.dart';

Color primaryColor = Color(0xff159D3B);
Color scaffoldBackgroundColor = Colors.white;
//Color textColor = Colors.black87;
Color textColor = Color(0xFF020100);

class Palette {
 static const Color iconColor = Color(0xFFD9D8D7);
 static const Color blackColor = Color(0xFF020100);
 static const Color textColor1 = Color(0xFF020100);
 static const Color textgreyColor = Color(0XFF949293);
 static const Color textColor2 = Color(0XFF656565);
 static const Color facebookColor = Color(0xFF3B5999);
 static const Color googleColor = Color(0xFFDE4B39);
 static const Color backgroundColor = Color(0xFFFFFFFF);
 static const Color greenColor = Color(0xFF159D3B);
} 

const InputDecoration  kinput = InputDecoration(
                        
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Palette.iconColor)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Palette.greenColor)
                        ),
                       // prefixIcon: Icon(icon, color: Palette.iconColor,),
                        //suffixIcon: isPassword ? Icon(FeatherIcons.eye,color: Palette.iconColor, size: 17,): null,
                        //hintText: hintText,
                        hintStyle: TextStyle(fontSize: 14, color: Palette.iconColor)
                      ); 