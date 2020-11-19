import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hinergi_v9/model/setting.dart';
import 'package:hinergi_v9/models/ThinkspeakModel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

Setting setting = Setting();
Setting setSetting = Setting();

class ApiServices {
  saveHistory(int key, String penggunaan) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key.toString(), penggunaan);
  }

  printHistory() async {
    for (var i = 0; i < 5; i++) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var data = prefs.getString(i.toString());

      print(i.toString() + " : " + data.toString());
    }
  }

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
    int counterHistory = 0;
    int i = 0;

    while (counterHistory < 5) {
      startDate = today.add(Duration(days: -i));
      endDate = startDate.add(Duration(days: 1));
      start = new DateFormat("yyyy-MM-dd").format(startDate);
      end = new DateFormat("yyyy-MM-dd").format(endDate);
      // print("$start == $end");

      String link = "https://api.thingspeak.com/channels/" +
          channelId +
          "/feeds?end=" +
          end +
          "&apikey=" +
          apiKey +
          "&start=" +
          start +
          "&timezone=Asia%2FJakarta&results=1140";
      i++;
      print(link);
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
        if(enjoy < 0){
          enjoy = 0;
        }
        double koweKuduMbayar = enjoy * 1200;
        // print("panjang data : $panjangData");
        // print("start data : $startKwh");
        // print("last data : $lastKwh");
        // print("penggunaan data  $start : $koweKuduMbayar\n");

        String historyData = start.toString() + " " + enjoy.toStringAsFixed(3);

        saveHistory(counterHistory, historyData);
        counterHistory++;

        // return response.toString().split("[")[1].split("]")[0];
      } catch (e) {
        print(e.toString());
        // return "";
      }
    }

    printHistory();
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
      print(dataMap);

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
