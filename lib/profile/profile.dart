import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/login/api.dart';
import 'package:gymsoft/profile/edit_profile.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final Api _api = Api();

  var accessToken;

  var get_response;

  var get_responcebody;

  var refresh_response;

  var Token;

  late List<dynamic> apiData;

  double minValue = 0.0;
  double maxValue = 100.0;

   double? currentWeight;
   double? initialWeight;


  @override
  void initState() {
    setState(() {
      // _isMounted = true;
      print('fetchData() function called from iniState');
      fetchData();
    });
    super.initState();
  }

  Future<void> fetchData() async {
    try {
      var data = await getApi();

      if (data != null && data.isNull && mounted) {
        setState(() {
          get_responcebody = data;
        });
      } else  {
        setState(() {
          if(mounted){
            retryFetchData();
          }

        });
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

  void retryFetchData() async {

    const retryDelay = Duration(seconds: 1);
    Timer(retryDelay, () {
      if(mounted){
        fetchData();
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if (currentWeight == null || initialWeight == null) {
      // Handle null values here, return a placeholder widget or an error message
      return Center(child: CircularProgressIndicator());
    }

    double weightDifference = currentWeight! - initialWeight!;

    double maxChange = 10;
    double segmentChange = maxChange / 3;

    double lossSegmentMax = initialWeight!;
    double lossSegmentMin = initialWeight! - segmentChange;

    double neutralSegmentMax = initialWeight! + segmentChange;
    double neutralSegmentMin = initialWeight! - segmentChange;

    double gainSegmentMax = currentWeight!;
    double gainSegmentMin = initialWeight! + segmentChange;


    return Consumer<MainScreenNotifier>(builder: (context, mainScreenNotifier, child){

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
                            image: AssetImage("assets/gym_female.jpg"),fit: BoxFit.cover
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
                        height: 40.h,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.0.w),
                                bottomLeft: Radius.circular(10.0.w)
                            )
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap : (){
                                    setState(() {
                                      print('Navigating');
                                      mainScreenNotifier.pageIndex = 0;
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      height: 10.0.h,
                                      width: 10.0.w,
                                      child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20.dp,)
                                  ),
                                ),
                                Text("Profile",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10.0,right: 15.0,),
                                  height: 100,
                                  width: 100,
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        print('from profile');
                                        print(currentWeight!);
                                        print(initialWeight!);
                                      });
                                    },
                                      child: CircleAvatar(
                                          child: get_responcebody != null ? ClipOval(
                                              child:
                                              Image.network('${get_responcebody!['profile_picture']}',fit: BoxFit.cover,)
                                          ) : SizedBox(
                                              height: 2.h,width: 4.w,
                                              child: CircularProgressIndicator(color: Colors.black12,)
                                          )
                                      )
                                  ),
                                ),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                       child: get_responcebody != null
                                            ? Text('${get_responcebody!['first_name']} ${get_responcebody!['last_name']}',
                                                overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,
                                           style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 30.0.dp))
                                            : SizedBox(
                                            height: 2.h,width: 3.w,
                                            child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2.dp,))
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: height * 0.05,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(Icons.monitor_weight,color: Colors.white,size: 35.dp,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: get_responcebody != null
                                          ? Text('${get_responcebody!['weight']} Kgs', style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 11.0.dp))
                                          : SizedBox(
                                          height: 1.h,width: 2.w,
                                          child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.dp,))
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.height,color: Colors.white,size: 35.dp,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: get_responcebody != null
                                          ? Text('${get_responcebody!['height']} Cms',
                                               style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 11.0.dp))
                                          : SizedBox(
                                          height: 1.h,width: 2.w,
                                          child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.dp,))
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(Icons.perm_contact_calendar_sharp,color: Colors.white,size: 35.dp,),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: get_responcebody != null
                                          ? Text('${get_responcebody!['age']} Yrs',
                                          style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 11.0.dp))
                                          : SizedBox(
                                          height: 1.h,width: 2.w,
                                          child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.dp,))
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      height: 5.5.h,
                                      width: 11.5.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 1.5
                                          )
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: get_responcebody != null
                                            ? Text('${get_responcebody!['days_since_joining']}',
                                            style: TextStyle(color: Colors.white, fontFamily: 'Telex', fontSize: 11.0.dp))
                                            : SizedBox(
                                            height: 1.h,width: 2.w,
                                            child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.dp,))
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text('Days',style: TextStyle(color: Colors.white,fontSize: 11.dp),),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Container(
                        height: height * 0.06,
                        width: width * 0.8,
                        alignment: Alignment.center,
                        child: Text('Your Progress',style: TextStyle(color: Colors.white,fontSize: 25.dp),),
                      ),
                    get_responcebody != null ? Container(
                        height: height * 0.3,
                        width: width * 0.7,
                        //color: Colors.white70,
                        child:  (currentWeight != null && initialWeight != null)
                            ? SfRadialGauge(
                          //backgroundColor: Colors.white10,
                              axes: [
                            RadialAxis(
                              // minimum: get_responcebody != null
                              //     ? '${get_responcebody!['initial_weight']}'
                              //     : 0,
                              minimum: currentWeight! < initialWeight! ? currentWeight! :  initialWeight!,
                              maximum: initialWeight! > currentWeight! ? initialWeight! : currentWeight!,
                              // startAngle: 180,
                              // endAngle: 360,
                              axisLineStyle: AxisLineStyle(
                                thicknessUnit: GaugeSizeUnit.factor,thickness: 0.03
                              ),
                              minorTickStyle: MinorTickStyle(length: 3,thickness: 3,color: Colors.white),
                              majorTickStyle: MajorTickStyle(length: 6,thickness: 4,color: Colors.white),
                              axisLabelStyle:GaugeTextStyle(
                                color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                              useRangeColorForAxis: true,
                              ranges: [
                                // GaugeRange(
                                //   startValue: lossSegmentMin,
                                //   endValue: lossSegmentMax,
                                //   color: Colors.red,
                                //   // startWidth: 0.05,
                                //   // endWidth: 25,
                                //   gradient: const SweepGradient(
                                //       colors: <Color>[Color(0xFFBC4E9C), Color(0xFFF80759)],
                                //       stops: <double>[0.25, 0.75]),
                                // ),
                                // GaugeRange(
                                //   startValue: neutralSegmentMin,
                                //   endValue: neutralSegmentMax,
                                //   color: Colors.yellow,
                                //   // startWidth: 0.05,
                                //   // endWidth: 25,
                                //   gradient: const SweepGradient(
                                //       colors: <Color>[Colors.orangeAccent, Colors.yellow],
                                //       stops: <double>[0.25, 0.75]),
                                // ),
                                GaugeRange(
                                  startValue: gainSegmentMin,
                                  endValue: gainSegmentMax,
                                  color: Colors.green,
                                  // startWidth: 0.05,
                                  // endWidth: 25,
                                  gradient: const SweepGradient(
                                      colors: <Color>[Colors.red,Colors.yellow, Colors.green],
                                      stops: <double>[0.25, 0.95,0.150]),
                                )
                              ],
                              pointers: [
                                NeedlePointer(
                                  value: currentWeight!,
                                  enableAnimation: true,
                                  needleColor: Colors.white,
                                ),
                                MarkerPointer(
                                  value: currentWeight!,
                                  enableAnimation: true,
                                  color: Colors.black,
                                )
                              ],
                              annotations: [
                                GaugeAnnotation(
                                  widget: Text('Kgs/days',style: TextStyle(color: Colors.lightGreenAccent),),
                                  positionFactor: 0.55,
                                  angle: 85,
                                )
                              ],
                            )
                          ],
                        ) : CircularProgressIndicator(),
                      ) :
                    SizedBox(
                        height: 2.h,width: 4.w,
                        child: Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 1.dp,)))
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(apiData: apiData)));
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xffB3AFAF),Color(0xffFFFFFF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                          ),
                        ),
                        child: Icon(Icons.mode_edit_outline_rounded,size: 24.dp),
                      ),
                    )
                )
              ],
            ),
          )
      );
    }

    );
  }

  Future<bool> refreshtoken() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? refreshToken = prefs.getString('refreshToken');

    //print('in refreshToken function: $refreshToken');

    if(refreshToken != null){
      refresh_response = await http.post(Uri.parse('https://achujozef.pythonanywhere.com/api/token/refresh/'),
          body: {'refresh' : refreshToken});
      print('Inside refreshToken Function ${refresh_response.statusCode}');
      if(refresh_response.statusCode == 200){
        final responnsebody = json.decode(refresh_response.body);
        print(responnsebody);
        Token = responnsebody['access'];
        print(Token);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        accessToken = prefs.setString('accessToken', Token);
        return true;
      }else{
        print('failed');
        return false;
      }
    }
    return false;
  }


  getApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');

    try {

      if(accessToken != null){
        get_response = await http.get(
          Uri.parse('https://achujozef.pythonanywhere.com/api/user-profile'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        bool isTokenExpired = await JwtDecoder.isExpired(accessToken);
        print(isTokenExpired);

        //print('From getapi: ${accessToken}');
       // print('From getapi: ${get_response.statusCode}');

        if (get_response.statusCode == 200) {
          get_responcebody = await json.decode(get_response.body);
          //print('Response: $get_responcebody');
          setState(() {
            apiData = [
              '${get_responcebody!['weight']}',
              '${get_responcebody!['height']}',
              '${get_responcebody!['first_name']}',
              '${get_responcebody!['last_name']}',
              '${get_responcebody!['age']}',
              '${get_responcebody!['profile_picture']}',
            ];

            initialWeight = get_responcebody['initial_weight'];
            currentWeight = get_responcebody['weight'];

          });
        }
        else if(isTokenExpired)  {
          refreshtoken();
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
