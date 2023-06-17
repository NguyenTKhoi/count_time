

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trangchu/test.dart';
import 'Count_Time.dart';
import 'package:url_launcher/url_launcher.dart';
import 'drawer_layout/change_personal_infomation.dart';
import 'screens/login.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';



class MyStatefulWidget extends StatefulWidget {
  final User user;
  const MyStatefulWidget({super.key, required this.user });
   @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
  }

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int poss=0;
  late User _currentUser;
  final Uri _url = Uri.parse('https://www.mdpi.com/2071-1050/14/4/2195');
  getBodyWidget(int pos){
    switch(poss){
      case 0: return ChangePersonal();
    }
  }
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  int _currentIndex=0;
  @override
  void initState(){
    super.initState();
    _currentIndex=0;
    poss = 0;
    _currentUser = widget.user;
  }
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Netflix Carbon Emissions'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              FeatherIcons.helpCircle,
              color: Colors.white,
              size: 20,
                textDirection: TextDirection.ltr
            ),
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Center(
                     child: Image.asset(
                       "assets/traidatdep.jpg",
                       fit: BoxFit.cover,
                     ),
                 )
            ),
            // ListTile(
            //   title: Text('Insights on Carbon Emissions from Netflix'),
            //   leading: Icon(Icons.supervised_user_circle),
            //   onTap: (){
            //     // setState(() {
            //     //   Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePersonal()));
            //     // });
            //     // _scaffoldKey.currentState?.openEndDrawer();
            //     _launchUrl();
            //   },
            // ),
            ListTile(
              title: Text('Log Out'),
              leading: Icon(Icons.logout),
              onTap: ()async {
                final ConfirmAction action =
                (await _asyncConfirmDialog(context)) as ConfirmAction;
                print("Confirm Action $action");
              },
            )
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index){
          setState(() {_currentIndex = index;});},
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home),
            label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.align_vertical_bottom),
            label: 'Contest',),
        ],
      ),
      body: bodyWidget(_currentIndex,_currentUser),

    );
  }
}

bodyWidget(int pos,User user) {
  switch(pos){
    case 0: return CountTime(user);
    case 1: return MyWidget(user);
  }
}


enum ConfirmAction { Cancel, Accept }

Future<Future<ConfirmAction?>> _asyncConfirmDialog(BuildContext context) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('Do you want to sign out?'),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.Cancel);
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  LoginScreen()), (Route<dynamic> route) => false);
            },
          )
        ],
      );
    },
  );
}
