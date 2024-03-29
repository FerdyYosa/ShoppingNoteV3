import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_note/Models/add_data.dart';
import 'package:shopping_note/Models/item_belanja.dart';
import 'package:shopping_note/main.dart';

class IsiData extends StatefulWidget {
  @override
  _IsiDataState createState() => _IsiDataState();
}

class _IsiDataState extends State<IsiData> {
  final _kunciFormulir = GlobalKey<FormState>();
  String nama;
  String tanggal;
  String deskripsi;
  int totalbelanja;
  int jumlahbelanja;

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
          key: _kunciFormulir,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: DateTimeField(
                    readOnly: true,
                    decoration: InputDecoration(labelText: "Tanggal"),
                    initialValue: DateTime.now(),
                    format: formatTanggal,
                    onSaved: (t) {
                      tanggal = formatTanggal.format(t);
                    },
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
                    onSaved: (n) {
                      nama = n;
                    }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(labelText: "Deskripsi:"),
                    onSaved: (d) {
                      deskripsi = d;
                    }),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                  child: TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(labelText: "Total belanja:"),
                    onSaved: (tb) {
                      totalbelanja = int.parse(tb);
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Batal"),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text("Simpan"),
                    onPressed: () async {
                      var formulir = _kunciFormulir.currentState;
                      formulir.save();
                      simpan(tanggal, nama, deskripsi, totalbelanja,
                          jumlahbelanja);
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (MyHomePage())));
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
var a = Firestore.instance.collection("Belanja").document(tanggal).collection(collectionPath);
  void simpan(String tanggal, String nama, String deskrip, int totalbelanja,
      int jumlahbelanja) {
    ItemBelanja itemBelanja = ItemBelanja(
        tanggal: tanggal,
        nama: nama,
        deskripsi: deskrip,
        totalBelanja: totalbelanja);
    AddData addData = AddData(
        tanggal: tanggal,
        jumlahBelanja: 0,
        totalBelanja: totalbelanja);
    var dbItem = Firestore.instance
        .collection("Belanja")
        .document(tanggal)
        .collection(tanggal);
    dbItem.document(nama).setData(itemBelanja.toMap());
    var dbHarian = Firestore.instance
        .collection("Belanja")
        .document(tanggal)
        .setData(addData.toMap());
        
  }
}
