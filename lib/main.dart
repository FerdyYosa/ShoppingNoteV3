import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_note/Models/add_data.dart';
import 'package:shopping_note/Models/item_belanja.dart';
import 'package:shopping_note/addinfo.dart';

void main() => runApp(MyApp());

final namaBayi = [
  {"name": "Abdullah", "votes": 15},
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nama Bayi',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textDataController = TextEditingController();
  TextEditingController _textDataControllerDua = TextEditingController();

  _tampilkanDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              autofocus: true,
              controller: _textDataController,
              decoration: InputDecoration(labelText: "Add New Name"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("Add"),
                onPressed: () {
                  Firestore.instance
                      .collection("baby")
                      .document(_textDataController.text)
                      .setData({"name": _textDataController.text, "votes": 0});
                  return Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rekap Belanja'),
        backgroundColor: Colors.green,
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => IsiData()));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Belanja').snapshots(),
      builder: (context, nama) {
        if (!nama.hasData) return LinearProgressIndicator();

        return _buildList(context, nama.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> addData) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: addData.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record =
        AddData.fromMap(data.data); /*Record.fromSnapshot(data);*/
    return Padding(
      key: ValueKey(record.tanggal),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            leading: Row(
              children: <Widget>[
                Icon(Icons.monetization_on),
              ],
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(record.tanggal),
              ],
            ),
            trailing: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.navigate_next),
                  onPressed: () {},
                )
              ],
            )),
      ),
    );
  }
}