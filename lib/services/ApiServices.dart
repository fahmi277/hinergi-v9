import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hinergi_v9/model/setting.dart';
import 'package:hinergi_v9/models/ThinkspeakModel.dart';
import 'package:intl/intl.dart';

Setting setting = Setting();

class ApiServices {
  getThinkspeakData() async {
    var data = await setting.getApiId();
    String channelId = data.channelId.toString();
    String apiKey = data.apiKey.toString();

    print(channelId);
    print(apiKey);
    var dio = Dio();
    var today = DateTime.now();
    var startDate = today;
    var endDate = startDate.add(Duration(days: 1));
    String start;
    String end;
    for (var i = 0; i < 5; i++) {
      startDate = today.add(Duration(days: -i));
      endDate = startDate.add(Duration(days: 1));
      start = new DateFormat("yyyy-MM-dd").format(startDate);
      end = new DateFormat("yyyy-MM-dd").format(endDate);
      // print("$start == $end");

      String link = "https://api.thingspeak.com/channels/1212044/feeds?end=" +
          end +
          "&apikey=FVPTLLLSDHH8UUQE&start=" +
          start +
          "&timezone=Asia%2FJakarta&results=1140";

      // print(link);
      //"https://api.thingspeak.com/channels/1212044/feeds?end=2020-11-15&apikey=FVPTLLLSDHH8UUQE&start=2020-11-14&timezone=Asia%2FJakarta&results=1140";

      try {
        Response response = await dio.get(link);
        // print(response.data.runtimeType);
        var dataJson = jsonDecode(response.data);
        // print(dataJson.runtimeType);
        var dataThinkspeak = Thinkspeak.fromJson(dataJson);

        int panjangData = dataThinkspeak.feeds.length;
        double startKwh = double.parse(dataThinkspeak.feeds[0].field4);
        double lastKwh =
            double.parse(dataThinkspeak.feeds[panjangData - 1].field4);
        double enjoy = lastKwh - startKwh;
        double koweKuduMbayar = enjoy * 1200;
        // print("panjang data : $panjangData");
        // print("start data : $startKwh");
        // print("last data : $lastKwh");
        print("penggunaan data  $start : $koweKuduMbayar\n");
        // return response.toString().split("[")[1].split("]")[0];
      } catch (e) {
        print(e.toString());
        // return "";
      }
    }
  }

  Future<Map> getBlynkData(String path) async {
    var data = await setting.getApiId();
    String token = data.token.toString();
    // print(token);
    String path = "/get/V2";
    String hardwareConnected = "/isHardwareConnected";
    String link = "http://188.166.206.43/" + token + path;
    String linkHardware = "http://188.166.206.43/" + token + hardwareConnected;

    // print(linkHardware);
    var dio = Dio();
    try {
      var response = await Future.wait([dio.get(link), dio.get(linkHardware)]);

      var dataMap = response.asMap();
      // print(dataMap);

      // print(dataMap[0].data[0]);
      // print(dataMap[1]);

      return dataMap;
      // return response.toString().split("[")[1].split("]")[0];
    } catch (e) {
      print("null");
      return {
        0: [0],
        1: false
      };
    }
  }
}
