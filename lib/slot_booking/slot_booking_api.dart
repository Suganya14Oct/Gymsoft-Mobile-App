import 'package:gymsoft/login/api.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class SlotApi{

  final Api _api = Api();

  var accessToken;

  var get_response;

  var get_responcebody;

  var Token;

  getApi_booking() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');

    try {

      if(accessToken != null){
        get_response = await http.get(
          Uri.parse('https://achujozef.pythonanywhere.com/api/my-bookings/'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        bool isTokenExpired = await JwtDecoder.isExpired(accessToken);
        print(isTokenExpired);

        print('From getapi: ${accessToken}');
        print('From SlotGetApi_booking: ${get_response.statusCode}');

        if (get_response.statusCode == 200) {
          get_responcebody = await json.decode(get_response.body);
          print('Response: $get_responcebody');
        }
        else if(isTokenExpired)  {
          _api.refreshtoken();
          // refreshtoken();
          getApi_booking();
          print(accessToken);
          print('Error: ${get_response.statusCode}');
        }
      }
    } catch (e) {
      // Handle exceptions or network errors
      print('Exception: $e');
    }
  }
}