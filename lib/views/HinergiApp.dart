import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hinergi_v9/BLoC/BLoC.dart';
import 'package:hinergi_v9/model/setting.dart';

import 'package:hinergi_v9/resources/String.dart';
import 'package:hinergi_v9/services/ApiServices.dart';
import 'package:hinergi_v9/services/DateTimeServices.dart';
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

  var textColorHardware = Color.fromARGB(255, 68, 204, 112);
  String statusHardware = "false";

// get setting

  Setting setting = Setting();
// get setting
  Future<void> getApi() async {
    var data = await setting.getApiId();

    print(data.apiKey);
  }

  void getHistory() {
    ApiServices().getThinkspeakData();
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
    getHistory();
    getApi();
    blynkBloc.timerBlynk({0: 1, 1: 1});
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
                // color: Color.fromARGB(255, 68, 204, 112),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment
                        .bottomCenter, // 10% of the width, so there are ten blinds.
                    colors: [
                      // const Color.fromARGB(255,55, 65, 161),
                      const Color.fromARGB(255, 55, 65, 161),
                      // const Color.fromARGB(255, 68, 2014, 112)
                      const Color.fromARGB(255, 38, 110, 80),
                    ], // red to yellow
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  ),
                ),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/setting');
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            'lib/assets/icons/settings.png',
                            scale: 10,
                          ),
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
                    width: ScreenUtil().setWidth(650),
                    child: Card(
                      color: Colors.lightGreenAccent[500],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
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
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/history');
                                  },
                                  child: Card(
                                    // color: Color.fromARGB(255, 68, 204, 112),
                                    shape: StadiumBorder(
                                      side: BorderSide(
                                        // color: Color.fromARGB(255, 68, 204, 112),
                                        color: Colors.white,
                                        width: 4.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(50),
                                          right: ScreenUtil().setWidth(50),
                                          top: ScreenUtil().setWidth(10),
                                          bottom: ScreenUtil().setWidth(10)),
                                      child: Text(AllString().mode["title2"],
                                          style: GoogleFonts.poppins(
                                              color: Color.fromARGB(
                                                  255, 68, 204, 112),
                                              fontSize: ScreenUtil().setSp(
                                                  AllString().judul["size"]))),
                                    ),
                                  )))
                          // Center(

                          //   child: Text(AllString().mode["title2"],
                          //       style: GoogleFonts.poppins(
                          //           color: Color.fromARGB(255, 68, 204, 112),
                          //           fontSize: ScreenUtil()
                          //               .setSp(AllString().subjudul["size"]))),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              StreamBuilder(
                  stream: blynkBloc.stateStreamBlynk,
                  initialData: {
                    0: [0.00],
                    1: false
                  },
                  builder: (context, snapshot) {
                    // kwhRealtime = double.parse(snapshot.data);
                    // print(snapshot.data);
                    var dataApi = snapshot.data;

                    statusHardware = dataApi[1].toString();
                    var dataKwh =
                        dataApi.toString().split("[")[1].split("]")[0];
                    String textHardware = "Disconnect";
                    String kwhStatus = "Carry Limit";

                    if (statusHardware == "true") {
                      textColorHardware = Color.fromARGB(255, 68, 204, 112);
                      textHardware = "Connect";
                      kwhRealtime = double.parse(dataKwh);
                      dataKwh = kwhRealtime.toStringAsFixed(1) + " W";
                    } else {
                      textColorHardware = Colors.red;
                      textHardware = "Disconnect";
                      kwhRealtime = 0.00;
                      dataKwh = "";
                      kwhStatus = "";
                    }

                    return Padding(
                      padding: EdgeInsets.only(top: 0.20.sh),
                      child: Center(
                          child: Container(
                              height: ScreenUtil().setHeight(600),
                              width: ScreenUtil().setWidth(600),
                              child: SfRadialGauge(
                                  enableLoadingAnimation: true,
                                  animationDuration: 6000,
                                  axes: <RadialAxis>[
                                    RadialAxis(
                                        axisLabelStyle:
                                            GaugeTextStyle(color: Colors.white),
                                        minimum: 0,
                                        maximum: 150 * 10.0,
                                        startAngle: 120,
                                        endAngle: -20,
                                        pointers: <GaugePointer>[
                                          RangePointer(
                                              enableAnimation: true,
                                              color: Colors.red,
                                              value: kwhRealtime,
                                              cornerStyle:
                                                  CornerStyle.bothCurve),
                                          // NeedlePointer(value: kwhRealtime)
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              widget: Stack(
                                                children: [
                                                  Center(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: ScreenUtil()
                                                          .setHeight(150),
                                                    ),
                                                    child: Container(
                                                      height: 50,
                                                      width: 120,
                                                      // color: Colors.red,
                                                      child: Card(
                                                        child: Center(
                                                          child: Text(
                                                              textHardware,
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      textColorHardware,
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              30))),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: ScreenUtil()
                                                          .setHeight(320),
                                                      left: ScreenUtil()
                                                          .setWidth(250),
                                                    ),
                                                    child: Container(
                                                        child: Column(
                                                      children: [
                                                        Text(dataKwh,
                                                            style: GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: ScreenUtil()
                                                                    .setSp(AllString()
                                                                            .dummyKwhStatus[
                                                                        "size"]))),
                                                        Text(kwhStatus,
                                                            style: GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: ScreenUtil()
                                                                    .setSp(AllString()
                                                                            .dummyKwhStatus["size"] -
                                                                        20))),
                                                      ],
                                                    )),
                                                  ),
                                                ],
                                              ),
                                              angle: 40,
                                              positionFactor: 0.2)
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Save",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
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
                                                      ScreenUtil().setSp(30)))),
                                      Text(AllString().footer["title"],
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
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
                            String data = "123,456,789";
                            print(data.split(",")[1]);
                            print("object");
                            ApiServices().getThinkspeakData();
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
                            Text(DateTimeClass().getTimeNow()["tanggal"],
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
