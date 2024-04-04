import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:provider/provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  final _formkey = GlobalKey<FormState>();
  final _ThoughtController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child){
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                  Form(
                    key: _formkey,
                    child: Container(
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
                                     Navigator.pop(context);
                                      // print('Navigating');
                                      //mainScreenNotifier.pageIndex = 0;
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
                                Text("Feedback",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                              ],
                            ),
                            Container(
                              height: 5.h,
                              width: width,
                              padding: EdgeInsets.only(left: 30.0),
                              //color: Colors.amber,
                              child: Text('Do you like our app?',
                                style: TextStyle(color: Colors.white,
                                    fontFamily: 'Telex',fontSize: 15.0.dp),
                              ),
                            ),
                            Container(
                              height: 5.h,
                              width: width,
                              alignment: Alignment.bottomRight,
                              padding: EdgeInsets.only(right: 30.0),
                              //color: Colors.amber,
                              child: Text('Required*',
                                style: TextStyle(color: Colors.white,
                                    fontFamily: 'Telex',fontSize: 12.0.dp),
                              ),
                            ),
                            Container(
                              height: 15.h,
                              width: 100.w,
                              margin: EdgeInsets.all(10.0),
                              //padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border: Border.fromBorderSide(BorderSide(
                                  color: Colors.white
                                )),
                                  borderRadius: BorderRadius.all(Radius.circular(20.0))
                              ),
                              child: EmojiFeedback(
                                animDuration: Duration(milliseconds: 300),
                                inactiveElementBlendColor: Colors.transparent,
                                labelTextStyle: TextStyle(color: Colors.white,fontSize: 15.0.dp),
                                onChanged: (value){
                                  setState(() {
                                    print(value);
                                  });
                                },
                              ),
                            ),
                            Container(
                              height: 5.h,
                              width: width,
                              margin: EdgeInsets.only(top: 10.0),
                              padding: EdgeInsets.only(left: 30.0),
                              //color: Colors.amber,
                              child: Text('What would you like to share with us?',
                                style: TextStyle(color: Colors.white,
                                    fontFamily: 'Telex',fontSize: 13.5.dp),
                              ),
                            ),
                            Container(
                              height: 5.h,
                              width: width,
                              alignment: Alignment.bottomRight,
                              padding: EdgeInsets.only(right: 30.0),
                              //color: Colors.amber,
                              child: Text('Required*',
                                style: TextStyle(color: Colors.white,
                                    fontFamily: 'Telex',fontSize: 11.5.dp),
                              ),
                            ),
                            Container(
                              height: 120.dp,
                              width: 290.dp,
                              //color: Colors.blueGrey,
                              alignment: Alignment.center,
                              child: TextFormField(
                                enableInteractiveSelection: false,
                                  onTap: (){
                                    setState(() {
                                          
                                    });
                                  },
                                  style: TextStyle(
                                      color: Colors.white70,fontFamily: 'Telex',fontSize: 14.5.dp
                                  ),
                                  controller: _ThoughtController,
                                  minLines: 1,
                                  maxLines: 5,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    fillColor: Colors.black26,
                                    filled: true,
                                    contentPadding: EdgeInsets.all(30.0),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        borderSide: BorderSide(
                                          color: Colors.white70,
                                        )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.white),
                                        borderRadius: BorderRadius.circular(15.0)
                                    ),
                                    prefixIcon: Icon(Icons.edit, color: Colors.white,),
                                          
                                    label: Text('Your Thoughts',style: TextStyle(
                                        color:Colors.white70,fontSize: 15.0.dp
                                    ),
                                    ),
                                  ),
                                  validator: (value){
                                    if(value == null || value.isEmpty){
                                      return "Please enter your Name";
                                    }else if(value.length < 4){
                                      return "Enter atleast 4 letters";
                                    }return null;
                                  }
                              ),
                            ),
                            Container(
                              height: 7.h,
                              width: width,
                              margin: EdgeInsets.only(top: 10.0),
                              padding: EdgeInsets.only(left: 30.0,right: 30.0),
                              //color: Colors.amber,
                              child: Text('How likely would you recommend GYMSOFT to your friends?',
                                style: TextStyle(color: Colors.white,
                                    fontFamily: 'Telex',fontSize: 13.5.dp),
                              ),
                            ),
                            SizedBox(
                              height: 4.0.h,
                            ),
                           RatingBar.builder(
                                            initialRating: 3,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            unratedColor: Colors.white70,
                                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                        print(rating);
                                            },
                                          ),
                            SizedBox(
                              height: 4.0.h,
                            ),
                            Container(
                              height: height * 0.06,
                              width: 40.w,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xffd41012),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(17.0)
                                    )
                                ),
                                onPressed: (){},
                                child: Text("Submit",style: TextStyle(fontSize: 15.0.dp,color: Colors.white)),),
                            ),
                            SizedBox(
                              height: 15.h,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
