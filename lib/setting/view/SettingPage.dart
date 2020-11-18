import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hinergi_v9/model/setting.dart';
import 'package:hinergi_v9/setting/model/MyTextFormField.dart';
import 'package:hinergi_v9/views/HistoryPage.dart';
// import 'package:hinergi_kwh/view/buttonDate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart' as validator;

class SettingPage extends StatefulWidget {
  @override
  _SettingPage createState() => _SettingPage();
}
class _SettingPage extends State<SettingPage> {
  Setting setting = Setting();
  Setting seter = Setting();
  // SettingPage();
  String barcode = "";
  String chanelId = "";
  String apiKey = "";
  String token = "";

  String tarif = "";
  String budget = "";
  String kwh = "";

  bool flag = false;

  final _formKey = GlobalKey<FormState>();

  //  @override
  // void initState() {
  //   super.s;
  //   seter = Setting();
  // }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return FutureBuilder<Setting>(
      future: seter.getSetting(),
      builder: (context, AsyncSnapshot<Setting> snapshot) {
        if (snapshot.hasData) {
          if(chanelId == "" || apiKey == "" || token == ""){
            chanelId = snapshot.data.channelId.toString();
            apiKey = snapshot.data.apiKey.toString();
            token = snapshot.data.token.toString();
          }

          if((tarif == "" || budget == "" || kwh == "") && flag == false){
            tarif = snapshot.data.tarifPerKwh.toString();
            budget = snapshot.data.budgetMax.toString();
            kwh = snapshot.data.kwhMax.toString();
            flag = true;
          }

          return new Scaffold(
              body: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        AppBar(
                          title: Text('Pengaturan'),
                          backgroundColor: Color.fromARGB(255, 55, 65, 161),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // do something
                                Navigator.pushNamed(context, '/home');
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // do something
                                setting.removeSetting();
                                Navigator.pushNamed(context, '/login');
                              },
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                        //   child: Card(
                        //     color: Colors.blue,
                        //     child: ListTile(
                        //       title: Text("PENGATURAN",
                        //           style: GoogleFonts.quantico(
                        //               color: Colors.white, fontSize: ScreenUtil().setSp(30))),
                        //       // trailing: Text("  Setting",
                        //       //     style: GoogleFonts.quantico(
                        //       //         color: Colors.white, fontSize: ScreenUtil().setSp(25))),
                        //     ),
                        //   )
                        // ),
                        MyTextFormField(
                          hintText: 'Masukkan Channel Id anda',
                          labelText: 'Channel Id',
                          value: chanelId,
                          isEmail: false,
                          icon: Icon(Icons.verified_user),
                          validator: (String value) {
                            if (validator.isNull(value)) {
                              return 'Please enter a channel id';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            setting.channelId = value;
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan API Key anda',
                          labelText: 'API Key',
                          value: apiKey,
                          isEmail: false,
                          icon: Icon(Icons.vpn_key_sharp),
                          validator: (String value) {
                            if (validator.isNull(value)) {
                              return 'Please enter a api key';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            setting.apiKey = value;
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan token anda',
                          labelText: 'Token',
                          value: token,
                          isEmail: false,
                          icon: Icon(Icons.vpn_key_sharp),
                          validator: (String value) {
                            if (validator.isNull(value)) {
                              return 'Please enter a token';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            setting.token = value;
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan tarif listrik',
                          labelText: 'Tarif per KWh',
                          value: tarif,
                          isEmail: false,
                          icon: Icon(Icons.money),
                          validator: (String value) {
                            if (!validator.isFloat(value)) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            tarif = value;
                            setting.tarifPerKwh = double.parse(value);
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan budget anda',
                          labelText: 'Budget (Rp./Month)',
                          value: budget,
                          isEmail: false,
                          icon: Icon(Icons.money_off_rounded),
                          validator: (String value) {
                            if (!validator.isFloat(value)) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            budget = value;
                            setting.budgetMax = double.parse(value);
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan batas watt meter',
                          labelText: 'Batas daya',
                          value: kwh,
                          isEmail: false,
                          icon: Icon(Icons.lightbulb_outline_sharp),
                          validator: (String value) {
                            if (!validator.isFloat(value)) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            kwh = value;
                            setting.kwhMax = double.parse(value);
                          },
                        ),
                        Container(
                            // alignment: Alignment.topRight,
                          child: Column(
                            children:[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: double.infinity,
                                    // minWidth: 200.0,
                                    height: 50.0,
                                    child: RaisedButton(
                                      // color: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        side: BorderSide(color: Color.fromARGB(255,0,176,41))
                                        // side: BorderSide(color: Colors.red)
                                      ),
                                      color: Colors.white,
                                       onPressed: () async {
                                                  try {
                                                    String barcode = await BarcodeScanner.scan();
                                                    setState(() {
                                                      // String coba = '1154780,SPZVVOM0D4YO6TX0,horeksdfklj';
                                                      // print(coba.split(',')[0]);
                                                      // this.barcode = barcode;
                                                      chanelId = barcode.split(',')[0];
                                                      apiKey = barcode.split(',')[1];
                                                      token = barcode.split(',')[2];
                                                      this.barcode = snapshot.data.channelId;
                                                     
                                                    });
                                                  } on PlatformException catch (error) {
                                                    if (error.code == BarcodeScanner.CameraAccessDenied) {
                                                      setState(() {
                                                        this.barcode = 'Izin kamera tidak diizinkan oleh si pengguna';
                                                      });
                                                    } else {
                                                      setState(() {
                                                        this.barcode = 'Error: $error';
                                                      });
                                                    }
                                                  }
                                                },
                                      child: Text(
                                        'SCAN',
                                        style: TextStyle(
                                          color: Colors.black38,
                                        ),
                                      ),
                                    )
                                  )  
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: double.infinity,
                                    // minWidth: 200.0,
                                    height: 50.0,
                                    child: RaisedButton(
                                      // color: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        // side: BorderSide(color: Colors.red)
                                      ),
                                      color: Color.fromARGB(255, 0, 176, 41),
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();

                                          setting.setSetting(setting);
                                          Navigator.pushNamed(context, '/home');
                                        }
                                      },
                                      child: Text(
                                        'SIMPAN',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  )  
                                )
                            ]
                          ) 
                        ),
                      ]
                    )
                  )
                )
              );
        } else {
          return new Scaffold(
              body: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        // Padding(
                        //   padding: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
                        //   child: Card(
                        //     color: Colors.blue,
                        //     child: ListTile(
                        //       title: Text("PENGATURAN",
                        //           style: GoogleFonts.quantico(
                        //               color: Colors.white, fontSize: ScreenUtil().setSp(30))),
                        //       // trailing: Text("  Setting",
                        //       //     style: GoogleFonts.quantico(
                        //       //         color: Colors.white, fontSize: ScreenUtil().setSp(25))),
                        //     ),
                        //   )
                        // ),
                        MyTextFormField(
                          hintText: 'Masukkan Channel Id anda',
                          labelText: 'Channel Id',
                          isEmail: false,
                          icon: Icon(Icons.verified_user),
                          validator: (String value) {
                            if (validator.isNull(value)) {
                              return 'Please enter a channel id';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            setting.channelId = value;
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan API Key anda',
                          labelText: 'API Key',
                          isEmail: false,
                          icon: Icon(Icons.vpn_key_sharp),
                          validator: (String value) {
                            if (validator.isNull(value)) {
                              return 'Please enter a api key';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            setting.apiKey = value;
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan token anda',
                          labelText: 'Token',
                          isEmail: false,
                          icon: Icon(Icons.vpn_key_sharp),
                          validator: (String value) {
                            if (validator.isNull(value)) {
                              return 'Please enter a token';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            setting.token = value;
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan tarif listrik',
                          labelText: 'Tarif per KWh',
                          isEmail: false,
                          icon: Icon(Icons.money),
                          validator: (String value) {
                            if (!validator.isNumeric(value)) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            setting.tarifPerKwh = double.parse(value);
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan budget anda',
                          labelText: 'Budget',
                          isEmail: false,
                          icon: Icon(Icons.money_off_rounded),
                          validator: (String value) {
                            if (!validator.isNumeric(value)) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            setting.budgetMax = double.parse(value);
                          },
                        ),
                        MyTextFormField(
                          hintText: 'Masukkan batas watt meter',
                          labelText: 'Batas daya',
                          isEmail: false,
                          icon: Icon(Icons.lightbulb_outline_sharp),
                          validator: (String value) {
                            if (!validator.isFloat(value)) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            setting.kwhMax = double.parse(value);
                          },
                        ),
                        Container(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  color: Colors.blueAccent,
                                  shape: StadiumBorder(),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();

                                      setting.setSetting(setting);
                                      // Navigator.push(
                                      // context,
                                      // MaterialPageRoute(
                                      //     builder: (context) => Result(model: this.setting))

                                      // );
                                    }
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ))),
                      ]))));
        }
      },
    );
  }
}
