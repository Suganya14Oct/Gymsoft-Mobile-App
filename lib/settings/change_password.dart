import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/home_page/main_screen.dart';
import 'package:gymsoft/settings/settings.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formkey = GlobalKey<FormState>();
  final _newpassword = TextEditingController();
  final _conformpassword = TextEditingController();
  final _oldpassword = TextEditingController();


  @override
  void dispose(){

    _newpassword.dispose();
    _conformpassword.dispose();
    _oldpassword.dispose();
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
                          image: AssetImage("assets/gym_female.jpg"),fit: BoxFit.cover
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
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
}
