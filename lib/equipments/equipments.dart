import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:gymsoft/login/api.dart';
import 'package:gymsoft/shared/bottom_nav_bar.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Equipments extends StatefulWidget {
  const Equipments({super.key});

  @override
  State<Equipments> createState() => _EquipmentsState();
}

class _EquipmentsState extends State<Equipments> {

  final Api _api = Api();

  var accessToken;

  var get_response;

  var get_responcebody;

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
  void dispose() {
    mounted;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(builder: (context, mainScreenNotifier, child){
      return  Scaffold(
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
                          image: AssetImage("assets/female_bg.jpg"),fit: BoxFit.cover
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
                              Text("Equipments",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                            ],
                          )
                      ),
                      Container(
                        height: 85.0.h,
                        //width: width,
                        child: get_responcebody != null ? ListView.builder(
                            itemCount: get_responcebody.length,
                            itemBuilder: (BuildContext context, int index){
                              return Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 60),
                                    width: MediaQuery.of(context).size.width,
                                    height: 25.0.h,
                                    //color: Colors.black,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: Colors.black45,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 60,right: 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Flexible(child: Text('${get_responcebody[index]['name']}',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.white
                                            ),)),
                                            Flexible(
                                                flex: 5,
                                                child: Text('${get_responcebody[index]['additional_notes']}',style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11.0.dp,
                                                    color: Colors.white
                                                ),)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 35.0.dp,left: 5.0,
                                      child: Container(
                                        width: 110,
                                        height: 110,
                                        child: CircleAvatar(
                                            child:  get_responcebody != null ? ClipOval(
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
                                            ) : SizedBox(
                                                height: 2.h,width: 4.w,
                                                child: CircularProgressIndicator(color: Colors.black12,)
                                            )
                                        )
                                      )
                                  )
                                ],
                              );
                            }) : Center(child: CircularProgressIndicator(color: Colors.white,)),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      );
    }
    );
  }

  getApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');

    try {

      if(accessToken != null){
        get_response = await http.get(
          Uri.parse('https://achujozef.pythonanywhere.com/api/list-equipment/'),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        );

        bool isTokenExpired = await JwtDecoder.isExpired(accessToken);
        print(isTokenExpired);

        print('From getapi: ${accessToken}');
        print('From equipmentapi: ${get_response.statusCode}');

        if (get_response.statusCode == 200) {
          get_responcebody = await json.decode(get_response.body);
          print('Response: $get_responcebody');
        }
        else if(isTokenExpired)  {
          _api.refreshtoken();
          //refreshtoken();
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
