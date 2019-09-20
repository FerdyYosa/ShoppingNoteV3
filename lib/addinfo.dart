import 'package:flutter/material.dart';

class IsiData extends StatefulWidget {
  @override
  _IsiDataState createState() => _IsiDataState();
}

class _IsiDataState extends State<IsiData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.blue,
      leading: Icon(Icons.arrow_back),
      title: Text("Tambah Catatan"),
    ));
  }
}
