import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
              Container(
                height: height,
                width: width,
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
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20.dp,
                              )
                          ),
                        ),
                        Text("My Bookings",
                          style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                      ],
                    ),
                    Container(
                      height: 85.0.h,
                      //width: width,
                      child:  ListView.builder(
                          itemCount: 4,
                          itemBuilder: (BuildContext context, int index){
                            return Container(
                              //margin: EdgeInsets.only(left: 60),
                              width: MediaQuery.of(context).size.width,
                              height: 25.0.h,
                              //color: Colors.black,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius:  BorderRadius.circular(20),
                                  gradient:  LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Colors.white, // English color
                                      Colors.red, // Teal color
                                    ],
                                    stops: [0.57, 1.0],
                                  )
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.0,bottom: 8.0,left: 60,right: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Flexible(
                                              child: Text('Day',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.0,
                                                    color: Colors.red
                                                ),)),
                                          Flexible(
                                              child: Text('Slot',style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0.dp,
                                                  color: Colors.red
                                              ),)),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left: 10.0,right: 10.0),
                                            child: Text('May',style: TextStyle(color: Colors.white),),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(bottom: 10.0),
                                            child: Text('01',style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                                color: Colors.white,fontSize: 25.0.dp),),
                                          ),
                                          Padding(
                                            padding:  EdgeInsets.only(left: 10.0,right: 10.0),
                                            child: Text('2024',style: TextStyle(color: Colors.white),),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
