import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  String nama;
  String password;
  String channelId;
  String apiKey;
  int tarifKwh;
  int budgetKwh;
  int kwhMax;
  String installed;

  String constChannelId = "channelId";
  String constApiKey = "apiKey";
  String constTarifKwh = "tarifKwh";
  String constBudgetKwh = "budgetKwh";

  UserData(
      {this.nama,
      this.password,
      this.apiKey,
      this.channelId,
      this.budgetKwh,
      this.tarifKwh,
      this.kwhMax,
      this.installed});

  saveDataUser(UserData userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('channelId', userData.channelId);
    prefs.setString('apiKey', userData.apiKey);
    prefs.setString('userName', userData.nama);
    prefs.setString('password', userData.password);
    print("iuser data : " + userData.apiKey.toString());
  }

  Future<UserData> getUserdata() async {
    try {
      UserData set = UserData();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      set.apiKey = prefs.getString('apiKey') ?? "kosong";
      set.nama = prefs.getString('userName') ?? "kosong";
      set.channelId = prefs.getString('channelId') ?? "kosong";
      set.tarifKwh = prefs.getInt('tarifKwh') ?? 950;
      // print(set);
      return set;
      // userData.budgetKwh = prefs.getInt();
      // userData.tarifKwh = prefs.getInt(userData.constTarifKwh);
    } catch (e) {
      UserData set = UserData();
      // SharedPreferences prefs = await SharedPreferences.getInstance();

      set.apiKey = "apiKey";
      set.channelId = "channelId";
      set.budgetKwh = 0;
      set.tarifKwh = 0;
      print("object");
      return set;
    }
  }
}
