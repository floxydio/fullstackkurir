// To parse this JSON data, do
//
//     final kurirHistory = kurirHistoryFromJson(jsonString);

import 'dart:convert';

KurirHistory kurirHistoryFromJson(String str) =>
    KurirHistory.fromJson(json.decode(str));

String kurirHistoryToJson(KurirHistory data) => json.encode(data.toJson());

class KurirHistory {
  KurirHistory({
    this.message,
    this.data,
  });

  String? message;
  List<KurirData>? data;

  factory KurirHistory.fromJson(Map<String, dynamic> json) => KurirHistory(
        message: json["message"],
        data: List<KurirData>.from(
            json["data"].map((x) => KurirData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class KurirData {
  KurirData({
    this.id,
    this.namabarang,
    this.harga,
    this.dari,
    this.ke,
    this.ekspedisi,
    this.status,
  });

  int? id;
  String? namabarang;
  int? harga;
  String? dari;
  String? ke;
  String? ekspedisi;
  int? status;

  factory KurirData.fromJson(Map<String, dynamic> json) => KurirData(
        id: json["Id"],
        namabarang: json["Namabarang"],
        harga: json["Harga"],
        dari: json["Dari"],
        ke: json["Ke"],
        ekspedisi: json["Ekspedisi"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Namabarang": namabarang,
        "Harga": harga,
        "Dari": dari,
        "Ke": ke,
        "Ekspedisi": ekspedisi,
        "Status": status,
      };
}
