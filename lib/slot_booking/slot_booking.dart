import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/login/api.dart';
import 'package:gymsoft/notification/notify_me.dart';
import 'package:gymsoft/slot_booking/my_bookings.dart';
import 'package:gymsoft/slot_booking/slot_booking_api.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class SlotBooking extends StatefulWidget {
  const SlotBooking({super.key});

  @override
  State<SlotBooking> createState() => _SlotBookingState();
}

class _SlotBookingState extends State<SlotBooking> with SingleTickerProviderStateMixin {

  final Api _api = Api();
  final SlotApi _slotapi = SlotApi();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  late TabController _tabController;

  var accessToken;

  var get_response;

  var get_responcebody;

  var Token;

  final List<String> weekdays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  final List<String> forenoonSlots = [
    '6am - 7am',
    '7am - 8am',
    '8am - 9am',
    '9am - 10am',
    '10am - 11am',
  ];

  final List<String> afternoonSlots = [
    '11am - 12pm',
    '12pm - 1pm',
    '1pm - 2pm',
    '2pm - 3pm',
    '3pm - 4pm',
    '5pm - 6pm',
    '6pm - 7pm',
    '7pm - 8pm',
    '8pm - 9pm',
    '9pm - 10pm'
  ];

  late List<bool> isSelected;

  int selectedIndex = -1;

  final List<String> available_slots = [
    '11am - 12pm',
    '12pm - 1pm',
    '1pm - 2pm',
    '2pm - 3pm',
    '3pm - 4pm',
    '4pm - 5pm',
    '8pm - 9pm',
    '9pm - 10pm',
  ];

  final List<String> total_slots = [
    '6am - 7am',
    '7am - 8am',
    '8am - 9am',
    '9am - 10am',
    '10am - 11am',
    '11am - 12pm',
    '12pm - 1pm',
    '1pm - 2pm',
    '2pm - 3pm',
    '3pm - 4pm',
    '4pm - 5pm',
    '8pm - 9pm',
    '9pm - 10pm',
  ];

