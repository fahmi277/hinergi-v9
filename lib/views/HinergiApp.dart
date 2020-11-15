import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hinergi_v9/BLoC/BLoC.dart';

import 'package:hinergi_v9/resources/String.dart';
import 'package:hinergi_v9/services/ApiServices.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HinergiApp extends StatefulWidget {
  @override
  _HinergiAppState createState() => _HinergiAppState();
}

class _HinergiAppState extends State<HinergiApp> {
  // ColorBloc bloc = ColorBloc();
  BlynkBLoc blynkBloc = BlynkBLoc();
  Timer timer;
  double kwhRealtime = 0.00;

  void timerBlynk() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) async {
      var dataBlynk = await ApiServices().getBlynkData();
      blynkBloc.eventSinkBlynk.add(dataBlynk.toString());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    blynkBloc.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // timerBlynk();
    blynkBloc.timerBlynk("data");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                color: Color.fromARGB(255, 68, 204, 112),
                // color: Colors.blue,
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          bottom: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(20),
                          right: ScreenUtil().setWidth(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'lib/assets/icons/logohinergi.jpg',
                          scale: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          bottom: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(10),
                          right: ScreenUtil().setWidth(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'lib/assets/icons/settings.png',
                          scale: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(800)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Text(AllString().judul["title"],
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: ScreenUtil()
                                      .setSp(AllString().judul["size"])))),
                      Center(
                        child: Text(AllString().subjudul["title"],
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: ScreenUtil()
                                    .setSp(AllString().subjudul["size"]))),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(50)),
                              child: Text("Rp",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: ScreenUtil().setSp(30))),
                            ),
                            Text(AllString().billingrupiah["title"],
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(
                                        AllString().billingrupiah["size"]))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(30),
                    right: ScreenUtil().setWidth(30),
                    bottom: ScreenUtil().setHeight(460)),
                child: Center(
                  child: Container(
                    height: ScreenUtil().setHeight(120),
                    // width: 200,
                    child: Card(
                      color: Colors.lightGreenAccent[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(
                              child: Card(
                            color: Color.fromARGB(255, 68, 204, 112),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Color.fromARGB(255, 68, 204, 112),
                                width: 4.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(50),
                                  right: ScreenUtil().setWidth(50),
                                  top: ScreenUtil().setWidth(10),
                                  bottom: ScreenUtil().setWidth(10)),
                              child: Text(AllString().mode["title1"],
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: ScreenUtil()
                                          .setSp(AllString().judul["size"]))),
                            ),
                          )),
                          Center(
                            child: Text(AllString().mode["title2"],
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 68, 204, 112),
                                    fontSize: ScreenUtil()
                                        .setSp(AllString().subjudul["size"]))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              StreamBuilder(
                  stream: blynkBloc.stateStreamBlynk,
                  initialData: "0.00",
                  builder: (context, snapshot) {
                    kwhRealtime = double.parse(snapshot.data);
                    return Padding(
                      padding: EdgeInsets.only(top: 0.20.sh),
                      child: Center(
                          child: Container(
                              height: ScreenUtil().setHeight(600),
                              width: ScreenUtil().setWidth(600),
                              child: SfRadialGauge(axes: <RadialAxis>[
                                RadialAxis(
                                    axisLabelStyle:
                                        GaugeTextStyle(color: Colors.white),
                                    minimum: 0,
                                    maximum: 150 * 10.0,
                                    startAngle: 120,
                                    endAngle: 0,
                                    ranges: <GaugeRange>[
                                      GaugeRange(
                                          startValue: 0 * 10.0,
                                          endValue: 50 * 10.0,
                                          color: Colors.cyanAccent,
                                          startWidth: 10,
                                          endWidth: 10),
                                      GaugeRange(
                                          startValue: 50 * 10.0,
                                          endValue: 100 * 10.0,
                                          color: Colors.orange,
                                          startWidth: 10,
                                          endWidth: 10),
                                      GaugeRange(
                                          startValue: 100 * 10.0,
                                          endValue: 150 * 10.0,
                                          color: Colors.red,
                                          startWidth: 10,
                                          endWidth: 10)
                                    ],
                                    pointers: <GaugePointer>[
                                      NeedlePointer(value: kwhRealtime)
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                          widget: Padding(
                                            padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(270),
                                              left: ScreenUtil().setWidth(100),
                                            ),
                                            child: Container(
                                                child: Column(
                                              children: [
                                                Text(
                                                    kwhRealtime.toStringAsFixed(
                                                            1) +
                                                        " W",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(AllString()
                                                                    .dummyKwhStatus[
                                                                "size"]))),
                                                Text(
                                                    AllString().dummyKwhStatus[
                                                        "title"],
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: ScreenUtil()
                                                            .setSp(AllString()
                                                                    .dummyKwhStatus[
                                                                "size"]))),
                                              ],
                                            )),
                                          ),
                                          angle: 40,
                                          positionFactor: 0.5)
                                    ])
                              ]))),
                    );
                  }),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(20),
                        right: ScreenUtil().setWidth(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 120,
                          width: 150,
                          child: InkWell(
                            onTap: () {
                              print("object");
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  Text("Save",
                                      style: GoogleFonts.poppins(
                                          color:
                                              Color.fromARGB(255, 68, 204, 112),
                                          fontSize: ScreenUtil().setSp(
                                              AllString().footer["size"]))),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              bottom:
                                                  ScreenUtil().setHeight(20),
                                              right: ScreenUtil().setWidth(10)),
                                          child: Text("Rp",
                                              style: GoogleFonts.poppins(
                                                  color: Color.fromARGB(
                                                      255, 68, 204, 112),
                                                  fontSize:
                                                      ScreenUtil().setSp(40)))),
                                      Text(AllString().footer["title"],
                                          style: GoogleFonts.poppins(
                                              color: Color.fromARGB(
                                                  255, 68, 204, 112),
                                              fontSize: ScreenUtil().setSp(
                                                  AllString().footer["size"]))),
                                    ],
                                  ),
                                  Text("than Yesterday",
                                      style: GoogleFonts.poppins(
                                          color:
                                              Color.fromARGB(255, 68, 204, 112),
                                          fontSize: ScreenUtil().setSp(30))),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(50),
                        left: ScreenUtil().setWidth(50)),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            print("object");
                            ApiServices().getBlynkData();
                            blynkBloc.eventSinkBlynk.add("fahmi");
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              'lib/assets/icons/light.png',
                              scale: 8,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text("Usage",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: ScreenUtil()
                                        .setSp(AllString().subjudul["size"]))),
                            Text("15.11.2020",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: ScreenUtil()
                                        .setSp(AllString().subjudul["size"])))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              // Center(
              //   child: StreamBuilder(
              //     stream: blynkBloc.stateStreamBlynk,
              //     initialData: "data",
              //     builder: (context, snapshot) {
              //       print("data : " + snapshot.data.toString());
              //       return Text(snapshot.data);
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
