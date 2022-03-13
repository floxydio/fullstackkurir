import 'package:cobabloc/Service/Models/kurir_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  var dio = Dio();
  var BASEURL = "localhost";

  Future<KurirHistory?> getHistoryKurir() async {
    try {
      Response response = await dio.get("${BASEURL}/api/listhistory");
      if (kDebugMode) {
        print("Response History -> ${response.data}");
      }
      return KurirHistory.fromJson(response.data);
    } catch (e) {
      throw Exception("ERROR IN -> $e");
    }
  }

  Future<dynamic> createHistory(KurirData dataModel) async {
    try {
      FormData formData = FormData.fromMap({
        "Id": dataModel.id,
        "namabarang": dataModel.namabarang,
        "dari": dataModel.dari,
        "ke": dataModel.ke,
        "harga": dataModel.harga,
        "status": dataModel.status,
        "ekspedisi": dataModel.ekspedisi
      });

      Response response =
          await dio.post("${BASEURL}/api/createhistory", data: formData);
      print("Response edit -> ${response.data}");

      return response.data;
    } catch (e) {
      throw Exception("Error in ->$e");
    }
  }

  Future<dynamic> editKurir(KurirData dataModel, int? id) async {
    try {
      FormData formData = FormData.fromMap({
        "Id": dataModel.id,
        "namabarang": dataModel.namabarang,
        "status": dataModel.status
      });

      Response response =
          await dio.put("${BASEURL}/api/history/${id}", data: formData);
      print("Response edit -> ${response.data}");

      return response.data;
    } catch (e) {
      throw Exception("Error in ->$e");
    }
  }
}
