import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymsoft/controller/mainscreen_provider.dart';
import 'package:gymsoft/home_page/diet.dart';
import 'package:gymsoft/home_page/home_page.dart';
import 'package:gymsoft/profile/profile.dart';
import 'package:gymsoft/home_page/settings.dart';
import 'package:gymsoft/login/api.dart';
import 'package:gymsoft/shared/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {

  final token;

  const MainScreen({@required this.token,super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final Api _api = Api();
  List<Widget>? pageList;

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('accessToken');
      print('Data from splash Screen : ${widget.token}');
      // Initialize pageList here after widget is fully initialized
      pageList = [
        HomePage(token: widget.token),
        Diet(),
        Settings(),
        Profile()
      ];

    });
  }

  // List<Widget> pageList = [
  //   HomePage(token: widget.token,),Diet(),Settings(),Profile()
  // ];

  String? accessToken;

  @override
  void initState() {
    _loadToken();
    super.initState();
  }

  // Future<void> _loadToken() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     print('data from splash Screen : ${widget.token}');
  //     accessToken = prefs.getString('accessToken');
  //   });
  // }

  @override
  Widget build(BuildContext context) {


    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child){
        return WillPopScope(
          onWillPop: () async {
            final SharedPreferences sharedPrefereces = await SharedPreferences.getInstance();
            sharedPrefereces.setString("accessToken", widget.token);

            if(widget.token != null){
              setState(() {
                _back(context);
              });
            }else{
              setState(() {
                SystemNavigator.pop();
              });
            }
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                if (pageList != null) pageList![mainScreenNotifier.pageIndex] ?? Container(),
                //pageList![mainScreenNotifier.pageIndex],
                BottomNavBar()
              ],
            ),
          ),
        );
      },
    );
  }

  _back(context) {

    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Text("Do you want to Exit??"),
            actions: [
              TextButton(
                  onPressed: () async {
                    final SharedPreferences sharedPrefereces = await SharedPreferences.getInstance();
                    sharedPrefereces.setString("accessToken", widget.token);
                    SystemNavigator.pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
            ],
          );
        });
  }

}
