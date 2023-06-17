import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DataUse extends StatefulWidget {
  final String uid;
  const DataUse({required this.uid});

  @override
  _DataUseState createState() => _DataUseState();
}

class _DataUseState extends State<DataUse> {
  late List<Map<String, dynamic>> _scannedObjects;

  Future<void> getAllData() async {
    final databaseRef =
    FirebaseDatabase.instance.reference().child('USER/${widget.uid}');
    final snapshot = await databaseRef.once();
    final event = await databaseRef.once();
    final data = event.snapshot.value as Map<dynamic, dynamic>?;
    if (data != null) {
      setState(() {
        _scannedObjects = data.entries
            .map((entry) => {
          'Email': data['Email'],
          'Carbon emissaries': entry.value['Carbon emissaries']
        })
            .toList();
      });
    } else {
      setState(() {
        _scannedObjects = [];
      });
    }
  }
  void _getData() async {
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
    final event = await databaseReference.once();
    databaseReference.child('USER/${widget.uid}').onValue.listen((event) {
      final Map<dynamic, dynamic> data = event.snapshot.value as Map;
      if (data != null) {
        setState(() {
          _scannedObjects = data.values.map((value) =>
          'Email: ${value['Email']}, Carbon Emissions: ${value['_IDdevice']['Carbon emissaries']}').cast<Map<String, dynamic>>().toList();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _scannedObjects = [];
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: _scannedObjects.isNotEmpty
            ? ListView.builder(
          itemCount: _scannedObjects.length,
          itemBuilder: (context, index) {
            final scannedObject = _scannedObjects[index];
            return ListTile(
              title: Text('Email: ${scannedObject['Email']}'),
              subtitle: Text(
                  'Carbon emissaries: ${scannedObject['Carbon emissaries']}'),
            );
          },
        )
            : const Text('No scanned objects yet'),

      );
  }
}