  String formattedDate = DateFormat('dd/MM/yyyy', 'en_US').format(DateTime.now());

  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: weekdays.length, vsync: this);
    isSelected = List.generate(available_slots.length, (_) => false);
      print('fetchData() function called from iniState');
      fetchData();
      fetchData1();
  }

  Future<void> fetchData() async {
    try {
      var data = await getApi();

      if (data != null && data.isNull && mounted) {
        setState(() {
          get_responcebody = data;
        });
      } else  {
        if(mounted){
          setState((){
            retryFetchData();
          });
        }
      }
    } catch (e) {
      print('Exception: $e');
      if(mounted){
        setState(() {
          retryFetchData();
        });
      }
    }
  }

  Future<void> fetchData1() async {
    try {
      var data = await _slotapi.getApi_booking();

      if (data != null && data.isNull && mounted) {
        setState(() {
          _slotapi.get_responcebody = data;
        });
      } else  {
        if(mounted){
          setState((){
            retryFetchData1();
          });
        }
      }
    } catch (e) {
      print('Exception: $e');
      if(mounted){
        setState(() {
          retryFetchData();
        });
      }
    }
  }

  void retryFetchData1() async {

    const retryDelay = Duration(seconds: 1);
    Timer(retryDelay, () {
      if(mounted){
        fetchData1();
      }
    });
  }

  void retryFetchData() async {

    const retryDelay = Duration(seconds: 1);
    Timer(retryDelay, () {
      if(mounted){
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _dateController.dispose();
    mounted;
    super.dispose();
  }

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
                            "assets/female_blur_bg.jpg"),
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
                              Icons.arrow_back_ios, color: Colors.white,
                              size: 20.dp,)
                        ),
                      ),
                      Text("Slot Booking",
                        style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0,bottom: 10.0),
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicatorColor: Colors.red,
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors.black,
                      tabs: weekdays.map((day) => Tab(
                        text: day,
                      )).toList(),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: weekdays.map((day) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 5.h,
                                width: width,
                                margin: EdgeInsets.only(top: 2.0.h),
                                padding: EdgeInsets.only(left: 20.0),
                                //color: Colors.amber,
                                child: Text('ForeNoon Slots (AM)',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.0.dp),
                                ),
                              ),
                              Container(
                                height: 15.0.h,
                                width: width,
                                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                child: GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8.0,
                                      crossAxisSpacing: 8.0,
                                      childAspectRatio: 3,
                                    ),
                                    itemCount: forenoonSlots.length,
                                    itemBuilder: (context, index){
                                      return Container(
                                        padding: EdgeInsets.all(5.0),
                                        height: 2.0.h,
                                        //color: Colors.white,
                                        decoration: BoxDecoration(
                                          color: Color(0xff29CF43),
                                          // border: Border.all(color: Colors.white),
                                          //borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                              child: Text(forenoonSlots[index],style: TextStyle(color: Colors.black),)),
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                height: 5.h,
                                width: width,
                                margin: EdgeInsets.only(top: 2.0.h),
                                padding: EdgeInsets.only(left: 20.0),
                                //color: Colors.amber,
                                child: Text('AfterNoon Slots (PM)',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 15.0.dp),
                                ),
                              ),
                              Container(
                                height: 26.0.h,
                                width: width,
                                margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                //color: Colors.white,
                                child: GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 8.0,
                                      crossAxisSpacing: 8.0,
                                      childAspectRatio: 3,
                                    ),
                                    itemCount: afternoonSlots.length,
                                    itemBuilder: (context, index){
                                      return Container(
                                        padding: EdgeInsets.all(5.0),
                                        height: 2.0.h,
                                        //color: Colors.white,
                                        decoration: BoxDecoration(
                                          color: Color(0xffB60B00),
                                          // border: Border.all(color: Colors.white),
                                          //borderRadius: BorderRadius.circular(30.0),
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                              child: Text(afternoonSlots[index],style: TextStyle(color: Colors.white),)),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 7.h,
                        width: 35.w,
                        margin: EdgeInsets.only(right: 10.0),
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white)
                          ),
                          onPressed: (){
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyBookings()));
                            });
                          },
                          child: Text('My Bookings',style: TextStyle(color: Colors.red,fontFamily: 'Telex'),),
                        ),
                      ),
                      // Container(
                      //   height: 7.h,
                      //   width: 45.w,
                      //   margin: EdgeInsets.only(right: 10.0),
                      //   child: TextButton(
                      //     style: ButtonStyle(
                      //         backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)
                      //     ),
                      //     onPressed: (){
                      //       setState(() {
                      //
                      //       });
                      //     },
                      //     child: Text('Cancel Booking',
                      //       style: TextStyle(color: Colors.white,fontFamily: 'Telex'),),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 7.h,
                    width: 70.w,
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {

                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffd41012),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17.0)
                        )
                      ),
                      child: Text('Book My Slot', style: TextStyle(fontSize: 15.0.dp,color: Colors.white),),
                    ),
                  ),
                  SizedBox(height: 20.0,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _scrollToIndex(int index) {

    double scrollTo = (index * 400.0) + 200.0; // Adjust as needed
    _scrollController.animateTo(
      scrollTo,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    if(!isSelected[index]){
      setState(() {
        isSelected[index] = true;
      });
    }


  }


  Future<void> _selectDate(BuildContext context) async {

    final now = DateTime.now();

    final currentWeekStart = now.subtract(Duration(days: now.weekday % 7));
    final currentWeekEnd = currentWeekStart.add(Duration(days: 6));

    
    final ThemeData themedata = ThemeData(
         dialogBackgroundColor: Colors.white,
        visualDensity: VisualDensity(
          horizontal: 2.0,
          vertical: 2.0
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.pinkAccent,
          onPrimary: Colors.white,
          surface: Colors.white, // Set white transparent color for the calendar
          onSurface: Colors.black,
        ),

      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentTextStyle: TextStyle(fontSize: 12.0),
      ),
    );
    
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: currentWeekEnd,
      builder: (context, child){
        return Theme(
          data: themedata,
          child:  SizedBox(
            height: MediaQuery.of(context).size.height * 0.4, // Customize the height as desired
            child:  Container(
              decoration: BoxDecoration(
                border: Border.all(
                 color: Colors.white),
              ),
              child: child,
            ),
          ),
        );
      }
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = pickedDate.toString().substring(0, 10);
      });
    }
  }

  getApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');

    try {

      if(accessToken != null){
        get_response = await http.get(
          Uri.parse('https://achujozef.pythonanywhere.com/api/slots/'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        bool isTokenExpired = await JwtDecoder.isExpired(accessToken);
       // print(isTokenExpired);

       // print('From getapi: ${accessToken}');
        //print('From SlotGetApi: ${get_response.statusCode}');

        if (get_response.statusCode == 200) {
          get_responcebody = await json.decode(get_response.body);
          //print('Response: $get_responcebody');
        }
        else if(isTokenExpired)  {
          _api.refreshtoken();
         // refreshtoken();
          getApi();
          print(accessToken);
          print('Error: ${get_response.statusCode}');
        }
      }
    } catch (e) {
      // Handle exceptions or network errors
      print('Exception: $e');
    }
  }

}
