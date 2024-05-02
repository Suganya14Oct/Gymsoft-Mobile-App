import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/notification/notif.dart';

class Notificat extends StatefulWidget {
  const Notificat({super.key});

  @override
  State<Notificat> createState() => _NotificatState();
}

class _NotificatState extends State<Notificat> {

  late List<NotificationItem> notifications;

  @override
  void initState() {
    super.initState();

    notifications = [
      NotificationItem(
          title: 'Kiven!!',
          content: "You have a workOut @ 5pm",
          date: DateTime.now()),
      NotificationItem(
          title: 'Hey Kiven',
          content: 'Check Your Progress',
          date: DateTime.now()),
      NotificationItem(
          title: 'Notification 3',
          content: "You have a workOut @ 5pm",
          date: DateTime.now().subtract(Duration(days: 2))),
      // Additional notifications for reference
      NotificationItem(
          title: 'Another New Notification',
          content: 'Review Your Plan',
          date: DateTime.now().subtract(Duration(days: 1))), // Example: 1 hour ago
      NotificationItem(
          title: 'Another Yesterday Notification',
          content: 'You completed your Today',
          date: DateTime.now().subtract(Duration(days: 1))),
    ];

    notifications = sortNotificationsByCategory(notifications);
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Map<String, List<NotificationItem>> groupedNotifications = {};

    notifications.forEach((notification) {
      String key = _getNotificationCategory(notification.date);

      if (!groupedNotifications.containsKey(key)) {
        groupedNotifications[key] = [];
      }

      groupedNotifications[key]!.add(notification);
    });

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
                          image: AssetImage("assets/female_blur_bg.jpg"),
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
                              onTap: () {
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
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 20.dp,)
                              ),
                            ),
                            Text("Notifications",
                              style: TextStyle(color: Colors.white,
                                fontSize: 25.dp),)
                          ],
                        )
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: groupedNotifications.length,
                          itemBuilder: (context, index) {
                            String category = groupedNotifications.keys.elementAt(index);
                            List<NotificationItem> notifications = groupedNotifications[category]!;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      fontSize: 14.0.dp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                               ListView.builder(
                                 itemCount: notifications.length,
                                   shrinkWrap: true,
                                   physics: NeverScrollableScrollPhysics(),
                                   itemBuilder: (context, index){
                                     NotificationItem notification = notifications[index];
                                     return Container(
                                       margin: EdgeInsets.symmetric(vertical: 5.0),
                                       decoration: BoxDecoration(
                                         color: Colors.black45,
                                         borderRadius: BorderRadius.circular(10.0),
                                       ),
                                       child: ListTile(

                                         title:Row(

                                           children: [
                                             Flexible(
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Row(
                                                     children: [
                                                       Container(
                                                         height: 3.6.h,
                                                         width: 4.4.w,
                                                         margin: EdgeInsets.only(right: 5.0),
                                                         child: Image.asset("assets/name.png"),
                                                       ),
                                                       SizedBox(width: 5.0,),
                                                       Text(
                                                         notification.title,
                                                         style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                                             fontSize: 12.0.dp),
                                                       ),
                                                     ],
                                                   ),
                                                   SizedBox(height: 10.0),
                                                   Text(
                                                     notification.content,
                                                     style: TextStyle(
                                                       color: Colors.white,
                                                       fontSize: 12.0.dp,
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           ],
                                         ),
                                         trailing: Text(
                                           _formatDate(notification.date),
                                           style: TextStyle(
                                             color: Colors.white,
                                             fontSize: 10.0.dp,
                                           ),
                                         ),
                                       ),
                                     );
                                   })
                              ],
                            );
                          }
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  String _getNotificationCategory(DateTime date) {

    DateTime now = DateTime.now();
    DateTime fiveMinutesAgo = now.subtract(Duration(minutes: 5));

    if (date.isAfter(fiveMinutesAgo)) {
      return 'New';
    } else if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Today';
    } else if (date.day == now.subtract(Duration(days: 1)).day &&
        date.month == now.subtract(Duration(days: 1)).month &&
        date.year == now.subtract(Duration(days: 1)).year) {
      return 'Yesterday';
    } else {
      return 'Older';
    }
  }



  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  List<NotificationItem> sortNotificationsByCategory(List<NotificationItem> notifications) {

    notifications = notifications.where((notification) {
      return notification.date.isAfter(DateTime.now().subtract(Duration(days: 3)));
    }).toList();


    notifications.sort((a, b) {
      int priorityA = _getCategoryPriority(a.date);
      int priorityB = _getCategoryPriority(b.date);


      return priorityB.compareTo(priorityA);
    });


    notifications = notifications.reversed.toList();

    return notifications;
  }



  int _getCategoryPriority(DateTime date){

    String category = _getNotificationCategory(date);
    switch (category){
      case 'New': return 0;
      case 'Today': return 1;
      case 'Yesterday': return 2;
      default: return 3;
    }

  }

}


