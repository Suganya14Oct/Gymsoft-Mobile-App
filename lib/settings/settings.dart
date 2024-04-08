import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:gymsoft/home_page/main_screen.dart';
import 'package:gymsoft/login/api.dart';
import 'package:gymsoft/login/login.dart';
import 'package:gymsoft/profile/edit_profile.dart';
import 'package:gymsoft/settings/about_us.dart';
import 'package:gymsoft/settings/change_password.dart';
import 'package:gymsoft/settings/privacy_policy.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {

  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final Api _api = Api();

  var accessToken;

  var get_response;

  var get_responcebody;

  var refresh_response;

  var Token;

  late List<dynamic> apiData;

  double minValue = 0.0;
  double maxValue = 100.0;

  double? currentWeight;
  double? initialWeight;

  @override
  void initState() {
    setState(() {
      // _isMounted = true;
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
        setState(() {
          if(mounted){
            retryFetchData();
          }

        });
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
        builder: (context, mainScreenNotifier, child){
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  print('Navigating');
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                                  mainScreenNotifier.pageIndex = 0;
                                });
                              },
                              child:  Container(
                                  alignment: Alignment.centerRight,
                                  height: 10.0.h,
                                  width: 10.0.w,
                                  child: Icon(
                                    Icons.arrow_back_ios, color: Colors.white,
                                    size: 20.dp,)
                              ),
                            ),
                            Text("Settings",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                          ],
                        ),
                        SizedBox(
                          height: 12.5.h,
                        ),
                        Container(
                          height: 6.h,
                          width: width,
                         // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                height: 4.h,
                                width: 20.w,
                                //color: Colors.black45,
                                child: Image.asset('assets/edit_profile.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                               // color: Colors.black,
                                child: Text('Edit Profile',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(apiData: apiData)));
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                        Container(
                          height: 6.h,
                          width: width,
                          // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black45,
                                  child: Image.asset('assets/change_password.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                                // color: Colors.black,
                                child: Text('Change Password',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword()));
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                        Container(
                          height: 6.h,
                          width: width,
                          // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black45,
                                  child: Image.asset('assets/logout.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                                // color: Colors.black,
                                child: Text('Log Out',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(32.0))
                                        ),
                                        title: Center(
                                          child: Text('Log Out?', style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Telex',
                                              //fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                        content: Text('Are you sure you want to Log Out?',style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Telex',
                                          //fontWeight: FontWeight.bold
                                        ),),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                 height: 6.h,
                                                width: 25.w,
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xffd41012)), // Set the background color here
                                                    ),
                                                    onPressed: (){
                                                  Navigator.pop(context);
                                                }, child: Text('Cancel',
                                                  style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontWeight: FontWeight.bold),)),
                                              ),
                                              Container(
                                                height: 6.h,
                                                width: 25.w,
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white70), // Set the background color here
                                                    ),
                                                    onPressed: (){
                                                      setState(() {
                                                        _api.logout();
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                                      });
                                                    }, child: Text('Log Out',
                                                  style: TextStyle(color: Colors.black,fontFamily: 'Telex',
                                                     // fontWeight: FontWeight.bold
                                                  ),)),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                        Container(
                          height: 6.h,
                          width: width,
                          // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black45,
                                  child: Image.asset('assets/delete_accnt.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                                // color: Colors.black,
                                child: Text('Delete Account',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        backgroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(32.0))
                                        ),
                                        title: Center(
                                          child: Text('Delete?', style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Telex',
                                            //fontWeight: FontWeight.bold
                                          ),),
                                        ),
                                        content: Text('Are you sure you want to Delete?',style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Telex',
                                          //fontWeight: FontWeight.bold
                                        ),),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 6.h,
                                                width: 25.w,
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xffd41012)), // Set the background color here
                                                    ),
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    }, child: Text('Cancel',
                                                  style: TextStyle(color: Colors.white,fontFamily: 'Telex',fontWeight: FontWeight.bold),)),
                                              ),
                                              Container(
                                                height: 6.h,
                                                width: 25.w,
                                                child: TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white70), // Set the background color here
                                                    ),
                                                    onPressed: (){
                                                      setState(() {

                                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                                      });
                                                    }, child: Text('Delete',
                                                  style: TextStyle(color: Colors.black,fontFamily: 'Telex',
                                                    // fontWeight: FontWeight.bold
                                                  ),)),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    });
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                        Container(
                          height: 6.h,
                          width: width,
                          // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black45,
                                  child: Image.asset('assets/about_us.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                                // color: Colors.black,
                                child: Text('About Us',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                        Container(
                          height: 6.h,
                          width: width,
                          // color: Colors.white70,
                          child: Row(
                            children: [
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black45,
                                  child: Image.asset('assets/privacy_policy.png',)
                              ),
                              Container(
                                height: 7.h,
                                width: 60.w,
                                padding: EdgeInsets.only(top: 7.0),
                                // color: Colors.black,
                                child: Text('Privacy Policy',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.5.dp,fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,),
                              ),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy()));
                                  });
                                },
                                child: Container(
                                    height: 4.h,
                                    width: 20.w,
                                    //color: Colors.black,
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.white,indent: 1.5.h,endIndent: 2.5.h,),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
          Uri.parse('https://achujozef.pythonanywhere.com/api/user-profile'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        bool isTokenExpired = await JwtDecoder.isExpired(accessToken);
        print(isTokenExpired);

        //print('From getapi: ${accessToken}');
        // print('From getapi: ${get_response.statusCode}');

        if (get_response.statusCode == 200) {
          get_responcebody = await json.decode(get_response.body);
          //print('Response: $get_responcebody');
          setState(() {
            apiData = [
              '${get_responcebody!['weight']}',
              '${get_responcebody!['height']}',
              '${get_responcebody!['first_name']}',
              '${get_responcebody!['last_name']}',
              '${get_responcebody!['age']}',
              '${get_responcebody!['profile_picture']}',
            ];

            initialWeight = get_responcebody['initial_weight'];
            currentWeight = get_responcebody['weight'];

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
