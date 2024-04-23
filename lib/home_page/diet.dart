import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Diet extends StatefulWidget {
  const Diet({super.key});

  @override
  State<Diet> createState() => _DietState();
}

class _DietState extends State<Diet> {

  bool breakfast = false;
  bool lunch = false;
  bool dinner = false;

  var accessToken;

  var get_response;

  List? get_responcebody;

  var refresh_response;

  var Token;


  @override
  void initState() {
    setState(() {
      //_isMounted = true;
      print('fetchData() function called from iniState');
      fetchData();


    });
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      var data = await getApi();

      if (data != null && data.isNull && mounted) {
        setState(() {
          get_responcebody = data;
        });
      } else  {
        if(mounted){
          setState((){
            retryFetchData();
          });
        }
      }
    } catch (e) {
      print('Exception: $e');
      if(mounted){
        setState(() {
          retryFetchData();
        });
      }
    }
  }

  void retryFetchData() async {

    const retryDelay = Duration(seconds: 1);
    Timer(retryDelay, () {
      if(mounted){
        fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
          return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      height: height,
                      width: width,
                      color: Colors.black,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/male_background.jpeg"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                    Container(
                      height: height,
                      width: width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      print('Navigating');
                                      mainScreenNotifier.pageIndex = 0;
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      height: 10.0.h,
                                      width: 10.0.w,
                                      child: Icon(
                                        Icons.arrow_back_ios, color: Colors.white,
                                        size: 20.dp,)
                                  ),
                                ),
                                Text("Diet",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 3.6.h,
                                  width: 4.4.w,
                                  margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                  child: Image.asset("assets/name.png"),
                                ),
                                Flexible(
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 8.0,top: 8.0),
                                        child: Text("Shakthi Shree!!Today's Diet Plan for you",
                                          style: TextStyle(color: Colors.white,
                                              fontFamily: 'Telex',fontSize: 15.0.dp),),
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: width,
                                  margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                  child: Text('Recommended Breakfast',
                                      style: TextStyle(color: Colors.white,
                                          fontFamily: 'Telex',fontSize: 12.0.dp)
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 18.h,
                                      width: 80.w,
                                      margin: EdgeInsets.only(top: 12.0, right: 10.0,left: 13.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(
                                              color: Colors.white10
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 3.6.h,
                                                width: 4.4.w,
                                                margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                                child: Image.asset("assets/clock.png"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 8.0),
                                                child: Text("Time - 9 : 00 am",
                                                  style: TextStyle(color: Colors.white,
                                                      fontFamily: 'Telex',fontSize: 12.0.dp),),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 3.6.h,
                                                width: 4.4.w,
                                                margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                                child: Image.asset("assets/item.png"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 8.0),
                                                child: Text("Items : ",
                                                  style: TextStyle(color: Colors.white,
                                                      fontFamily: 'Telex',fontSize: 12.0.dp),),
                                              ),
                                              Container(
                                                height: 13.h,
                                                width: 50.w,
                                                child: Flex(
                                                  direction: Axis.vertical,
                                                  children: [
                                                    Flexible(
                                                      flex: 7,
                                                      child: Center(
                                                        child: FittedBox(
                                                          child: Text('Egg White(2),\nOats 200g',
                                                            style: TextStyle(color: Colors.white,
                                                                fontFamily: 'Telex',fontSize: 12.0.dp),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.3,
                                      child: Checkbox(
                                        checkColor: Colors.black,
                                        focusColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        side: BorderSide(
                                            color: Colors.white
                                        ),
                                        activeColor: Colors.white,
                                        value: breakfast,
                                        onChanged: (value){
                                          setState(() {
                                            breakfast = value!;
                                            //print(breakfast);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Container(
                                  width: width,
                                  margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                  child: Text('Recommended Lunch',
                                      style: TextStyle(color: Colors.white,
                                          fontFamily: 'Telex',fontSize: 12.0.dp)
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 18.h,
                                      width: 80.w,
                                      margin: EdgeInsets.only(top: 12.0, right: 10.0,left: 13.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(
                                              color: Colors.white10
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 3.6.h,
                                                width: 4.4.w,
                                                margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                                child: Image.asset("assets/clock.png"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 8.0),
                                                child: Text("Time - 1 : 00 pm",
                                                  style: TextStyle(color: Colors.white,
                                                      fontFamily: 'Telex',fontSize: 12.0.dp),),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 3.6.h,
                                                width: 4.4.w,
                                                margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                                child: Image.asset("assets/item.png"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 8.0),
                                                child: Text("Items : ",
                                                  style: TextStyle(color: Colors.white,
                                                      fontFamily: 'Telex',fontSize: 12.0.dp),),
                                              ),
                                              Container(
                                                height: 13.h,
                                                width: 50.w,
                                                child: Flex(
                                                  direction: Axis.vertical,
                                                  children: [
                                                    Flexible(
                                                      flex: 7,
                                                      child: Center(
                                                        child: FittedBox(
                                                          child: Text('Rice (2 Cups),\nFruit Juice 100 ml',
                                                            style: TextStyle(color: Colors.white,
                                                                fontFamily: 'Telex',fontSize: 12.0.dp),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.3,
                                      child: Checkbox(
                                        checkColor: Colors.black,
                                        focusColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        side: BorderSide(
                                            color: Colors.white
                                        ),
                                        activeColor: Colors.white,
                                        value: lunch,
                                        onChanged: (value){
                                          setState(() {
                                            lunch = value!;
                                            //print(lunch);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Container(
                                  width: width,
                                  margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                  child: Text('Recommended Dinner',
                                      style: TextStyle(color: Colors.white,
                                          fontFamily: 'Telex',fontSize: 12.0.dp)
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 18.h,
                                      width: 80.w,
                                      margin: EdgeInsets.only(top: 12.0, right: 10.0,left: 13.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(
                                              color: Colors.white10
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 3.6.h,
                                                width: 4.4.w,
                                                margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                                child: Image.asset("assets/clock.png"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 8.0),
                                                child: Text("Time - 8 : 00 pm",
                                                  style: TextStyle(color: Colors.white,
                                                      fontFamily: 'Telex',fontSize: 12.0.dp),),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 3.6.h,
                                                width: 4.4.w,
                                                margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                                child: Image.asset("assets/item.png"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 8.0),
                                                child: Text("Items : ",
                                                  style: TextStyle(color: Colors.white,
                                                      fontFamily: 'Telex',fontSize: 12.0.dp),),
                                              ),
                                              Container(
                                                height: 13.h,
                                                width: 50.w,
                                                child: Flex(
                                                  direction: Axis.vertical,
                                                  children: [
                                                    Flexible(
                                                      flex: 7,
                                                      child: Center(
                                                        child: FittedBox(
                                                          child: Text('Chappathi (2),\n Milk 100 ml',
                                                            style: TextStyle(color: Colors.white,
                                                                fontFamily: 'Telex',fontSize: 12.0.dp),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.3,
                                      child: Checkbox(
                                        checkColor: Colors.black,
                                        focusColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0)
                                        ),
                                        side: BorderSide(
                                            color: Colors.white
                                        ),
                                        activeColor: Colors.white,
                                        value: dinner,
                                        onChanged: (value){
                                          setState(() {
                                            dinner = value!;
                                            //print(dinner);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          );
        }
    );
  }

  Future<bool> refreshtoken() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refreshToken');

    //print('in refreshToken function: $refreshToken');

    if(refreshToken != null){
      refresh_response = await http.post(Uri.parse('https://achujozef.pythonanywhere.com/api/token/refresh/'),
          body: {'refresh' : refreshToken});
      print('Inside refreshToken Function ${refresh_response.statusCode}');
      if(refresh_response.statusCode == 200){
        final responnsebody = json.decode(refresh_response.body);
        print(responnsebody);
        Token = responnsebody['access'];
        print(Token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        accessToken = prefs.setString('accessToken', Token);
        return true;
      }else{
        print('failed');
        return false;
      }
    }
    return false;
  }

  getApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');

    try {

      if(accessToken != null){
        get_response = await http.get(
          Uri.parse('https://achujozef.pythonanywhere.com/api/gym-diets/'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        bool isTokenExpired = await JwtDecoder.isExpired(accessToken);
        print(isTokenExpired);

        // print('From getapi: ${accessToken}');
        print('From PlanApi: ${get_response.statusCode}');

        if (get_response.statusCode == 200) {

           get_responcebody = await json.decode(get_response.body);
         // print('Response: $get_responcebody');
          get_responcebody!.forEach((element) {
            Map obj = element;
            String name = obj['name'];
            List address = obj['days'];
            var street = address.toList();
            print(street);
          });
        }
        else if(isTokenExpired)  {
          refreshtoken();
          getApi();
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