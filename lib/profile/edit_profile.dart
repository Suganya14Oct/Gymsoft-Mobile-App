import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:gymsoft/home_page/main_screen.dart';
import 'package:gymsoft/profile/profile.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {

  final List<dynamic> apiData;

  const EditProfile({required this.apiData, super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  File? _selectedImage;

  var accesstoken;

  var refresh_response;

  var Token;

  var accessToken;

  var put_response;

  var put_responcebody;

  final strg = SharedPreferences.getInstance();

  final sharedPreferences =   SharedPreferences.getInstance();
  var ObtainedaccesstToken;

  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose(){
    _weightController.dispose();
    _heightController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();

  }

  void func() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var ObtainedaccesstToken= sharedPreferences.getString('accessToken');
    setState(() {
      accesstoken = ObtainedaccesstToken;
    });
  }

  @override
  void initState() {
    print('from edit profile:');
    print(widget.apiData[2]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<MainScreenNotifier>(builder: (context, mainScreenNotifier, child){
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
                            image: AssetImage("assets/male_background.jpeg"),fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Container(
                    height: height,
                    width: width,
                    child: Column(
                      children: [
                        Container(
                          height: 45.h,
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
                                    onTap : () async {
                                        print('print');
                                        final  sharedPreferences = await SharedPreferences.getInstance();
                                        var ObtainedaccesstToken= sharedPreferences.getString('accessToken');
                                        setState(() {
                                          accesstoken = ObtainedaccesstToken;
                                          print('splash Screen : $accesstoken');
                                        });
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(token: '$accesstoken')));
                                    },
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        height: 10.0.h,
                                        width: 10.0.w,
                                        //color: Colors.red,
                                        child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20.dp,)
                                    ),
                                  ),
                                  Text("Edit Profile",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0,right: 15.0,),
                                    height: 105,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: _selectedImage == null ? Colors.lightBlueAccent : Colors.transparent,
                                        borderRadius: BorderRadius.circular(100)
                                      //more than 50% of width makes circle
                                    ),
                                    child: Stack(
                                      children: [
                                        _selectedImage != null ?
                                        CircleAvatar(
                                          //backgroundColor: Colors.blueGrey,
                                            radius: 100.0,
                                            backgroundImage: FileImage(_selectedImage!)
                                        ) : SizedBox(),
                                        Positioned(
                                            height: 150,left: 10.0,top: 10.0,
                                            child: InkWell(
                                              onTap: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context){
                                                      return AlertDialog(
                                                        backgroundColor: Colors.white70,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(32.0))
                                                        ),
                                                        content: Text("Choose Any One",style: TextStyle(
                                                            fontSize: 14.0.dp
                                                        ),),
                                                        actions: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            children: [
                                                              InkWell(
                                                                onTap : (){
                                                                  setState(() {
                                                                    _pickImageFromCamera();
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                                child: Container(
                                                                    height: height * 0.1,
                                                                    width: width * 0.3,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.black54,
                                                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        Icon(Icons.camera_alt,color: Colors.white),
                                                                        Column(
                                                                          children: [
                                                                            Text("Click to",style: TextStyle(color: Colors.white,fontSize: 11.0.dp),),
                                                                            Text("snap a shot",style: TextStyle(color: Colors.white,fontSize: 11.0.dp),),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    )),
                                                              ),
                                                              InkWell(
                                                                onTap: (){
                                                                  setState(() {
                                                                    _pickImageFromGallery();
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                                child: Container(
                                                                    height: height * 0.2,
                                                                    width: width * 0.3,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors.black54,
                                                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                                                    ),
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                      children: [
                                                                        Icon(Icons.image,color: Colors.white),
                                                                        Column(
                                                                          children: [
                                                                            Text("Pick an image",style: TextStyle(color: Colors.white,fontSize: 11.0.dp),),
                                                                            Text("from gallery",style: TextStyle(color: Colors.white,fontSize: 11.0.dp),),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Color(0xffd41012),
                                                child: Icon(Icons.edit,color: Colors.white,),),
                                            )
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 80.dp,
                                        width: 240.dp,
                                        //color: Colors.blueGrey,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            onTap: (){
                                              setState(() {

                                              });
                                            },
                                            style: TextStyle(
                                                color: Colors.white70,fontFamily: 'Telex',fontSize: 14.5.dp
                                            ),
                                            controller: _nameController,
                                            cursorColor: Colors.grey,
                                            decoration: InputDecoration(
                                              fillColor: Colors.black26,
                                              filled: true,
                                              contentPadding: EdgeInsets.all(15.0),
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
                                              prefixIcon: Icon(Icons.person, color: Colors.white,),

                                              label: Text(widget.apiData[2].toString(),style: TextStyle(
                                                  color:Colors.white70,fontSize: 15.0.dp
                                              ),
                                              ),
                                            ),
                                            validator: (value){
                                              if(value == null || value.isEmpty){
                                                return "Please enter your Name";
                                              }else if(value.length < 4){
                                                return "Enter atleast 4 letters";
                                              }return null;
                                            }
                                        ),
                                      ),
                                      Container(
                                        height: 80.dp,
                                        width: 240.dp,
                                        //color: Colors.blueGrey,
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                            onTap: (){
                                              setState(() {

                                              });
                                            },
                                            style: TextStyle(
                                                color: Colors.white70,fontFamily: 'Telex',fontSize: 14.5.dp
                                            ),
                                            controller: _nameController,
                                            cursorColor: Colors.grey,
                                            decoration: InputDecoration(
                                              fillColor: Colors.black26,
                                              filled: true,
                                              contentPadding: EdgeInsets.all(15.0),
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
                                              prefixIcon: Icon(Icons.person, color: Colors.white,),

                                              label: Text(widget.apiData[3].toString(),style: TextStyle(
                                                  color:Colors.white70,fontSize: 15.0.dp
                                              ),
                                              ),
                                            ),
                                            validator: (value){
                                              if(value == null || value.isEmpty){
                                                return "Please enter your Name";
                                              }else if(value.length < 4){
                                                return "Enter atleast 4 letters";
                                              }return null;
                                            }
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              //SizedBox(height: height * 0.05,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Icon(Icons.monitor_weight,color: Colors.white,size: 35.dp,),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Container(
                                            height: 20.dp,
                                            width: 55.dp,
                                            // color: Colors.blueGrey,
                                            alignment: Alignment.center,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: 52,bottom: 1,
                                                  child: Container(
                                                      height: 10,
                                                      //color: Colors.red,
                                                      child: Icon(Icons.edit,color: Colors.white,size: 10.0.dp,)),
                                                ),
                                                TextFormField(
                                                  onTap: (){
                                                    setState(() {

                                                    });
                                                  },
                                                  style: TextStyle(
                                                      color: Colors.white70,fontFamily: 'Telex',fontSize: 10.0.dp
                                                  ),
                                                  keyboardType: TextInputType.number,
                                                  controller: _weightController,
                                                  cursorColor: Colors.grey,
                                                  cursorHeight: 10.0.dp,
                                                  cursorWidth: 1.5.dp,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.black26,
                                                    filled: true,
                                                    contentPadding: EdgeInsets.all(15.0),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.white70,
                                                        )
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.white),
                                                        borderRadius: BorderRadius.circular(5.0)
                                                    ),
                                                    label: Text(widget.apiData[1].toString(),style: TextStyle(
                                                        color:Colors.white70,fontSize: 7.2.dp
                                                    ),
                                                    ),
                                                  ),
                                                  // validator: (value){
                                                  //   if(value == null || value.isEmpty){
                                                  //     return "Please enter your Name";
                                                  //   }else if(value.length > 3){
                                                  //     return "Enter atleast 4 letters";
                                                  //   }return null;
                                                  // }
                                                ),

                                              ],
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.height,color: Colors.white,size: 35.dp,),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Container(
                                            height: 20.dp,
                                            width: 55.dp,
                                            // color: Colors.blueGrey,
                                            alignment: Alignment.center,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: 52,bottom: 1,
                                                  child: Container(
                                                      height: 10,
                                                      //color: Colors.red,
                                                      child: Icon(Icons.edit,color: Colors.white,size: 10.0.dp,)),
                                                ),
                                                TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  onTap: (){
                                                    setState(() {

                                                    });
                                                  },
                                                  style: TextStyle(
                                                      color: Colors.white70,fontFamily: 'Telex',fontSize: 10.0.dp
                                                  ),
                                                  controller: _heightController,
                                                  cursorColor: Colors.grey,
                                                  cursorHeight: 10.0.dp,
                                                  cursorWidth: 1.5.dp,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.black26,
                                                    filled: true,
                                                    contentPadding: EdgeInsets.all(15.0),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.white70,
                                                        )
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.white),
                                                        borderRadius: BorderRadius.circular(5.0)
                                                    ),
                                                    label: Text(widget.apiData[2].toString(),style: TextStyle(
                                                        color:Colors.white70,fontSize: 7.3.dp
                                                    ),
                                                    ),
                                                  ),
                                                  // validator: (value){
                                                  //   if(value == null || value.isEmpty){
                                                  //     return "Empty";
                                                  //   }else if(value.length > 3){
                                                  //     return "Empty";
                                                  //   }return null;
                                                  // }
                                                ),
                                              ],
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Icon(Icons.perm_contact_calendar_sharp,color: Colors.white,size: 35.dp,),
                                      Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Container(
                                            height: 20.dp,
                                            width: 55.dp,
                                            // color: Colors.blueGrey,
                                            alignment: Alignment.center,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  right: 52,
                                                  bottom: 1,
                                                  child: Container(
                                                      height: 10,
                                                      //color: Colors.red,
                                                      child: Icon(Icons.edit,color: Colors.white,size: 10.0.dp,)),
                                                ),
                                                TextFormField(
                                                  onTap: (){
                                                    setState(() {

                                                    });
                                                  },
                                                  style: TextStyle(
                                                      color: Colors.white70,fontFamily: 'Telex',fontSize: 10.0.dp
                                                  ),
                                                  keyboardType: TextInputType.number,
                                                  controller: _ageController,
                                                  cursorColor: Colors.grey,
                                                  cursorHeight: 10.0.dp,
                                                  cursorWidth: 1.5.dp,
                                                  decoration: InputDecoration(
                                                    fillColor: Colors.black26,
                                                    filled: true,
                                                    contentPadding: EdgeInsets.all(15.0),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.white70,
                                                        )
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.white),
                                                        borderRadius: BorderRadius.circular(5.0)
                                                    ),
                                                    label: Text('Age',style: TextStyle(
                                                        color:Colors.white70,fontSize: 10.0.dp
                                                    ),
                                                    ),
                                                  ),
                                                  // validator: (value){
                                                  //   if(value == null || value.isEmpty){
                                                  //     return "Please enter your Name";
                                                  //   }else if(value.length > 3){
                                                  //     return "fill correct age";
                                                  //   }return null;
                                                  // }
                                                ),
                                              ],
                                            ),
                                          )
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
                                          child: Text('50',textAlign: TextAlign.center,style: TextStyle(
                                              color: Colors.white,fontSize: 18.dp
                                          ),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text('WorkOut',style: TextStyle(color: Colors.white,fontSize: 11.dp),),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0.h,
                        ),
                        Container(
                          height: height * 0.06,
                          width: width * 0.25,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffd41012),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.0)
                                )
                            ),
                            onPressed: () async{

                              if(_ageController.text.toString() == null || _ageController.text.toString().isEmpty ||
                                  _weightController.text.toString() == null || _weightController.text.toString().isEmpty ||
                                  _heightController.text.toString() == null || _heightController.text.toString().isEmpty
                              ){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text( "Please fill all the fields"),backgroundColor: Color(0xffd41012),)
                                );
                              }else if(_ageController.text.toString().length > 3 ){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text( "Enter Correct Age"))
                                );
                              }
                              if(_formkey.currentState!.validate()) {
                                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                var ObtainedaccesstToken= sharedPreferences.getString('accessToken');
                                setState(() {
                                  accessToken = ObtainedaccesstToken;
                                  print('put_Api clicked');
                                  putApi();
                                  //mainScreenNotifier.pageIndex = 3;
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(token: '$accessToken')));
                                });
                              }
                            },
                            child: Text("Save",style: TextStyle(fontSize: 15.0.dp,color: Colors.white)),),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    }

    );
  }

  Future _pickImageFromGallery() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if(returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
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


  putApi({String? weight, height, firstName, lastName, age, image}) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('accessToken');
    print(accessToken);

    try {

      if(accessToken != null){
        put_response = await http.MultipartRequest(
          'PUT',
          Uri.parse('https://achujozef.pythonanywhere.com/api/user-profile/edit/'),
        );

        put_response.files.add(await http.MultipartFile.fromPath('img', _selectedImage!.path.toString()));

        put_response.headers.addAll({
          'Authorization' : 'Bearer $accessToken',
          'Content-type' : 'multipart/form-data',
        });

        if(weight != null){
          put_response.fields['weight'] = widget.apiData[0].toString();
        }

        if(height != null){
          put_response.fields['height'] = widget.apiData[1].toString();
        }

        if(firstName != null){
          put_response.fields['first_name'] = widget.apiData[2].toString();
        }

        if(lastName != null){
          put_response.fields['last_name'] = widget.apiData[3].toString();
        }

        if(age != null){
          put_response.fields['age'] = widget.apiData[4].toString();
        }


        final http.StreamedResponse streamedresponse = await put_response.send();
        final http.Response response = await http.Response.fromStream(streamedresponse);


        bool isTokenExpired = await JwtDecoder.isExpired(accessToken);
        print(isTokenExpired);

        print('From putapi: ${accessToken}');
        print('From putapi: ${response.statusCode}');

        if (response.statusCode == 401) {
          await refreshtoken();
        }
        await putApi(
          weight: weight,
          height: height,
          firstName: firstName,
          lastName: lastName,
          age: age,
          image: image,
        );
      }
    } catch (e) {
      // Handle exceptions or network errors
      print('Exception: $e');
    }
  }

}

//gjsdhjsdsjdkj
