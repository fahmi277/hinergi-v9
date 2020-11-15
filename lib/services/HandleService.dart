import 'dart:async';

import 'package:hinergi_v9/BLoC/BLoC.dart';

import 'ApiServices.dart';

class HandleService {
  Timer timer;
  BlynkBLoc blynkBloc = BlynkBLoc();
  void timerBlynk() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      var dataBlynk = await ApiServices().getBlynkData();
      blynkBloc.eventSinkBlynk.add(dataBlynk.toString());
    });
  }

  void dispose() {
    timer.cancel();
  }
}
