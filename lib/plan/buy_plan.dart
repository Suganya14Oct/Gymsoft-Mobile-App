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
                  Flexible(
                    flex: 3,
                      child: FittedBox(
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 300,
                          padding: EdgeInsets.all(20.0),
                          //color: Colors.amber,
                          child: Text('30-Days Arms With Abel Albonetti',
                              overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                                fontSize: 15.0.dp,
                                color: Colors.white
                            ),
                          ),
                        ),
                      )),
                  Container(
                    height: 200,
                    width: 300,
                    color: Colors.amber,
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
