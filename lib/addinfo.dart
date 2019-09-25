import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IsiData extends StatefulWidget {
  @override
  _IsiDataState createState() => _IsiDataState();
}

class _IsiDataState extends State<IsiData> {
  @override
  Widget build(BuildContext context) {
    final formatTanggal = DateFormat("dd-MM-yyyy");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text("Tambah Catatan"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: DateTimeField(
                    readOnly: true,
                    decoration: InputDecoration(labelText: "Tanggal"),
                    initialValue: DateTime.now(),
                    format: formatTanggal,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(2010),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(2026));
                    }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                child: TextFormField(
                  decoration: InputDecoration(labelText: "Nama:"),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(labelText: "Deskripsi:"),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
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
                    onPressed: () {
                      
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

