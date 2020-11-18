import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hinergi_v9/model/setting.dart';
import 'package:hinergi_v9/resources/String.dart';
import 'package:matcher/matcher.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

var datax;

double budgetHarian;
double budget;
double usageProgress;
double perKwh;

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final double sales;

  OrdinalSales(this.year, this.sales);
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    printHistory();
    // print(datax[0]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: printHistory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
                List<charts.Series> seriesList = _createSampleData();
                final bool animate = false;

                var chart = charts.BarChart(
                  seriesList,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.grouped,
                );

                Color progressBarColor = Colors.green;
                Color textSave = Colors.white;
                String stringTextSave = "Save";

                String dataUsage = datax[0]
                    .toString()
                    .split(": ")[1]
                    .split("-")[2]
                    .split(" ")[1];

                double dataUsage1 = double.parse(dataUsage);

                String cost = (dataUsage1 * perKwh).toStringAsFixed(0);

                double doubleSave = budgetHarian - (dataUsage1 * perKwh);

                if (doubleSave < 0) {
                  textSave = Colors.red;
                  stringTextSave = "Loss";
                }
                doubleSave = doubleSave.abs();
                String save = doubleSave.toStringAsFixed(0);

                double persentase = dataUsage1 / budgetHarian;

                String progressText;

                if (persentase > 1) {
                  progressText =
                      "Over " + (persentase - 1).toStringAsFixed(2) + "%";
                  persentase = 1;
                  progressBarColor = Colors.red;
                } else {
                  progressText = persentase.toStringAsFixed(2) + "%";
                }

                var chartWidget = Padding(
                  padding: EdgeInsets.all(1.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.86,
                    child: chart,
                  ),
                );
                print("fahmi maulana");
                // return Text("data");
                return Scaffold(
                    body: SafeArea(
                        top: false,
                        child: Stack(
                          children: [
                            Container(
                              // color: Color.fromARGB(255, 68, 2014, 112),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment
                                      .bottomCenter, // 10% of the width, so there are ten blinds.
                                  colors: [
                                    const Color.fromARGB(255, 55, 65, 161),
                                    // const Color.fromARGB(255, 68, 2014, 112)
                                    const Color.fromARGB(255, 38, 110, 80),
                                  ], // red to yellow
                                  tileMode: TileMode
                                      .repeated, // repeats the gradient over the canvas
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(5)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(60),
                                                bottom:
                                                    ScreenUtil().setHeight(10),
                                                left: ScreenUtil().setWidth(10),
                                                right:
                                                    ScreenUtil().setWidth(10)),
                                            child: InkWell(
                                              onTap: () {
                                                // Navigator.pushNamed(
                                                //     context, '/home');
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: Image.asset(
                                                  'lib/assets/icons/logohinergi.jpg',
                                                  scale: 13,
                                                ),
                                              ),
                                            )),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(60),
                                              bottom:
                                                  ScreenUtil().setHeight(10),
                                              left: ScreenUtil().setWidth(10),
                                              right: ScreenUtil().setWidth(10)),
                                          child: Text(
                                              AllString().mode["title3"],
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(
                                                      AllString()
                                                          .judul["size"]))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(60),
                                              bottom:
                                                  ScreenUtil().setHeight(10),
                                              left: ScreenUtil().setWidth(10),
                                              right: ScreenUtil().setWidth(10)),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/setting');
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: Image.asset(
                                                'lib/assets/icons/settings.png',
                                                scale: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        color: Colors.white.withOpacity(0.6),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil()
                                                          .setHeight(20),
                                                      bottom: ScreenUtil()
                                                          .setHeight(1),
                                                      left: ScreenUtil()
                                                          .setWidth(20),
                                                      right: ScreenUtil()
                                                          .setWidth(20)),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            right: ScreenUtil()
                                                                .setWidth(10)),
                                                        child: MyBullet(
                                                            Colors.blue[900],
                                                            ScreenUtil()
                                                                .setSp(25)),
                                                      ),
                                                      Text('Budget',
                                                          style: GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          25))),
                                                    ],
                                                  )),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      top: ScreenUtil()
                                                          .setHeight(20),
                                                      bottom: ScreenUtil()
                                                          .setHeight(1),
                                                      left: ScreenUtil()
                                                          .setWidth(20),
                                                      right: ScreenUtil()
                                                          .setWidth(20)),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            right: ScreenUtil()
                                                                .setWidth(10)),
                                                        child: MyBullet(
                                                            Colors.blue[200],
                                                            ScreenUtil()
                                                                .setSp(25)),
                                                      ),
                                                      Text('Cost',
                                                          style: GoogleFonts.poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          25))),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: ScreenUtil()
                                                        .setHeight(10),
                                                    left: ScreenUtil()
                                                        .setWidth(10),
                                                    right: ScreenUtil()
                                                        .setWidth(10)),
                                                child: Center(
                                                  child: chartWidget,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ])),
                                    Card(
                                        elevation: 0,
                                        color: Colors.black.withOpacity(0.3),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 120, 255, 145),
                                                width: 1.5)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(30),
                                              bottom:
                                                  ScreenUtil().setHeight(30),
                                              left: ScreenUtil().setWidth(30),
                                              right: ScreenUtil().setWidth(30)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Budget',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(40))),
                                              Text(
                                                  "Rp. " +
                                                      budgetHarian
                                                          .toStringAsFixed(0),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(40))),
                                            ],
                                          ),
                                        )),
                                    Card(
                                        elevation: 0,
                                        color: Colors.black.withOpacity(0.3),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 120, 255, 145),
                                                width: 1.5)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(30),
                                              bottom:
                                                  ScreenUtil().setHeight(30),
                                              left: ScreenUtil().setWidth(30),
                                              right: ScreenUtil().setWidth(30)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Costs',
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(40))),
                                              Text("Rp. " + cost,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: ScreenUtil()
                                                          .setSp(40))),
                                            ],
                                          ),
                                        )),
                                    Card(
                                        elevation: 0,
                                        color: Colors.black.withOpacity(0.3),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 120, 255, 145),
                                                width: 1.5)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(30),
                                              bottom:
                                                  ScreenUtil().setHeight(30),
                                              left: ScreenUtil().setWidth(30),
                                              right: ScreenUtil().setWidth(30)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(stringTextSave,
                                                  style: GoogleFonts.poppins(
                                                      color: textSave,
                                                      fontSize: ScreenUtil()
                                                          .setSp(40))),
                                              Text("Rp. " + save,
                                                  style: GoogleFonts.poppins(
                                                      color: textSave,
                                                      fontSize: ScreenUtil()
                                                          .setSp(40))),
                                            ],
                                          ),
                                        )),
                                    Card(
                                        elevation: 0,
                                        color: Color.fromARGB(255, 1, 24, 89)
                                            .withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 64, 175, 255),
                                                width: 1.5)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(10),
                                              bottom:
                                                  ScreenUtil().setHeight(50),
                                              left: ScreenUtil().setWidth(30),
                                              right: ScreenUtil().setWidth(30)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: ScreenUtil()
                                                            .setHeight(10),
                                                        bottom: ScreenUtil()
                                                            .setHeight(10),
                                                        left: ScreenUtil()
                                                            .setWidth(30),
                                                        right: ScreenUtil()
                                                            .setWidth(30)),
                                                    child: Text(
                                                        'Usage progress',
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            40))),
                                                  ),
                                                  new LinearPercentIndicator(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            50,
                                                    animation: true,
                                                    lineHeight: 30.0,
                                                    animationDuration: 2000,
                                                    percent: persentase,
                                                    center: Text(progressText,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.white,
                                                        )),
                                                    linearStrokeCap:
                                                        LinearStrokeCap
                                                            .roundAll,
                                                    progressColor:
                                                        progressBarColor,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ))
                                  ],
                                )),
                          ],
                        )));
              } else {
                return Center(child: Text("fahmi"));
              }
            }));
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 50),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 120),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    List<OrdinalSales> budgetData = List(5);
    List<OrdinalSales> costData = List(5);

    print("datax : " + datax.toString());

    for (var i = 0; i < 5; i++) {
      // var hari = new Random();
      var random = new Random();
      int randomData = random.nextInt(10);
      int hariData = i + 1;
      String dataTanggal =
          datax[4 - i].toString().split(": ")[1].split("-")[2].split(" ")[0];
      // print(dataTanggal);
      String dataUsage =
          datax[4 - i].toString().split(": ")[1].split("-")[2].split(" ")[1];

      budgetData[i] = new OrdinalSales(dataTanggal, budgetHarian);
      costData[i] =
          new OrdinalSales(dataTanggal, double.parse(dataUsage) * perKwh);
    }

    // for (var i = 0; i < 5; i++) {
    //   int hariData = i + 1;
    //   var random = new Random();
    //   int randomData = random.nextInt(10);
    //   costData[i] = new OrdinalSales((hariData + i).toString(), randomData);
    // }

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Budget',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: budgetData,
          seriesColor: getChartColor(Colors.blue[800])),
      new charts.Series<OrdinalSales, String>(
          id: 'Cost',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: costData,
          seriesColor: getChartColor(Colors.lightBlue[400])),
      // new charts.Series<OrdinalSales, String>(
      //   id: 'Mobile',
      //   domainFn: (OrdinalSales sales, _) => sales.year,
      //   measureFn: (OrdinalSales sales, _) => sales.sales,
      //   data: mobileSalesData,
      // ),
    ];
  }
}

printHistory() async {
  List historyData = new List(5);
  for (var i = 0; i < 5; i++) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(i.toString());

    double budget = prefs.getDouble('budget');
    perKwh = prefs.getDouble('tarif');
    budgetHarian = budget / 30;
    // print(i.toString() + " : " + data.toString());
    historyData[i] = i.toString() + " : " + data.toString();
  }
  datax = historyData;
  return historyData;

  // return historyData;
}

charts.Color getChartColor(Color color) {
  return charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class MyBullet extends StatelessWidget {
  final Color color;
  final double size;

  const MyBullet(this.color, this.size);
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: size,
      width: size,
      decoration: new BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
