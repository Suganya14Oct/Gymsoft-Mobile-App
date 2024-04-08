import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:gymsoft/home_page/main_screen.dart';
import 'package:gymsoft/login/login.dart';
import 'package:gymsoft/login/splash_screen.dart';
import 'package:gymsoft/model/user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Api {


  var response;

  Map? responcebody;

  final strg = SharedPreferences.getInstance();

  var Token;

  Future<void> loginApi(String phone, password, BuildContext context) async  {

    try{
      response = await http. post(
          Uri.parse('https://achujozef.pythonanywhere.com/api/login/'),
          body:  {
            "username": phone,
            "password": password
          }
      );

      if(response.statusCode == 200){
        responcebody = json.decode(response.body);
        print("TOKEN : ${responcebody.toString()}");

        final prefs = await strg;
        await prefs.setString('accessToken', responcebody!["access"]);
        await prefs.setString('refreshToken', responcebody!["refresh"]);

        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(token: responcebody!["access"],)));

        var refresh = responcebody!["refresh"];
        print("Refresh Token : ${refresh}");

        var access = responcebody!["access"];
        print("Access Token : ${access}");

        print("Login successfully");
        print(response.statusCode);
      }
      else if(response.statusCode == 401){

        print(response.statusCode);

        // await refreshtoken();

          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              backgroundColor: Colors.white70,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))
              ),
              title: Text('Login Failed'),
              content: Text('Invalid usename or password. Please try again'),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('OK',
                  style: TextStyle(color: Colors.black,fontFamily: 'Telex',fontWeight: FontWeight.bold),))
              ],
            );
          });
      }

      print(phone);
      print(password);

    }catch(e){
      print(e.toString());
    }
  }



  Future<bool> refreshtoken() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refreshToken');

    print('in refreshToken function: $refreshToken');

    if(refreshToken != null){
      final responce = await http.post(Uri.parse('https://achujozef.pythonanywhere.com/api/token/refresh/'),
          body: {'refresh' : refreshToken});
      print('Inside refreshToken Function ${responce.statusCode}');
      if(responce.statusCode == 200){
        final responnsebody = json.decode(responce.body);
        print(responnsebody);
        Token = responnsebody['access'];
        print(Token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('accessToken', Token);
        return true;
      }else{
        print('failed');
        return false;
      }
    }
    return false;
  }


  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }


  Future<void> logout() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('accessToken');
      await prefs.remove('refreshToken');
    }catch (e){
      print('Error during logout: $e');
    }
  }

}

