import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

class SlotBooking extends StatefulWidget {
  const SlotBooking({super.key});

  @override
  State<SlotBooking> createState() => _SlotBookingState();
}

class _SlotBookingState extends State<SlotBooking> {

  final ScrollController _scrollController = ScrollController();

  final List<String> timeSlots = [
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
    '5pm - 6pm',
    '6pm - 7pm',
    '7pm - 8pm',
    '8pm - 9pm',
    '9pm - 10pm',
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

  String formattedDate = DateFormat('dd/MM/yyyy', 'en_US').format(DateTime.now());

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
                      child: Text('Total Number of Slots',
                        style: TextStyle(color: Colors.white,
                            fontFamily: 'Telex',fontSize: 15.0.dp),
                      ),
                    ),
                    Container(
                      height: 40.0.h,
                      width: width,
                      //color: Colors.black45,
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 3,
                          ),
                          itemCount: timeSlots.length,
                          itemBuilder: (context, index){
                            return Container(
                              padding: EdgeInsets.all(5.0),
                              height: 2.0.h,
                              //color: Colors.white,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Center(
                                child: FittedBox(
                                    child: Text(timeSlots[index],style: TextStyle(color: Colors.black),)),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 5.h,
                          width: 40.w,
                          margin: EdgeInsets.only(top: 4.0.h),
                          padding: EdgeInsets.only(left: 10.0),
                          //color: Colors.amber,
                          child: Text('Available Slots',
                            style: TextStyle(color: Colors.white,
                                fontFamily: 'Telex',fontSize: 14.0.dp),
                          ),
                        ),
                        Container(
                          height: 5.h,
                          width: 60.w,
                          margin: EdgeInsets.only(top: 4.0.h),
                          padding: EdgeInsets.only(left: 30.0),
                         // color: Colors.amber,
                          child: Text('Click to Select Your Slot',
                            style: TextStyle(color: Colors.white,
                                fontFamily: 'Telex',fontSize: 14.0.dp),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40.0.h,
                      width: width,
                      //color: Colors.black45,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 8.0,
                            childAspectRatio: 3,
                          ),
                          itemCount: available_slots.length,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  //isSelected[index] = !isSelected[index];
                                  _scrollToIndex(index);

                                  if(selectedIndex != -1){
                                    setState(() {
                                      selectedIndex = -1;
                                    });
                                  }else{
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  }

                                  print('Selected index: $selectedIndex');

                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5.0),
                                height: 2.0.h,
                                //color: Colors.white,
                                decoration: BoxDecoration(
                                  color: selectedIndex == index ? Colors.black : Colors.white,
                                  // border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                  child: FittedBox(
                                      child: Text(available_slots[index],
                                        style: TextStyle(
                                          color: selectedIndex == index ? Colors.white : Colors.black,
                                        ),)),
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 2.0.h,
                      //child: ,
                    ),
                    Container(
                      height: 7.h,
                      width: 70.w,
                      //margin: EdgeInsets.only(left: 3.0.w),
                      //color: Color(0xffd41012),
                      child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            print(formattedDate);
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
                                        Text('Time : ${selectedIndex != -1 ? available_slots[selectedIndex] : 'No slot selected'}', style: TextStyle(color: Colors.white),),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}
