import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gymsoft/attendance/add_attendance.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool showScanner = false;
  bool scannedAndNavigated = false;
  bool cooldown = false;
  var responce;
  var responcebody;

  @override
  void reassemble() {
    super.reassemble();

    if(controller != null){
      if(Platform.isAndroid){
        controller!.pauseCamera();
      }else if(Platform.isIOS){
        controller!.resumeCamera();
      }
    }

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
                          Text("Attendance",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                        ],
                      ),

                      Center(
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              print('click');
                              showScanner = !showScanner;
                            });
                          },
                          child: Container(
                            height: 15.h,
                            width: 30.h,
                            margin: EdgeInsets.only(top: 20.h),
                            color: Colors.red,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 8.h,
                                  width: 9.h,
                                  //color: Colors.white70,
                                  child: Icon(Icons.qr_code_scanner,color: Colors.white,size: 40.dp,),
                                ),
                                Text('Add Attendance',
                                  style: TextStyle(color: Colors.white,
                                      fontFamily: 'Telex',fontSize: 14.0.dp),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 5.h,
                      ),

                      if(showScanner)... [

                        Container(
                          height : height * 0.4,
                          width: width * 0.8,
                          margin: EdgeInsets.all(10.0),
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        ) ,

                        Container(
                          height: height * 0.4,
                          width: width * 0.7,
                         // color: Colors.brown,
                          margin: EdgeInsets.all(10.0),
                          child: Center(
                            child: (result != null) ?
                            Text('Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}', style: TextStyle(color: Colors.white),)
                                : Text('Scan a code'),
                          ),
                        )
                      ],
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }

  

  void _onQRViewCreated(QRViewController controller) {

    scannedAndNavigated = false;

    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      if(result != null && !scannedAndNavigated && !cooldown) {

        controller.stopCamera();

        Navigator.push(context, MaterialPageRoute(builder: (context) => AddAttendance()))
            .then((_) {
          scannedAndNavigated = true;

          startCooldown();

        });
      }

    });
  }

  void startCooldown() {

    cooldown = true;

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        cooldown = false;
      });
    });

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}
