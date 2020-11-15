import 'package:dio/dio.dart';

class ApiServices {
  Future<String> getBlynkData() async {
    String token = "uh4Tx90xk9Oj5tIpo6n_tHuTw6b_jgaI";
    String pin = "/get/V2";
    String link = "http://blynk-cloud.com/" + token + pin;
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
