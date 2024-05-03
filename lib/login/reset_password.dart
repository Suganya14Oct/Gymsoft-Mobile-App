import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/login/login.dart';
import 'package:gymsoft/model/user.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {

  final User? user;

  const ResetPassword({@required this.user,super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _formkey = GlobalKey<FormState>();
  final _newpassword = TextEditingController();
  final _conformpassword = TextEditingController();


  @override
  void dispose(){
    _newpassword.dispose();
    _conformpassword.dispose();
    super.dispose();
  }

  var responce;
  var responcebody;
  var data;


  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    data = widget.user!.phone.toString();

    return Scaffold(
      body: Form(
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
                          image: AssetImage("assets/male_background.jpeg"),fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              Positioned(
                height: 190,
                width: 250,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/gymsoftLogo.png"),fit: BoxFit.cover
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 8.0),
                child: Wrap(
                  direction: Axis.vertical,
                  children: [
                    Container(
                        height: height * 0.4,
                        width: width * 0.20,
                        //color: Colors.white70,
                        child:new RotatedBox(
                            quarterTurns: 3,
                            child: new Text("Reset Here",textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white70,
                                    fontSize: 40.dp))
                        )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 460.0, left: 8.0,right: 8.0),
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
                      prefixIcon: Icon(Icons.lock, color: Colors.white,),

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
                        if(_formkey.currentState!.validate()) {
                          print(data);
                          resetApi(data.toString(), _newpassword.text.toString(), context);
                          print("Success");
                          print(_newpassword.text.toString());
                          print(_conformpassword.text.toString());
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        }else{
                          setState(() {
                            print("Error");
                            print(_newpassword.text.toString());
                            print(_conformpassword.text.toString());
                          });
                        }
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

  Future<void> resetApi(String phone, password, BuildContext context) async {
    try{
      responce = await http. post(
          Uri.parse('https://achujozef.pythonanywhere.com/api/reset-password/'),
          body:  {
            "phonenumber": phone,
            "newPassword": password
          },
      );
      print(data.toString());
      print(responce.statusCode);

      if(responce.statusCode == 200){
        responcebody = json.decode(responce.body);
        print(responcebody);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }

    }catch (e){
      print(e.toString());
    }
  }
}
