import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final databaseRef = FirebaseDatabase.instance;
  final database = FirebaseDatabase.instance;
  Future<void> addData(String path, Map<String, dynamic> data) async {
    await databaseRef.ref().child(path).set(data);
  }
  Future<void> ADDData(String path, Map<String, dynamic> data) async {
    await databaseRef.ref().child(path).push().set(data);
  }

  Future<String> getDataFromFirebase(String value) async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child(value).get();
    if (snapshot.exists) {
     // print(snapshot.value);
    } else {
      print('No data available.');
    }
    return snapshot.value.toString();
  }

  Future<Object?> getFulldata(String value) async {

    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child(value).get();
    if (snapshot.exists) {
      //print(snapshot.value);
    } else {
      print('No data available.');
    }
    return snapshot.value;
  }

  Future<void> UpDateData(String path, Map<String, dynamic> data) async{
    await databaseRef.ref().update(data);
  }

}
