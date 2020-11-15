import 'package:flutter/material.dart';
import 'package:hinergi_v9/model/setting.dart';
import 'package:hinergi_v9/setting/model/MyTextFormField.dart';
// import 'package:hinergi_kwh/view/buttonDate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart' as validator;

class SettingPage extends StatelessWidget {
  Setting setting = Setting();
  Setting seter = Setting();
  SettingPage();
  
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
                    return new Scaffold(
                      body : SingleChildScrollView(
                            child :  Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  AppBar(
                                    title: Text('Pengaturan'),
                                    backgroundColor : Color.fromARGB(255, 4, 117, 116),
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
                                    value: snapshot.data.channelId ?? 0,
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
                                    value: snapshot.data.apiKey  ?? 0,
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
                                    value: snapshot.data.token  ?? 0,
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
                                    value: snapshot.data.tarifPerKwh.toString() ?? '0',
                                    isEmail: false,
                                    icon: Icon(Icons.money),
                                    validator: (String value) {
                                      if (!validator.isFloat(value)) {
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
                                    value: snapshot.data.budgetMax.toString() ?? '0',
                                    isEmail: false,
                                    icon: Icon(Icons.money_off_rounded),
                                    validator: (String value) {
                                      if (!validator.isFloat(value)) {
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
                                    value: snapshot.data.kwhMax.toString() ?? '0',
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
                                    // alignment: Alignment.topRight,
                                    child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                   width: double.infinity,
                                                  // minWidth: 200.0,
                                                  height: 50.0,
                                                  child: RaisedButton(
                                                    // color: Colors.blueAccent,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(25.0),
                                                      // side: BorderSide(color: Colors.red)
                                                    ),
                                                    color: Color.fromARGB(255,0,176,41),
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
                                  ),
                                  
                                ]
                              )
                          )
                    )
                    );
                  }else{
                    return new Scaffold(
                      body: SingleChildScrollView(
                            child : Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
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
                                                )
                                    )
                                  ),
                                  
                                ]
                              )
                          )
                    )
                  
                    );
                  }
              },
    );
          
  }
}
