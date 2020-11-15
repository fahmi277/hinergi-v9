import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hinergi_v9/models/ThinkspeakModel.dart';

class ApiServices {
  getThinkspeakData() async {
    var dio = Dio();
    String link =
        "https://api.thingspeak.com/channels/1212044/feeds?end=2020-11-15&apikey=FVPTLLLSDHH8UUQE&start=2020-11-14&timezone=Asia%2FJakarta&results=1140";

    try {
      Response response = await dio.get(link);
      print(response.data.runtimeType);
      var dataJson = jsonDecode(response.data);
      print(dataJson.runtimeType);
      var dataThinkspeak = Thinkspeak.fromJson(dataJson);

      int panjangData = dataThinkspeak.feeds.length;
      double startKwh = double.parse(dataThinkspeak.feeds[0].field4);
      double lastKwh =
          double.parse(dataThinkspeak.feeds[panjangData - 1].field4);
      double enjoy = lastKwh - startKwh;
      print("panjang data : $panjangData");
      print("start data : $startKwh");
      print("last data : $lastKwh");
      print("penggunaan data : $enjoy\n");
      // return response.toString().split("[")[1].split("]")[0];
    } catch (e) {
      print(e.toString());
      // return "";
    }
  }

  Future<String> getBlynkData(String path) async {
    String token = "uh4Tx90xk9Oj5tIpo6n_tHuTw6b_jgaI";
    String path = "/get/V2";
    String link = "http://blynk-cloud.com/" + token + path;
    var dio = Dio();
    try {
      Response response = await dio.get(link);
      print(response);
      return response.toString().split("[")[1].split("]")[0];
    } catch (e) {
      print("null");
      return "";
    }
  }
}
