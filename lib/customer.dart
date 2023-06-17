import 'package:flutter/material.dart';


class PageCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PageCustomer();
}

class _PageCustomer extends State<PageCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextButton(
              onPressed: () {},
              child: const Text('Change personal information')),
          TextButton(
              onPressed: () async {
                final ConfirmAction action =
                    (await _asyncConfirmDialog(context)) as ConfirmAction;
                print("Confirm Action $action");
              },
              child: const Text('LogOut')),
        ],
      ),
    );
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
              Navigator.of(context).pop(ConfirmAction.Accept);
            },
          )
        ],
      );
    },
  );
}

