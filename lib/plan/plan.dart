import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/plan/buy_plan.dart';

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {

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
                          Text("Plan",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                        ],
                      )
                  ),
                  Container(
                    height: 85.0.h,
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index){
                          return Stack(
                            children: [
                              InkWell(
                                onTap : (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BuyPlan()));
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 60),
                                  width: MediaQuery.of(context).size.width,
                                  height: 20.0.h,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Colors.black45,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 60,right: 10.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: Text('30-Days Arms With Abel Albonetti',
                                            textAlign : TextAlign.justify,
                                            style: TextStyle(
                                                //fontWeight: FontWeight.bold,
                                                fontSize: 12.0.dp,
                                                color: Colors.white
                                            ),)),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Flexible(
                                                  child: Text('₹ 390',style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13.0.dp,
                                                      color: Colors.white
                                                  ),)),
                                              Flexible(
                                                  child: Text('View',style: TextStyle(
                                                     // fontWeight: FontWeight.bold,
                                                      fontSize: 12.0.dp,
                                                      color: Colors.white
                                                  ),)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 23.0.dp,left: 5.0,
                                  child: Container(
                                      width: 100,
                                      height: 100,
                                      child: CircleAvatar(
                                          child:  ClipOval(
                                              child:
                                              Image.network('https://res.cloudinary.com/dkocmifft/image/upload/v1/user_profile_pictures/WhatsApp_Image_2024-02-10_at_19.30.09_33d00ad6_lqme3t',
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace){
                                                  print('Error loading image: $error');
                                                  return SizedBox(
                                                    height: 2.h,
                                                    width: 4.w,
                                                    child: CircularProgressIndicator(color: Colors.black12),
                                                  );
                                                },
                                              )
                                          )
                                      )
                                  )
                              )
                            ],
                          );
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
