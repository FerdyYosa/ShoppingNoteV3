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
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Tanggal"),
                onTap: () async {
                  final datePick = await showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime(2019),
                      lastDate: new DateTime(2026));
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Nama:"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Deskripsi:"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Total belanja:"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text("Batal"),
                  onPressed: () {},
                ),
                RaisedButton(
                  child: Text("Simpan"),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
