import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:gymsoft/home_page/home_page.dart';
import 'package:gymsoft/home_page/main_screen.dart';
import 'package:gymsoft/plan/plan.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Paymnt extends StatefulWidget {

   int? id;
   Paymnt({super.key, required this.id});

  @override
  State<Paymnt> createState() => _PaymntState();
}

class _PaymntState extends State<Paymnt> {

  File? _selectedImage;

  final _formkey = GlobalKey<FormState>();
  final _UpiController = TextEditingController();

  String? pending = 'pending';

  String? fileExtension;


  @override
  void dispose(){

    _UpiController.dispose();
    super.dispose();

  }

  var responce;
  var responcebody;

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
            Form(
              key: _formkey,
              child: Container(
                height: height,
                width: width,
                child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                      //Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                                    });
                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      height: 10.0.h,
                                      width: 10.0.w,
                                      child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20.dp,)
                                  ),
                                ),
                                Text("Payment",style: TextStyle(color: Colors.white,fontSize: 25.dp ),)
                              ],
                            )
                        ),
                        Container(
                          //alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 5.0.w,top: 30.0),
                          //color: Colors.amber,
                          child: Text('Upload Screenshot of your Payment',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 14.0.dp,
                                color: Colors.white
                            ),
                          ),
                        ),
                        Container(
                          height: 5.h,
                          width: width,
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.only(right: 30.0),
                          //color: Colors.amber,
                          child: Text('Required*',
                            style: TextStyle(color: Colors.white,
                                fontFamily: 'Telex',fontSize: 12.0.dp),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              _pickImageFromGallery();
                            });
                          },
                          child: _selectedImage  != null ?
                          Container(
                              height: 30.h,
                              width: 35.w,
                              margin: EdgeInsets.only(left: 30.0.w, top: 2.0.h),
                              //padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                  border: Border.fromBorderSide(BorderSide(
                                      color: Colors.white12
                                  )),
                                  //borderRadius: BorderRadius.all(Radius.circular(20.0))
                              ),
                              child:  Image.file(_selectedImage!,fit: BoxFit.fill,)
                          )  :
                          Container(
                            height: 30.h,
                            width: 35.w,
                            margin: EdgeInsets.only(left: 30.0.w, top: 2.0.h),
                            //padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                border: Border.fromBorderSide(BorderSide(
                                    color: Colors.white
                                )),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image,color: Colors.white),
                                  Text("Upload Here",style: TextStyle(color: Colors.white,fontSize: 11.0.dp),)
                                ],
                              ),
                            )
                          ),
                        ),
                        Container(
                          //alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 5.0.w,top: 30.0),
                          //color: Colors.amber,
                          child: Text('Upload Your UPI ID',
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                                fontSize: 14.0.dp,
                                color: Colors.white
                            ),
                          ),
                        ),
                        Container(
                          height: 5.h,
                          width: width,
                          alignment: Alignment.bottomRight,
                          padding: EdgeInsets.only(right: 30.0),
                          //color: Colors.amber,
                          child: Text('Required*',
                            style: TextStyle(color: Colors.white,
                                fontFamily: 'Telex',fontSize: 12.0.dp),
                          ),
                        ),
                        Container(
                          height: 120.dp,
                          width: 290.dp,
                          margin: EdgeInsets.only(left: 5.0.w),
                          //color: Colors.blueGrey,
                          alignment: Alignment.center,
                          child: TextFormField(
                            enableInteractiveSelection: false,
                              style: TextStyle(
                                  color: Colors.white70,fontFamily: 'Telex',fontSize: 14.5.dp
                              ),
                              controller: _UpiController,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                fillColor: Colors.black26,
                                filled: true,
                                contentPadding: EdgeInsets.all(15.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.white70,
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(25.0)
                                ),
                                label: Text('UPI ID',style: TextStyle(
                                    color:Colors.white70,fontSize: 12.0.dp
                                ),
                                ),
                              ),
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "Please enter your phone number";
                                }return null;
                              }
                          ),
                        ),
                        Container(
                          height: height * 0.06,
                          width: 30.0.w,
                          margin: EdgeInsets.only(left: 30.0.w),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xffd41012),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.0)
                                )
                            ),
                            onPressed: () {
                              setState(() {
                                print('submit button: ${widget.id}');
                                print('upi: ${_UpiController.text.toString()}');
                                print('selectedImage: ${_selectedImage}');
                                print(pending);
                                paymentApi(widget.id,_UpiController.text.toString(),_selectedImage,'pending',context);
                              });
                            },
                            child: Text("Submit",style: TextStyle(fontSize: 15.0.dp,color: Colors.white)),),
                        ),
                      ],
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future _pickImageFromGallery() async{

    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(returnedImage == null) return;

    final List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
     fileExtension = returnedImage.path.split('.').last.toLowerCase();

    if (!imageExtensions.contains(fileExtension)) {
     print("It is not an image File");
      return;
    }

    setState(() {
      _selectedImage = File(returnedImage.path);
      print(returnedImage);

    });
  }

  Future<void> paymentApi(int? id, String? upi_id, screenshot, status, BuildContext context) async {
    try{
      responce = await http. post(
          Uri.parse('https://achujozef.pythonanywhere.com/api/payments/create/'),
          body:  {
            "gym_plan": id.toString(),
            "transaction_id": upi_id.toString(),
            "screenshot": screenshot.toString(),
            "status": status.toString()
          }
      );

      print('from paymentApi: ${responce.statusCode}');

      if(responce.statusCode == 201){
        responcebody = json.decode(responce.body);
        print(responcebody);
        print('Upi: ${_UpiController.text.toString()}');
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
      }

    }catch (e){
      print(e.toString());
    }
  }

}

