import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hinergi_v9/login/model/formField.dart';
import 'package:hinergi_v9/model/setting.dart';
import 'package:hinergi_v9/model/userModel.dart';
import 'package:hinergi_v9/views/HinergiApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:hinergi_v9/setting/model/MyTextFormField.dart';
import 'package:validators/validators.dart' as validator;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:barcode_scan/barcode_scan.dart';

// import '../mainScreen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  final GlobalKey qrKey = GlobalKey();
  String chanelId = "";
  String apiKey = "";
  String token = "";
  String barcode = "";
  Setting setting = Setting();
  Setting seter = Setting();
  
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);

    UserData userData = UserData();
    UserData saveUserData = UserData();
    return FutureBuilder<Setting>(
              future: seter.getApiId(),
              builder: (context, AsyncSnapshot<Setting> snapshot) {
                  if ( !snapshot.hasData || snapshot.hasData == null) {
                    // if (snapshot.data.channelId == null|| snapshot.data.apiKey == null){
                       return  MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Scaffold(
                          // appBar: AppBar(),
                          body: SafeArea(
                            child: Stack(
                              children: [
                                Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(60),
                                            // top: ScreenUtil().setHeight(180)
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20.0),
                                            child: Image.asset(
                                              'lib/assets/images/logohinergi.jpg',
                                              scale: 6,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '$barcode',
                                          textAlign: TextAlign.center,
                                        ),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    
                                                    child: MyTextFormField(
                                                      // maxLength: 15,
                                                      hintText: 'Masukkan Channel Id anda',
                                                      labelText: 'Channel Id',
                                                      value: chanelId,
                                                      // isEmail: false,
                                                      validator: (String value) {
                                                        if (validator.isNull(value)) {
                                                          return 'Please enter a channel id';
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (String value) {
                                                        setting.channelId = value;
                                                      },
                                                      // textInputType: TextInputType.text,
                                                    ),
                                                  ),                                  
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Flexible(
                                                      child: MyTextFormField(
                                                          hintText: 'Masukkan API Key anda',
                                                          labelText: 'API Key',
                                                          value: apiKey,
                                                          // isEmail: false,
                                                          validator: (String value) {
                                                            if (validator.isNull(value)) {
                                                              return 'Please enter a api key';
                                                            }
                                                            return null;
                                                          },
                                                          onSaved: (String value) {
                                                            setting.apiKey = value;
                                                          },
                                                          // textInputType: TextInputType.text)
                                                          )
                                                          )
                                                 
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Flexible(
                                                      child: MyTextFormField(
                                                          hintText: 'Masukkan token anda',
                                                          labelText: 'Token',
                                                          value: token,
                                                          // isEmail: false,
                                                          validator: (String value) {
                                                            if (validator.isNull(value)) {
                                                              return 'Please enter a  token';
                                                            }
                                                            return null;
                                                          },
                                                          onSaved: (String value) {
                                                            setting.token = value;
                                                          },
                                                          // textInputType: TextInputType.text)
                                                          )
                                                          )
                                                 
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(
                                              top: ScreenUtil().setHeight(40),
                                              left: ScreenUtil().setWidth(50),
                                              right: ScreenUtil().setWidth(50)),
                                          child: SizedBox(
                                            width: double.infinity,
                                            // minWidth: 200.0,
                                            height: 50.0,
                                            child : RaisedButton(
                                              textColor: Colors.black38,
                                              //rgb(4, 117, 116)
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25.0),
                                                side: BorderSide(color: Color.fromARGB(255,0,176,41))
                                              ),
                                              color: Colors.white,
                                              onPressed: () async {
                                                  try {
                                                    String barcode = await BarcodeScanner.scan();
                                                    setState(() {
                                                      String coba = '1154780,SPZVVOM0D4YO6TX0,horeksdfklj';
                                                      print(coba.split(',')[0]);
                                                      // this.barcode = barcode;
                                                      chanelId = barcode.split(',')[0];
                                                      apiKey = barcode.split(',')[1];
                                                      token = barcode.split(',')[2];
                                                      this.barcode = chanelId;
                                                     
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
                                              child: Text("SCAN"),
                                            ),
                                          )
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(
                                              top: ScreenUtil().setHeight(40),
                                              left: ScreenUtil().setWidth(50),
                                              right: ScreenUtil().setWidth(50)),
                                          child: SizedBox(
                                            width: double.infinity,
                                            // minWidth: 200.0,
                                            height: 50.0,
                                            child : RaisedButton(
                                              textColor: Colors.white,
                                              //rgb(4, 117, 116)
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25.0),
                                                // side: BorderSide(color: Colors.red)
                                              ),
                                              color: Color.fromARGB(255,0,176,41),
                                              onPressed: () {
                                                if (_formKey.currentState.validate()) {
                                                  _formKey.currentState.save();
                                                  setting.setApiChannel(setting);
                                                  // userData.saveDataUser(userData);
                                                  // print(userData.password);
                                                  // print(userData.nama);
                                                  // print(userData.apiKey);
                                                  // print(userData.channelId);
                                                  Fluttertoast.showToast(
                                                      msg: "Tersimpan",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      // backgroundColor:
                                                      //     Color.fromARGB(255, 4, 117, 116),
                                                      textColor: Colors.black,
                                                      fontSize: 16.0);
                                                  Navigator.pushNamed(context, '/setting');
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) => mainScreen()),
                                                  // );
                                                }
                                              },
                                              child: Text("LOGIN"),
                                            ),
                                          )
                                        ),
                                        // Padding(
                                        //   padding:
                                        //       EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                                        //   child: OutlineButton(
                                        //     // textColor: Colors.blue,
                                        //     textColor: Color.fromARGB(255, 4, 117, 116),
                                        //     color: Color(0xFF6200EE),
                                        //     onPressed: () {
                                        //       // Navigator.push(
                                        //       //   context,
                                        //       //   MaterialPageRoute(
                                        //       //       builder: (context) => mainScreen()),
                                        //       // );

                                        //       // var data = await saveUserData.apiKey;
                                        //       // print(data);
                                        //     },
                                        //     child: Text(
                                        //       "Sudah punya akun, klik disini",
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          resizeToAvoidBottomInset: false,
                          // resizeToAvoidBottomPadding: false,
                        )
                      );
                    // }else{
                    //   return HinergiApp();
                    // }
                   
                  }else{
                    if (snapshot.data.channelId == null|| snapshot.data.apiKey == null || snapshot.data.token == null){
                      return  MaterialApp(
                        debugShowCheckedModeBanner: false,
                        home: Scaffold(
                          // appBar: AppBar(),
                          body: SafeArea(
                            child: Stack(
                              children: [
                                Center(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(60),
                                            // top: ScreenUtil().setHeight(180)
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20.0),
                                            child: Image.asset(
                                              'lib/assets/images/logohinergi.jpg',
                                              scale: 6,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '$barcode',
                                          textAlign: TextAlign.center,
                                        ),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    
                                                    child: MyTextFormField(
                                                      // maxLength: 15,
                                                      hintText: 'Masukkan Channel Id anda',
                                                      labelText: 'Channel Id',
                                                      value: chanelId,
                                                      // isEmail: false,
                                                      validator: (String value) {
                                                        if (validator.isNull(value)) {
                                                          return 'Please enter a channel id';
                                                        }
                                                        return null;
                                                      },
                                                      onSaved: (String value) {
                                                        setting.channelId = value;
                                                      },
                                                      // textInputType: TextInputType.text,
                                                    ),
                                                  ),
                                                  // Flexible(
                                                  //   child: MyTextFormField(
                                                  //       validator: (String value) {
                                                  //         if (value.isEmpty) {
                                                  //           return "Isikan password";
                                                  //         }
                                                  //         return null;
                                                  //       },
                                                  //       onSaved: (String value) {
                                                  //         userData.password = value;
                                                  //       },
                                                  //       labelText: "Password",
                                                  //       textInputType: TextInputType.number),
                                                  // ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Flexible(
                                                      child: MyTextFormField(
                                                          hintText: 'Masukkan API Key anda',
                                                          labelText: 'API Key',
                                                          value: apiKey,
                                                          // isEmail: false,
                                                          validator: (String value) {
                                                            if (validator.isNull(value)) {
                                                              return 'Please enter a api key';
                                                            }
                                                            return null;
                                                          },
                                                          onSaved: (String value) {
                                                            setting.apiKey = value;
                                                          },
                                                          // textInputType: TextInputType.text)
                                                          )
                                                          )
                                                  // Flexible(
                                                  //   child: MyTextFormField(
                                                  //       validator: (String value) {
                                                  //         if (value.isEmpty) {
                                                  //           return "Isikan Api Key";
                                                  //         }
                                                  //         return null;
                                                  //       },
                                                  //       onSaved: (String value) {
                                                  //         userData.apiKey = value;
                                                  //       },
                                                  //       labelText: "Api Key",
                                                  //       textInputType: TextInputType.text),
                                                  // ),
                                                ],
                                              ),
                                               Row(
                                                children: [
                                                  Flexible(
                                                      child: MyTextFormField(
                                                          hintText: 'Masukkan token anda',
                                                          labelText: 'Token',
                                                          value: token,
                                                          // isEmail: false,
                                                          validator: (String value) {
                                                            if (validator.isNull(value)) {
                                                              return 'Please enter a  token';
                                                            }
                                                            return null;
                                                          },
                                                          onSaved: (String value) {
                                                            setting.token = value;
                                                          },
                                                          // textInputType: TextInputType.text)
                                                          )
                                                          )
                                                 
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(
                                              top: ScreenUtil().setHeight(40),
                                              left: ScreenUtil().setWidth(50),
                                              right: ScreenUtil().setWidth(50)),
                                          child: SizedBox(
                                            width: double.infinity,
                                            // minWidth: 200.0,
                                            height: 50.0,
                                            child : RaisedButton(
                                              textColor: Colors.black38,
                                              //rgb(4, 117, 116)
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25.0),
                                                side: BorderSide(color: Color.fromARGB(255,0,176,41))
                                              ),
                                              color: Colors.white,
                                              onPressed: () async {
                                                  try {
                                                    String barcode = await BarcodeScanner.scan();
                                                    setState(() {
                                                      // this.barcode = barcode;
                                                      chanelId = barcode.split(',')[0];
                                                      apiKey = barcode.split(',')[1];
                                                      token = barcode.split(',')[2];
                                                      print("Channe id adalah : $chanelId");
                                                        this.barcode = chanelId;
                                                      // if(chanelId.isEmpty && apiKey.isEmpty){
                                                      //     chanelId = barcode;
                                                      //   }else if(chanelId.isEmpty && apiKey.isNotEmpty){
                                                      //     chanelId = barcode;
                                                      //   }else if(chanelId.isNotEmpty && apiKey.isEmpty){
                                                      //     apiKey = barcode;
                                                      //   }else if(chanelId.isNotEmpty && apiKey.isNotEmpty){
                                                      //     chanelId = barcode;
                                                      //     apiKey = "";
                                                      //   }
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
                                              child: Text("SCAN"),
                                            ),
                                          )
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(
                                              top: ScreenUtil().setHeight(40),
                                              left: ScreenUtil().setWidth(50),
                                              right: ScreenUtil().setWidth(50)),
                                          child: SizedBox(
                                            width: double.infinity,
                                            // minWidth: 200.0,
                                            height: 50.0,
                                            child : RaisedButton(
                                              textColor: Colors.white,
                                              //rgb(4, 117, 116)
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25.0),
                                                // side: BorderSide(color: Colors.red)
                                              ),
                                              color: Color.fromARGB(255,0,176,41),
                                              onPressed: () {
                                                if (_formKey.currentState.validate()) {
                                                  _formKey.currentState.save();
                                                  setting.setApiChannel(setting);
                                                  // userData.saveDataUser(userData);
                                                  // print(userData.password);
                                                  // print(userData.nama);
                                                  // print(userData.apiKey);
                                                  // print(userData.channelId);
                                                  Fluttertoast.showToast(
                                                      msg: "Tersimpan",
                                                      toastLength: Toast.LENGTH_SHORT,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      // backgroundColor:
                                                      //     Color.fromARGB(255, 4, 117, 116),
                                                      textColor: Colors.black,
                                                      fontSize: 16.0);
                                                  Navigator.pushNamed(context, '/setting');
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) => mainScreen()),
                                                  // );
                                                }
                                              },
                                              child: Text("LOGIN"),
                                            ),
                                          )
                                        ),
                                        // Padding(
                                        //   padding:
                                        //       EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                                        //   child: OutlineButton(
                                        //     // textColor: Colors.blue,
                                        //     textColor: Color.fromARGB(255, 4, 117, 116),
                                        //     color: Color(0xFF6200EE),
                                        //     onPressed: () {
                                        //       // Navigator.push(
                                        //       //   context,
                                        //       //   MaterialPageRoute(
                                        //       //       builder: (context) => mainScreen()),
                                        //       // );

                                        //       // var data = await saveUserData.apiKey;
                                        //       // print(data);
                                        //     },
                                        //     child: Text(
                                        //       "Sudah punya akun, klik disini",
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          resizeToAvoidBottomInset: false,
                          // resizeToAvoidBottomPadding: false,
                        )
                      );
                    }else{
                      return HinergiApp();
                    }  
                  }
              }
            );
    
    
   
  }
}
