import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class SlotBooking extends StatefulWidget {
  const SlotBooking({super.key});

  @override
  State<SlotBooking> createState() => _SlotBookingState();
}

class _SlotBookingState extends State<SlotBooking> {

  final ScrollController _scrollController = ScrollController();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

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
    isSelected = List.generate(available_slots.length, (_) => false);
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
                            "assets/male_background.jpeg"),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Container(
              height: height,
              width: width,
              child: SingleChildScrollView(
                controller: _scrollController,
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
                        Text("Slot Booking",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                      ],
                    ),
                    Container(
                      height: 5.h,
                      width: width,
                      margin: EdgeInsets.only(top: 4.0.h),
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
                      margin: EdgeInsets.only(left: 10.0,right: 10.0),
                     // color: Colors.white,
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
                      margin: EdgeInsets.only(top: 4.0.h),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 5.h,
                        width: 40.w,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 4.0.h,bottom: 5.0),
                        padding: EdgeInsets.only(left: 20.0),
                        //color: Colors.amber,
                        child: Text('Select Your Slot',
                          style: TextStyle(color: Colors.white,
                              fontFamily: 'Telex',fontSize: 14.0.dp),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50.dp,
                          width: 170.dp,
                          //color: Colors.blueGrey,
                          alignment: Alignment.center,
                          child: TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: false,
                              onTap: (){
                                setState(() {
                                  _selectDate(context);
                                });
                              },
                              style: TextStyle(
                                  color: Colors.white70,fontFamily: 'Telex',fontSize: 12.5.dp
                              ),
                              controller: _dateController,
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
                                suffixIcon: Icon(Icons.calendar_month, color: Colors.white,),
                                label: FittedBox(
                                  child: Text('Select Date',style: TextStyle(
                                      color:Colors.white70,fontSize: 11.4.dp
                                  ),
                                  ),
                                ),
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Please pick Date";
                                }return null;
                              }
                          ),
                        ),
                        Container(
                          height: 50.dp,
                          width: 170.dp,
                          //color: Colors.blueGrey,
                          alignment: Alignment.center,
                          child: DropdownButtonFormField(
                            dropdownColor: Colors.black87,
                            value: selectedTimeSlot,
                              items: total_slots.map((timeSlot) {
                                return DropdownMenuItem(
                                  value: timeSlot,
                                  child: Text(timeSlot),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedTimeSlot = newValue;
                                });

                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  _scrollController.animateTo(
                                      _scrollController.position.maxScrollExtent,
                                      duration: Duration(microseconds: 10),
                                      curve: Curves.easeInOut);
                                });

                              },
                              style: TextStyle(
                                  color: Colors.white,fontFamily: 'Telex',fontSize: 11.0.dp
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.black26,
                                filled: true,
                                //contentPadding: EdgeInsets.all(30.0),
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
                                label: FittedBox(
                                  child: Text('Select Time',
                                    style: TextStyle(
                                      color:Colors.white70,
                                      fontSize: 11.4.dp
                                  ),
                                  ),
                                ),
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Please pick Time";
                                }return null;
                              }
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0.h,),
                    Container(
                      height: 7.h,
                      width: 70.w,
                      //margin: EdgeInsets.only(left: 3.0.w),
                      //color: Color(0xffd41012),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            print(selectedTimeSlot);
                            showDialog(context: context, builder: (BuildContext context){
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(32.0))
                                ),
                                title: Center(
                                  child: Text('Your slot is booked on', style: TextStyle(
                                    fontSize: 13.0.dp,
                                    color: Colors.white,
                                    fontFamily: 'Telex',
                                    //fontWeight: FontWeight.bold
                                  ),),
                                ),
                                content: Container(
                                    height: 20.h,
                                    width: 80.w,
                                    //margin: EdgeInsets.only(left: 30.0.w, top: 2.0.h),
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      border: Border.fromBorderSide(BorderSide(
                                          color: Colors.white
                                      )),
                                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Date : ${formattedDate}', style: TextStyle(color: Colors.white),),
                                        Text('Time : ${selectedTimeSlot}', style: TextStyle(color: Colors.white),),
                                      ],
                                    )
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 6.h,
                                        width: 27.w,
                                        child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Color(0xffd41012)), // Set the background color here
                                            ),
                                            onPressed: (){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  shape: BeveledRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0)
                                                  ),
                                                  backgroundColor: Colors.white70,
                                                    content: Text('You will be Notified',style: TextStyle(color: Colors.black),),
                                                  duration: Duration(seconds: 2),
                                                )
                                              );
                                              Navigator.pop(context);
                                            }, child: Text('Notify Me',
                                          style: TextStyle(color: Colors.white,
                                              fontFamily: 'Telex',
                                              //fontWeight: FontWeight.bold
                                          ),)),
                                      ),
                                      Container(
                                        height: 6.h,
                                        width: 27.w,
                                        child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white70), // Set the background color here
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            }, child: Text('Okay',
                                          style: TextStyle(color: Colors.black,fontFamily: 'Telex',
                                            // fontWeight: FontWeight.bold
                                          ),)),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            });
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffd41012),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17.0)
                            )
                        ),
                        child: Text('Book My Slot',style: TextStyle(fontSize: 15.0.dp,color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 5.0.h,
                      //child: ,
                    ),
                  ],
                ),
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

  @override
  void dispose() {
    _scrollController.dispose();
    _dateController.dispose();
    super.dispose();
  }

}
