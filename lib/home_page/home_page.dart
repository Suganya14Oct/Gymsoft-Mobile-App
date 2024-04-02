import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:gymsoft/equipments/equipments.dart';
import 'package:gymsoft/login/api.dart';
import 'package:gymsoft/login/login.dart';
import 'package:gymsoft/notification/notificat.dart';
import 'package:gymsoft/shared/bottom_nav_bar.dart';
import 'package:gymsoft/trainer/trainer.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {

  final token;

  const HomePage({@required this.token, super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  final Api _api = Api();

  bool _isMounted = false;

  var accessToken;

  var Token;

  var login_response;

  var refresh_response;

  var get_response;

  Map? login_responcebody;

  Map? refresh_responcebody;

  Map? get_responcebody;

  @override
  void initState() {
    setState(() {
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
  void dispose() {
    mounted;
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(66.0),
              child: AppBar(
                actions: [
                  Row(
                    children: [
                      InkWell(
                        child: Icon(Icons.notifications,color: Colors.white,
                          size: 29.dp,),
                        onTap: (){
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Notificat()));
                          });
                        },
                      ),
                      SizedBox(width: 3.w,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            _api.logout();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          height: 50.h,
                          width: 20.w,
                          //color: Colors.white70,
                          child: CircleAvatar(
                              child:  get_responcebody != null ? ClipOval(
                                    child:
                                Image.network('${get_responcebody!['profile_picture']}',fit: BoxFit.cover,)
                              ) : SizedBox(
                                height: 2.h,width: 4.w,
                                  child: CircularProgressIndicator(color: Colors.black12,)
                              )
                                  )
                          )
                        ),
                    ],
                  )
                ],
                toolbarHeight: 120,
                backgroundColor: Colors.black,
                automaticallyImplyLeading: false,
                leadingWidth: 55.w,
                leading: Container(
                  width: width * 0.5,
                  //color: Colors.white70,
                  padding: EdgeInsets.only(top: 16.0),
                  //margin: EdgeInsets.only(top: 10.0),
                  child: Image.asset("assets/gymsoftLogo.png",fit: BoxFit.cover,),
                ),
              ),
            ),
            body: Stack(
              children: [
                Container(
                  height: height.h,
                  width: width.w,
                  color: Colors.black,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/gym_female.jpg"),fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 25.h,
                        width: width.w,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0,left: 25.0,right: 10.0),
                              height: 50.h,
                              width: width * 0.08.w,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                border: Border.all(
                                  color: Colors.white24
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 3.7.h,
                                          width: 4.4.w,
                                          margin: EdgeInsets.only(top: 15.0,left: 10.0,right: 5.0),
                                          child: Image.asset("assets/finish.png"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 15.0),
                                          child: Text("Finished",style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 15.0.dp),),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 27.0),
                                      //child: Text('${get_responcebody!['days_since_joined']}', style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 32.0.dp))
                                      child: get_responcebody != null
                                          ? Text('${get_responcebody!['days_since_joined']}', style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 32.0.dp))
                                          : SizedBox(
                                            height: 2.h,width: 4.w,
                                          child: CircularProgressIndicator(color: Colors.white,))
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 23.0),
                                      child: Text('Completed\n      Days',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 11.h,
                                  width: width * 0.13.w,
                                  margin: EdgeInsets.only(top: 12.0, right: 10.0,left: 13.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      border: Border.all(
                                          color: Colors.white24
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 3.6.h,
                                              width: 4.4.w,
                                              margin: EdgeInsets.only(top: 7.0,left: 25.0,right: 5.0),
                                              child: Image.asset("assets/inprogress.png"),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0),
                                              child: Text("Current Weight",style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 15.0.dp),),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 50.0),
                                              child: get_responcebody != null
                                                  ? FittedBox(child: Text('${get_responcebody!['latest_weight']}', style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 28.0.dp)))
                                                  : SizedBox(
                                                  height: 2.h,width: 4.w,
                                                  child: CircularProgressIndicator(color: Colors.white,))
                                            ),
                                            // Padding(
                                            //   padding: EdgeInsets.only(left: 8.0),
                                            //   child: Text('workouts',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 11.0.dp),),
                                            // )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 10.h,
                                  width: width * 0.13.w,
                                  margin: EdgeInsets.only(top: 15.0, right: 10.0,left: 13.0),
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      border: Border.all(
                                          color: Colors.white24
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 3.7.h,
                                            width: 4.4.w,
                                            margin: EdgeInsets.only(top: 8.0,left: 35.0,right: 5.0),
                                            child: Image.asset("assets/check.png"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text("Your Progress",style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 11.0.dp),),
                                          )
                                        ],
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: FittedBox(
                                          //fit: BoxFit.fill,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 8.0,left: 8.0),
                                            child: get_responcebody != null
                                                ? Text('${get_responcebody!['user_goal']}', style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 28.0.dp))
                                                : SizedBox(
                                                height: 2.h,width: 4.w,
                                                child: CircularProgressIndicator(color: Colors.white,))
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        indent: 13.0.w,
                        endIndent: 5.0.h,
                        thickness: 0.1.h,
                      ),
                      Container(
                        height: 63.h,
                        width: width,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                  height: 15.h,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      border: Border.all(
                                          color: Colors.white24
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                                  ),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap : (){
                                          setState(() {
                                            print('s');
                                           // print(accessToken);
                                            // print(refreshtoken());
                                            getApi();
                                            print(get_responcebody!['latest_weight']);
                                            print(get_responcebody!['user_goal']);
                                          });
                                        },
                                        child: Container(
                                          height: 8.h,
                                          width: 19.w,
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: Image.asset("assets/diet.png"),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Text('Diet',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                      )
                                    ],
                                  )
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                    height: 15.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        border: Border.all(
                                            color: Colors.white24
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 8.h,
                                          width: 19.w,
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: Image.asset("assets/slot_booking.png"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text('Slot Booking',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                        )
                                      ],
                                    )
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap : (){
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Trainer()));
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                      height: 15.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(
                                              color: Colors.white24
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 8.h,
                                            width: 19.w,
                                            margin: EdgeInsets.only(top: 10.0),
                                            child: Image.asset("assets/trainer.png"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text('Trainer',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Equipments()));
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                      height: 15.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          border: Border.all(
                                              color: Colors.white24
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20.0))
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 8.h,
                                            width: 19.w,
                                            margin: EdgeInsets.only(top: 10.0),
                                            child: Image.asset("assets/gym_equipment.png"),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text('Equipments',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                          )
                                        ],
                                      )
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                    height: 15.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        border: Border.all(
                                            color: Colors.white24
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 8.h,
                                          width: 19.w,
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: Image.asset("assets/feedback.png"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text('Feedback',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                        )
                                      ],
                                    )
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 5.0.w,right: 20.0,left: 30.0),
                                    height: 15.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                        color: Colors.black54,
                                        border: Border.all(
                                            color: Colors.white24
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 8.h,
                                          width: 19.w,
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: Image.asset("assets/planning.png"),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0),
                                          child: Text('Plan',style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontSize: 10.0.dp),),
                                        )
                                      ],
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
          Uri.parse('https://achujozef.pythonanywhere.com/api/user-homescreen/'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        bool isTokenExpired = await JwtDecoder.isExpired(accessToken);
        print(isTokenExpired);

        // print('From getapi: ${accessToken}');
        print('From getapi: ${get_response.statusCode}');

        if (get_response.statusCode == 200) {
          get_responcebody = await json.decode(get_response.body);
          print('Response: $get_responcebody');
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
