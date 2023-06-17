import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  final User user;
  const MyWidget(this.user);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late DatabaseReference _databaseReference;
  List<String> _scannedObjects = [];
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.reference();
    _currentUser = widget.user;
    _listenToData();
  }

  void _listenToData() {
    _databaseReference.child("USER/${_currentUser.uid.toString()}").onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? data = event.snapshot.value as Map?;
        List<String> carbonEmissionsList = [];
        data!.forEach((key, value) {
          if (key == "Email") {
            _scannedObjects.add("Email: $value");
          } else if (value is Map<String, dynamic>) {
            String? modelDevice = value["Model device"];
            if (modelDevice != null) {
              String idDevice = key;
              double? carbonEmissions = value["Carbon emissaries"]?.toDouble();
              if (carbonEmissions != null) {
                carbonEmissionsList.add("ID Device: $idDevice, Model Device: $modelDevice, Carbon Emissions: $carbonEmissions");
              }
            }
          }
        });
        _scannedObjects.addAll(carbonEmissionsList);
        setState(() {});
      }
    });
  }

  void _refreshData() {
    setState(() {
      _scannedObjects.clear();
    });
    _listenToData();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: _scannedObjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_scannedObjects[index]),
          );
        },
      );
  }
}
