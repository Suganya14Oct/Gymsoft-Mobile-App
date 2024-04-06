import 'package:flutter/material.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:gymsoft/home_page/main_screen.dart';
import 'package:gymsoft/settings/change_password.dart';
import 'package:provider/provider.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black,
                                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
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
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black,
                                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
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
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black,
                                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
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
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black,
                                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
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
                              Container(
                                  height: 4.h,
                                  width: 20.w,
                                  //color: Colors.black,
                                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,)
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
}
