import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/plan/buy_plan.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Plan extends StatefulWidget {
  const Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {

  var accessToken;

  var get_response;

  var get_responcebody;

  var refresh_response;

  var Token;

  @override
  void initState() {
    setState(() {
      //_isMounted = true;
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
                        image: AssetImage("assets/male_background.jpeg"),fit: BoxFit.cover
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
                                // mainScreenNotifier.pageIndex = 0;
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
                          Text("Plan",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                        ],
                      )
                  ),
                  Container(
                    height: 85.0.h,
                    child: get_responcebody != null ? ListView.builder(
                        itemCount: get_responcebody.length,
                        itemBuilder: (BuildContext context, int index){
                          return Stack(
                            children: [
                              InkWell(
                                onTap : (){
                                  setState(() {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BuyPlan(
                                      description: get_responcebody[index]['description'],
                                      img: get_responcebody[index]['image'],
                                      terms_cons: get_responcebody[index]['terms_and_conditions'],
                                       id: get_responcebody[index]['id'],
                                       features: get_responcebody[index]['features'],
                                    )));
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 60),
                                  width: MediaQuery.of(context).size.width,
                                  height: 20.0.h,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Colors.black45,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 60,right: 10.0),
                                      child: Row(
                                        children: [
                                          Flexible(
                                              child: Center(
                                                child: Text('${get_responcebody[index]['description']}',
                                                  style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.0.dp,
                                                  color: Colors.white
                                                                                            ),),
                                              )),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Flexible(
                                                  child: Text('₹ ${get_responcebody[index]['price']}',style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13.0.dp,
                                                      color: Colors.white
                                                  ),)),
                                              Flexible(
                                                  child: Text('View',style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.0.dp,
                                                      color: Colors.white
                                                  ),)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 23.0.dp,left: 5.0,
                                  child: Container(
                                      width: 100,
                                      height: 100,
                                      child: CircleAvatar(
                                          child:  ClipOval(
                                              child:
                                              Image.network('${get_responcebody[index]['image']}',
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace){
                                                  print('Error loading image: $error');
                                                  return SizedBox(
                                                    height: 2.h,
                                                    width: 4.w,
                                                    child: CircularProgressIndicator(color: Colors.black12),
                                                  );
                                                },
                                              )
                                          )
                                      )
                                  )
                              )
                            ],
                          );
                        }) :  Center(child: CircularProgressIndicator(color: Colors.white,)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
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
          Uri.parse('https://achujozef.pythonanywhere.com/api/gym-plans/'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        bool isTokenExpired = await JwtDecoder.isExpired(accessToken);
        print(isTokenExpired);

        // print('From getapi: ${accessToken}');
        //print('From PlanApi: ${get_response.statusCode}');

        if (get_response.statusCode == 200) {
          get_responcebody = await json.decode(get_response.body);
          // print('Response: $get_responcebody');
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
