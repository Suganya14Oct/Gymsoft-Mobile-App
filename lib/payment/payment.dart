import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:gymsoft/home_page/home_page.dart';
import 'package:gymsoft/plan/plan.dart';
import 'package:provider/provider.dart';

class Paymnt extends StatefulWidget {
  const Paymnt({super.key});

  @override
  State<Paymnt> createState() => _PaymntState();
}

class _PaymntState extends State<Paymnt> {
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                print('Navigating');
                                //mainScreenNotifier.pageIndex = 0;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Plan()));
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
                          Text("Payment",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                        ],
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

