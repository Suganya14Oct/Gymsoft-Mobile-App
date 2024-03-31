import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gymsoft/login/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/login/forgot_password.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formkey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final Api _api = Api();

  //String? accessToken;

  @override
  void dispose(){

    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();

  }

  var response;

  Map? responcebody;

  @override
  void initState() {
    super.initState();
  }

  _back(){
    return SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        setState(() {
          print('what to do...uuuffffff');
        });
      },
      child: WillPopScope(
        onWillPop: () async{
          _back();
          return false;
        },
        child: Scaffold(
         body: Form(
           key: _formkey,
           child: SingleChildScrollView(
             physics: AlwaysScrollableScrollPhysics(),
             child: Column(
               children: [
                 SafeArea(
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
                       Container(
                         height: height,
                         width: width,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding: EdgeInsets.only(top: 12.0),
                               child: Container(
                                 height: 9.5.h,
                                 width: 65.w,
                                 //color: Colors.amber,
                                 child: DecoratedBox(
                                   decoration: BoxDecoration(
                                       image: DecorationImage(
                                           image: AssetImage("assets/gymsoftLogo.png"),fit: BoxFit.cover
                                       )
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(left: 8.0),
                               child: Wrap(
                                 direction: Axis.vertical,
                                 children: [
                                   Container(
                                       height: height * 0.4,
                                       width: width * 0.20,
                                       //color: Colors.white70,
                                       child:new RotatedBox(
                                           quarterTurns: 3,
                                           child: new Text("Login Here",textAlign: TextAlign.center,
                                               style: TextStyle(color: Colors.white70,
                                                   fontSize: 40.dp))
                                       )
                                   ),
                                 ],
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top: 90.0, left: 8.0,right: 8.0),
                               child: TextFormField(
                                   style: TextStyle(
                                       color: Colors.white70,fontFamily: 'Telex',fontSize: 14.5.dp
                                   ),
                                   controller: _phoneController,
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
                                     prefixIcon: Icon(Icons.phone, color: Colors.white,),

                                     label: Text('Phone',style: TextStyle(
                                         color:Colors.white70,fontSize: 15.0.dp
                                     ),
                                     ),
                                   ),
                                   validator: (value){
                                     if(value == null || value.isEmpty){
                                       return "Please enter your phone number";
                                     }else if(value.length < 10){
                                       return "Check your number";
                                     }return null;
                                   }
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(top: 20.0, left: 8.0,right: 8.0),
                               child: TextFormField(
                                   style: TextStyle(
                                       color: Colors.white70,fontFamily: 'Telex',fontSize: 14.5.dp
                                   ),
                                   controller: _passwordController,
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
                                     prefixIcon: Icon(Icons.lock, color: Colors.white,),

                                     label: Text('Password',style: TextStyle(
                                         color:Colors.white70,fontSize: 15.0.dp
                                     ),),
                                   ),
                                   validator: (value){
                                     if(value == null || value.isEmpty){
                                       return "Please enter your Password";
                                     }else if(value.length < 8){
                                       return "Enter correct password";
                                     }return null;
                                   }
                               ),
                             ),
                             SizedBox(height: 20.0.dp,),
                             Row(
                               children: [
                                 GestureDetector(
                                     onTap: (){
                                       setState(() {
                                         Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                                       });
                                     },
                                     child: Container(
                                         padding: EdgeInsets.only(left: 20.0, right: 8.0,top : 10.0),
                                         height: height * 0.05,
                                         width: width * 0.4,
                                         child: FittedBox(child: Center(child: Text("Forgot Password?",style: TextStyle(fontSize: 12.0.dp, color: Colors.white70),))))),
                                 Expanded(
                                   child: Padding(
                                     padding: EdgeInsets.only(left: 90.0, right: 30.0,top: 10.0),
                                     child: Container(
                                       height: height * 0.06,
                                       width: width * 0.25,
                                       child: ElevatedButton(
                                         style: ElevatedButton.styleFrom(
                                             backgroundColor: Color(0xffd41012),
                                             shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(17.0)
                                             )
                                         ),
                                         onPressed: () async{
                                           if(_formkey.currentState!.validate()) {
                                   
                                             try{
                                               await _api.loginApi(_phoneController.text.toString(), _passwordController.text.toString(), context);
                                             }catch (e) {
                                               print('Login Error: $e');
                                             }
                                   
                                           }else{
                                             setState(() {
                                               print("Error");
                                               print(_phoneController.text.toString());
                                               print(_passwordController.text.toString());
                                             });
                                           }
                                         },
                                         child: Text("Login",style: TextStyle(fontSize: 15.0.dp,color: Colors.white)),),
                                     ),
                                   ),
                                 ),
                               ],
                             )
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
         ),
        ),
      ),
    );
  }

}

