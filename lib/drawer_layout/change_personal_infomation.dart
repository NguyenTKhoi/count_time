import 'package:flutter/material.dart';

class ChangePersonal extends StatefulWidget {
  @override
  _ChangePersonal createState() => _ChangePersonal();
}

class _ChangePersonal extends State<ChangePersonal> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("Change Personal Infomation"),
      )
    );
  }
}
