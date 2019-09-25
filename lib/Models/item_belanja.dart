import 'dart:convert';

class ItemBelanja {
    String tanggal;
    String nama;
    String deskripsi;
    int totalBelanja;

    ItemBelanja({
        this.tanggal,
        this.nama,
        this.deskripsi,
        this.totalBelanja,
    });

    factory ItemBelanja.fromJson(String str) => ItemBelanja.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ItemBelanja.fromMap(Map<String, dynamic> json) => ItemBelanja(
        tanggal: json["Tanggal"],
        nama: json["Nama"],
        deskripsi: json["Deskripsi"],
        totalBelanja: json["Total belanja"],
    );

    Map<String, dynamic> toMap() => {
        "Tanggal": tanggal,
        "Nama": nama,
        "Deskripsi": deskripsi,
        "Total belanja": totalBelanja,
    };
}
