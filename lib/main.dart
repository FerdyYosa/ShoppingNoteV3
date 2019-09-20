import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => IsiData()));
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, nama) {
        if (!nama.hasData) return LinearProgressIndicator();

        return _buildList(context, nama.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> nama) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: nama.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(record.name),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text(record.votes.toString())
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: TextField(
                            autofocus: true,
                            controller: _textDataControllerDua,
                            decoration:
                                InputDecoration(labelText: "Add New Name"),
                          ),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            new FlatButton(
                              child: new Text("Add"),
                              onPressed: () {
                                Firestore.instance
                                    .collection("baby")
                                    .document(record.reference.documentID)
                                    .updateData(
                                        {"name": _textDataControllerDua.text});
                                return Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await Firestore.instance
                      .collection("baby")
                      .document(record.reference.documentID)
                      .delete();
                },
              )
            ],
          ),
          onTap: () => Firestore.instance.runTransaction((transaction) async {
            final freshSnapshot = await transaction.get(record.reference);
            final fresh = Record.fromSnapshot(freshSnapshot);
            await transaction
                .update(record.reference, {'votes': fresh.votes + 1});
          }),
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot nama)
      : this.fromMap(nama.data, reference: nama.reference);

  @override
  String toString() => "Record<$name:$votes>";
}
