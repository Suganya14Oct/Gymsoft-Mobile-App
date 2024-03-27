import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gymsoft/login/login.dart';
import 'package:gymsoft/login/reset_password.dart';
import 'package:gymsoft/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class OtpPage extends StatefulWidget {

  final User? user;

   OtpPage({@required this.user,super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  var responce;
  var responcebody;
  var otpcode;
  String? data;

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
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
                          child: new Text("Verify Here",textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white70,
                                  fontSize: 40.dp))
                      )
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 380.0, left: 110.0),
                child: Text("We sent you a code",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70),)
            ),
            Padding(
                padding: const EdgeInsets.only(top: 410.0, left: 115.0),
                child: Text("Please enter it below",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70),)
            ),
            Padding(
              padding: const EdgeInsets.only(top: 440.0),
              child: OtpTextField(

                numberOfFields: 4,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                margin: EdgeInsets.all(10.0),
                fieldWidth: 60,
                borderColor: Colors.deepOrangeAccent,
                enabledBorderColor: Colors.white54,
                showFieldAsBox: true,
                cursorColor: Colors.white,
                textStyle: TextStyle(color: Colors.white),
                focusedBorderColor: Colors.white12,
                onCodeChanged: (String code) {

                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode){
                  otpcode = verificationCode.toString();
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("Verification Code",
                            style: TextStyle(
                                fontSize: 18.dp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          content: Text('Code entered is $verificationCode'),
                        );
                      }
                  );
                }, // end onSubmit
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 530.0, left: 60.0),
                child: Text("This helps us verify that it is you",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70),)
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 570.0, left: 90.0),
                    child: Text("Didn't get OTP",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70),)
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 570.0, left: 5.0),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          print('${widget.user!.phone.toString()}');
                          data = widget.user!.phone.toString();
                          print(data);
                          ResendApi(data.toString());
                        });
                      },
                        child: Text("RESEND OTP",style: TextStyle(fontSize: 15.0.dp,color: Colors.red,fontWeight: FontWeight.bold,),))
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 650.0, left: 15.0),
                    child: Text("Don't need to do this?",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70),)
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 650.0, left: 5.0),
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: Text("Login",style: TextStyle(fontSize: 15.0.dp,color: Colors.white70,fontWeight: FontWeight.bold),))
                ),
                Padding(
                  padding: EdgeInsets.only(top: 650.0, left: 25.0),
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.26,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffd41012),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0)
                          )
                      ),
                      onPressed: (){
                          setState(() {
                            if(otpcode != null){
                              print(otpcode);
                              data = widget.user!.phone.toString();
                              print(data);
                              //Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(user: widget.user)));

                              verifyOtpApi(data.toString(), otpcode.toString(), context);
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please fill all the field'),
                                    duration: Duration(seconds: 1),
                                  ));
                            }
                          });
                      },
                      child: FittedBox(child: Text("Proceed",style: TextStyle(fontSize: 14.0.dp,color: Colors.white70))),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> ResendApi(String phone) async {
    try{
      responce = await http. post(
          Uri.parse('https://achujozef.pythonanywhere.com/api/send_otp/'),
          body:  {
            "phonenumber": widget.user!.phone.toString(),
          }
      );

      print(responce.statusCode);

      if(responce.statusCode == 200){
        responcebody = json.decode(responce.body);
        print(responcebody);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(user: widget.user)));
      }

    }catch (e){
      print(e.toString());
    }
  }

  Future<void> verifyOtpApi(String phone, otp, BuildContext context) async {
    try{
      responce = await http. post(
          Uri.parse('https://achujozef.pythonanywhere.com/api/verify_otp/'),
          body:  {
            "phoneNumber": widget.user!.phone.toString(),
            "otp" : otpcode.toString()
          }
      );

      print(responce.statusCode);

      if(responce.statusCode == 200){
        responcebody = json.decode(responce.body);
        print(responcebody);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPassword(user: widget.user)));
      }

    }catch (e){
      print(e.toString());
    }
  }

}
