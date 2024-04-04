import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class BuyPlan extends StatefulWidget {
  const BuyPlan({super.key});

  @override
  State<BuyPlan> createState() => _BuyPlanState();
}

class _BuyPlanState extends State<BuyPlan> {

  var accessToken;

  var get_response;

  var get_responcebody;

  var refresh_response;

  var Token;

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  children: [
                    Container(
                        height: 10.0.h,
                        child: Row(
                          children: [
                            InkWell(
                              onTap : (){
                                setState(() {
                                  print('Navigating');
                                  // mainScreenNotifier.pageIndex = 0;
                                  Navigator.pop(context);
                                });
                              },
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  height: 10.0.h,
                                  width: 10.0.w,
                                  child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20.dp,)
                              ),
                            ),
                            Text("Buy Plan",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                          ],
                        )
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20.0),
                      //color: Colors.amber,
                      child: FittedBox(
                        child: Text('30-Days Arms With Abel Albonetti',
                            overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                              fontSize: 15.0.dp,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 300,
                      decoration: BoxDecoration(
                        //color: Colors.amber,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Image.network(
                          'https://res.cloudinary.com/dkocmifft/image/upload/v1/user_profile_pictures/WhatsApp_Image_2024-02-10_at_19.30.09_33d00ad6_lqme3t',
                      fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                      alignment: Alignment.center,
                     // width: 300,
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      //color: Colors.amber,
                      child: Expanded(
                        child: Text('->  Fitness Level: Advanced\n'
                            '->  Duration: 4 weeks\n'
                            '->  WorkOuts per week: 3 workouts per week\n'
                            '->  Average workout duration: 15 - 30 minutes\n'
                            '->  Equipment needed: Full Gym\n'
                            '->  Goal: Build muscle',
                          //overflow: TextOverflow.visible,
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 12.0.dp,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                      height: 20.h,
                      alignment: Alignment.center,
                      width: 87.w,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.all(10.0),
                      //color: Colors.amber,
                      child: Expanded(
                        child: Text('This is a systematic effective approach to arm training like nothing else out there. You will get workouts to be attached to your current program. plus one standalone arm pump session that you will definitely feel the next day! ',
                          //overflow: TextOverflow.visible,
                          style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 12.0.dp,
                              color: Colors.white
                          ),
                        ),
                      ),),
                    SizedBox(
                      height: 2.0.h,
                      //child: ,
                    ),
                    Container(
                      height: 7.h,width: 70.w,
                      //color: Color(0xffd41012),
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffd41012),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17.0)
                            )
                        ),
                        child: Text('Buy Plan',style: TextStyle(fontSize: 15.0.dp,color: Colors.white)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
