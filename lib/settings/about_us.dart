import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
                            "assets/gym_female.jpg"),
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
                        Text("About Us",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
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
