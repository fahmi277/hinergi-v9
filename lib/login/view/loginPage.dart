import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hinergi_v9/login/model/formField.dart';
import 'package:hinergi_v9/login/model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart' as validator;

// import '../mainScreen.dart';

class loginPage extends StatefulWidget {
  @override
  _loginPageState createState() => _loginPageState();
}

final _formKey = GlobalKey<FormState>();

class _loginPageState extends State<loginPage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: false);

    UserData userData = UserData();
    UserData saveUserData = UserData();
    return MaterialApp(
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
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    
                                    child: MyTextFormField(
                                      // maxLength: 15,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "Isikan nama";
                                        }
                                        return null;
                                      },
                                      onSaved: (String value) {
                                        userData.nama = value.toUpperCase();
                                      },
                                      labelText: "Nama",
                                      textInputType: TextInputType.text,
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
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "Isikan Channel ID";
                                            }
                                            return null;
                                          },
                                          onSaved: (String value) {
                                            userData.channelId = value;
                                          },
                                          labelText: "Channel ID",
                                          textInputType: TextInputType.number)),
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
                              textColor: Colors.white,
                              //rgb(4, 117, 116)
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                              color: Color.fromARGB(255, 4, 117, 116),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  userData.saveDataUser(userData);
                                  print(userData.password);
                                  print(userData.nama);
                                  print(userData.apiKey);
                                  print(userData.channelId);
                                  Fluttertoast.showToast(
                                      msg: "Tersimpan",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          Color.fromARGB(255, 4, 117, 116),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => mainScreen()),
                                  // );
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
                              color: Color.fromARGB(255, 4, 117, 116),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  userData.saveDataUser(userData);
                                  print(userData.password);
                                  print(userData.nama);
                                  print(userData.apiKey);
                                  print(userData.channelId);
                                  Fluttertoast.showToast(
                                      msg: "Tersimpan",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor:
                                          Color.fromARGB(255, 4, 117, 116),
                                      textColor: Colors.white,
                                      fontSize: 16.0);
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
        ));
  }
}
