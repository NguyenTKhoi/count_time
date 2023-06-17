import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:trangchu/screens/Inf_device.dart';
import 'package:trangchu/screens/firebase/headle_database.dart';

class CountTime extends StatefulWidget {
  final User user;

  const CountTime(this.user);
  @override
  _CountTime createState() => _CountTime();
}

class _CountTime extends State<CountTime> {
  late AppUsageInfo _Netflix;
  late Duration _usageDuration = Duration.zero;
  late User _currentUser;
  String _email = '';
  String _UID = '';
  double Carbon = 0;

  Map<String, String> _deviceInfo = {};
  String _IDdevice = '';
  String _Modeldevice = '';
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadNetflixUsage();
    _currentUser = widget.user;
    _email = _currentUser.email.toString();
    _UID = _currentUser.uid.toString();
  }

  Future<void> _getDeviceInfo() async {
    Map<String, String> deviceData = await DeviceInfo.getDeviceInfo();
    setState(() {
      _deviceInfo = deviceData;
    });
  }

  addInfo() async {
    FirebaseService firebaseService = FirebaseService();
    //DatabaseReference ref = FirebaseDatabase.instance.ref();
    DateTime lastUse = DateTime.now();
    String formattedDate = "${lastUse.year}-${lastUse.month}-${lastUse.day}";
    _getDeviceInfo();
    _IDdevice = _deviceInfo['deviceId']!;
    _Modeldevice = _deviceInfo['deviceModel']!;
    print(firebaseService.getDataFromFirebase('USER/${_UID}/Email') == _email);
    print( _email);

    // Map<String, dynamic> data = {
    //   "Carbon emisssions": Carbon,
    //   'Model device': _Modeldevice,
    // };
    // firebaseService.addData('USER/${_UID}/${_IDdevice}', data);


    // Map<String, dynamic> data = {
    //       'Email': _email,
    //       'Last Use': formattedDate,
    //       _IDdevice: {
    //         'id': _IDdevice,
    //         'Model device': _Modeldevice,
    //         "Carbon emisssions": Carbon,
    //
    //       }};
    //  firebaseService.addData('USER/${_UID}', data);
    if (firebaseService.getDataFromFirebase('USER/${_UID}/Email') == _email) {
      Map<String, dynamic> data = {
        _IDdevice: {
          'id': _IDdevice,
          'Model device': _Modeldevice,
          "Carbon emisssions": Carbon,

        }};
      firebaseService.addData('USER/${_UID}', data);
    } else {
      Map<String, dynamic> data = {
        'Email': _email,
        'Last Use': formattedDate,
        _IDdevice: {
          'Model devicee': _Modeldevice,
          "Carbon emisssions": Carbon,
        },
      };
      await firebaseService.addData('USER/${_UID}', data);
    }
  }

  Future<void> _loadNetflixUsage() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(Duration(days: now.month.toInt()));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);

      for (var info in infoList) {
        if (info.packageName == 'com.netflix.mediaclient') {
          setState(() {
            _Netflix = info;
            _usageDuration = _Netflix.usage;
            Carbon = _usageDuration.inSeconds * 0.225;

          });
          break;
        }
      }
      addInfo();
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Using Netflix in the past month: ${_usageDuration.inMinutes} minutes',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Text(
              'Carbon emissions equivalent to approximately: ${Carbon.toStringAsFixed(2)}g CO2',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            // TextButton(
            //     onPressed: () {
            //       addInfo();
            //     },
            //     child: Text('upload'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadNetflixUsage,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
