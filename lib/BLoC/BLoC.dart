import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hinergi_v9/services/ApiServices.dart';

enum ColorEvent { to_amber, to_light_blue }
Timer timer;

String blynkData = "";

class BlynkBLoc {
  Color _color = Colors.amber;

  // event tombol
  StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>();
  StreamController<String> _eventControllerBlynk = StreamController<String>();

  StreamSink<ColorEvent> get eventSink => _eventController.sink;
  StreamSink<String> get eventSinkBlynk => _eventControllerBlynk.sink;
  // event tombol
  StreamController<Color> _stateController = StreamController<Color>();
  StreamController<String> _stateControllerBlynk = StreamController<String>();

  StreamSink<Color> get _stateSink => _stateController.sink;

  Stream<Color> get stateStream => _stateController.stream;

  StreamSink<String> get _stateSinkBlynk => _stateControllerBlynk.sink;

  Stream<String> get stateStreamBlynk => _stateControllerBlynk.stream;

  void _mapEventToState(ColorEvent colorEvent) {
    if (colorEvent == ColorEvent.to_amber) {
      _color = Colors.amber;
    } else {
      _color = Colors.lightBlue;
    }

    _stateSink.add(_color);
  }

  void timerBlynk(String data) {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      var dataBlynk = await ApiServices().getBlynkData("/get/V2");
      _stateSinkBlynk.add(dataBlynk);
    });
  }

  void changeApi(String data) {
    _stateSinkBlynk.add(data);
    print(data);
  }

  // BlynkBLoc() {
  //   _eventController.stream.listen(_mapEventToState);
  // }

  BlynkBLoc() {
    _eventControllerBlynk.stream.listen(timerBlynk);
  }

  void dispose() {
    _eventController.close();
    _stateController.close();
    _eventControllerBlynk.close();
    _stateControllerBlynk.close();
  }
}
