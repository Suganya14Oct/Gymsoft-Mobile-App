import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
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
                              Navigator.pop(context);
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
                        Text("Privacy Policy",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                      ],
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
}
