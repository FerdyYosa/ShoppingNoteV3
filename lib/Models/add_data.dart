import 'dart:convert';

class AddData {
    String tanggal;
    int jumlahBelanja;
    int totalBelanja;

    AddData({
        this.tanggal,
        this.jumlahBelanja,
        this.totalBelanja,
    });

    factory AddData.fromJson(String str) => AddData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddData.fromMap(Map<String, dynamic> json) => AddData(
        tanggal: json["Tanggal"],
        jumlahBelanja: json["Jumlah belanja"],
        totalBelanja: json["Total belanja"],
    );

    Map<String, dynamic> toMap() => {
        "Tanggal": tanggal,
        "Jumlah belanja": jumlahBelanja,
        "Total belanja": totalBelanja,
    };
}
