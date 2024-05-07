import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/home_page/main_screen.dart';
import 'package:gymsoft/login/api.dart';
import 'package:gymsoft/settings/settings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final Api _api = Api();

  final _formkey = GlobalKey<FormState>();
  final _newpassword = TextEditingController();
  final _conformpassword = TextEditingController();
  final _oldpassword = TextEditingController();

  var responce;
  var responcebody;
  var data;
  var accessToken;
  var Token;

  // @override
  // void initState() {
  //   setState(() {
  //     //_isMounted = true;
  //     print('fetchData() function called from iniState');
  //     fetchData();
  //   });
  //   super.initState();
  // }
  //
  // Future<void> fetchData() async {
  //   try {
  //     var data = await changePasswordApi(_oldpassword.text.toString(), _newpassword.text.toString(), context);
  //
  //     if (data != null  && mounted) {
  //       setState(() {
  //         responcebody = data;
  //       });
  //     } else  {
  //       if(mounted){
  //         setState((){
  //           retryFetchData();
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //     if(mounted){
  //       setState(() {
  //         retryFetchData();
  //       });
  //     }
  //   }
  // }
  //
  // void retryFetchData() async {
  //
  //   const retryDelay = Duration(seconds: 1);
  //   Timer(retryDelay, () {
  //     if(mounted){
  //       fetchData();
  //     }
  //   });
  // }

  @override
  void dispose(){
    _newpassword.dispose();
    _conformpassword.dispose();
    _oldpassword.dispose();
    mounted;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body:  Form(
        key: _formkey,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: [
              Container(
                height: height,
                width: width,
                color: Colors.black,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/female_bg.jpg"),fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 8.0),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Container(
                        height: height * 0.5,
                        width: width * 0.20,
                       //color: Colors.white70,
                        alignment: Alignment.topCenter,
                        child:new RotatedBox(
                            quarterTurns: 3,
                            child: new Text("Change Here",textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white70,
                                    fontSize: 40.dp))
                        )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 400.0, left: 10.0,right: 10.0),
                child: TextFormField(
                    style: TextStyle(
                        color: Colors.white70,fontFamily: 'Telex',fontSize: 14.5.dp
                    ),
                    controller: _oldpassword,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      fillColor: Colors.black26,
                      filled: true,
                      contentPadding: EdgeInsets.all(15.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.white,),

                      label: Text('Old Password',style: TextStyle(
                          color:Colors.white70,fontSize: 15.0.dp
                      ),),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Enter your new password";
                      }else if(value.length < 8){
                        return "password must contain atleast 8 characters";
                      }return null;
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 480.0, left: 10.0,right: 10.0),
                child: TextFormField(
                    style: TextStyle(
                        color: Colors.white70,fontFamily: 'Telex',fontSize: 14.5.dp
                    ),
                    controller: _newpassword,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      fillColor: Colors.black26,
                      filled: true,
                      contentPadding: EdgeInsets.all(15.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      prefixIcon: Icon(Icons.lock_reset, color: Colors.white,),

                      label: Text('New Password',style: TextStyle(
                          color:Colors.white70,fontSize: 15.0.dp
                      ),),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Enter your new password";
                      }else if(value.length < 8){
                        return "password must contain atleast 8 characters";
                      }return null;
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 560.0, left: 8.0,right: 8.0),
                child: TextFormField(
                    style: TextStyle(
                        color: Colors.white70,fontFamily: 'Telex',fontSize: 15.0.dp
                    ),
                    controller: _conformpassword,
                    cursorColor: Colors.white60,
                    decoration: InputDecoration(
                      fillColor: Colors.black26,
                      filled: true,
                      contentPadding: EdgeInsets.all(15.0),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white70,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.0)
                      ),
                      prefixIcon: Icon(Icons.password, color: Colors.white,),

                      label: Text('Confirm Password',style: TextStyle(
                          color:Colors.white70,fontSize: 15.0.dp
                      ),),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "please fill the field";
                      }else if(value.length < 8){
                        return "Enter correct password";
                      }else if(_newpassword.text.toString() != _conformpassword.text.toString()){
                        return "Enter the same password";
                      }
                      return null;
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 670.0, left: 60.0 ),
                child: Container(
                  height: height * 0.06,
                  width: width * 0.70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffd41012),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17.0)
                        )
                    ),
                    onPressed: (){
                      setState(() {
                        print(_oldpassword.text.toString());
                        print(_newpassword.text.toString());
                        print(_conformpassword.text.toString());
                        changePasswordApi(_oldpassword.text.toString(),_newpassword.text.toString(),context);
                      });
                    },
                    child: Text("Reset Password",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70)),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changePasswordApi(String oldPassword, newPassword, BuildContext context) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');

    try{
      responce = await http.post(
          Uri.parse('https://achujozef.pythonanywhere.com/api/change-password/'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
          body: jsonEncode({
            "old_password": oldPassword.toString(),
            "new_password": newPassword.toString()
          },)
      );
      print(responce.statusCode);
      print(accessToken);

      if(responce.statusCode == 200) {
        responcebody = json.decode(responce.body);
        print(responcebody);
        if(_newpassword.text.toString() == _conformpassword.text.toString() &&
        _oldpassword.text.toString()  != _newpassword.text.toString()) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainScreen(token: accessToken,)));
      }else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Check Your Password'),backgroundColor: Color(0xffd41012))
          );
        }
      }
    }catch (e){
      print(e.toString());
    }
  }

}
