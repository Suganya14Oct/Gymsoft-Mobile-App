import 'package:flutter/material.dart';
import 'package:gymsoft/home_page/home_page.dart';
import 'package:gymsoft/login/login.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/login/otp_page.dart';
import 'package:gymsoft/login/reset_password.dart';
import 'package:gymsoft/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ForgotPassword extends StatefulWidget {

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formkey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose(){

    _phoneController.dispose();
    super.dispose();

  }

  var responce;
  var responcebody;


  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                      height: height * 0.5,
                      width: width * 0.20,
                      //color: Colors.white70,
                      child:new RotatedBox(
                          quarterTurns: 3,
                          child: new Text("Forgot Password ",textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white70,
                                  fontSize: 30.dp))
                      )
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 480.0, left: 130.0),
                child: Text("We will send you an",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70),)
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 500.0, left: 90.0),
                    child: Text("One Time Code",style: TextStyle(fontSize: 15.0.dp,fontWeight: FontWeight.bold,color: Colors.white70),)
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 500.0, left: 5.0),
                    child: Text("on this number",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70),)
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 560.0, left: 8.0,right: 8.0),
              child: TextFormField(
                  style: TextStyle(
                      color: Colors.white70,fontFamily: 'Telex',fontSize: 15.0.dp
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
                    ),),
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
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 685.0, left: 18.0),
                    child: Text("New to Gym?",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70),)
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 685.0, left: 5.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                        child: Text("Login",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70,fontWeight: FontWeight.bold),))
                ),
                Padding(
                  padding: EdgeInsets.only(top: 680.0, left: 85.0),
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.265,
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
                            forgotApi(_phoneController.text.toString(),context);
                            print(_phoneController.text.toString());
                          }
                        });
                      },
                      child: Text("Submit",style: TextStyle(fontSize: 14.0.dp,color: Colors.white70)),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    );
  }

  Future<void> forgotApi(String phone, BuildContext context) async {
    try{
      responce = await http. post(
          Uri.parse('https://achujozef.pythonanywhere.com/api/send_otp/'),
          body:  {
            "phonenumber": phone.toString(),
          }
      );

      print(responce.statusCode);

      if(responce.statusCode == 200){
        responcebody = json.decode(responce.body);
        print(responcebody);
        User user = User(_phoneController.text.toString(), '');
        print('User: ${user}');
        Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage(user: user)));
      }

    }catch (e){
      print(e.toString());
    }
  }

}
