import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:get/get.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:gymsoft/notification/another_page.dart';
import 'package:gymsoft/notification/local_noti.dart';
import 'package:gymsoft/slot_booking/slot_booking.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotifyMe extends StatefulWidget {
  const NotifyMe({super.key});

  @override
  State<NotifyMe> createState() => _NotifyMeState();
}

class _NotifyMeState extends State<NotifyMe> {

  @override
  void initState() {
    listenToNotifications();
    super.initState();
  }

  // to listen anu notification clicked or not
  listenToNotifications(){
    print('Listening to notification');
    LocalNoti.onClickNotification.stream.listen((event) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AnotherPage(payload: event)));
    });
  }
  
  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(builder: (context, mainScreenNotifier, child) {
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
                          image: AssetImage("assets/male_background.jpeg"),
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
                    Container(
                        height: 10.0.h,
                        child: Row(
                          children: [
                            InkWell(
                              onTap : (){
                                setState(() {
                                  print('Navigating');
                                  //mainScreenNotifier.pageIndex = 0;
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
                            Text("Notify Me",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                          ],
                        )
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          LocalNoti.showSimpleNotification(
                              title: 'Simple Notification',
                              body: 'This is a Simple Notification',
                              payload: 'This is Simple Data');
                        });
                      },
                      child: Container(
                      height: 100,
                        width: 100,
                        color: Colors.red,
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          LocalNoti.showPeriodicNotifications(
                              title: 'Periodic Notification',
                              body: 'This is a Periodic Notification',
                              payload: 'This is Periodic Data');
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        setState(() {
                          LocalNoti.cancel(1);
                          print('cancelled');
                        });
                    },
                      child: Text('Close Periodic Notifications',style: TextStyle(color: Colors.white),),
                    ),
                    TextButton(
                      onPressed: (){
                        setState(() {
                          LocalNoti.cancelAll();
                          print('cancelled All');
                        });
                      },
                      child: Text('Cancel All Notifications',style: TextStyle(color: Colors.white),),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          LocalNoti.showScheduleNotification(
                              title: 'Schedule Notification',
                              body: 'This is a Schedule Notification',
                              payload: 'This is Schedule Data');
                        });
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

        ),
      );
    });
  }
}
