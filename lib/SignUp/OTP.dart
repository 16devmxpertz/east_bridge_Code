import 'dart:convert';

import 'package:east_bridge/Forgot%20Password/VarificationCode.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/Log%20In/Login.dart';
import 'package:east_bridge/SignUp/SignUp.dart';
import 'package:east_bridge/User%20Dashboard/UserDashboard.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
  static ValueNotifier<String> username = ValueNotifier("");

  static ValueNotifier<String> email = ValueNotifier("");

  static ValueNotifier<String> phoneNumber = ValueNotifier("");
  static ValueNotifier<String> role = ValueNotifier("");

  static ValueNotifier<String> password = ValueNotifier("");
  static ValueNotifier<String> phoneExtension = ValueNotifier("");
}

class _OtpState extends State<Otp> {
  @override
  void initState() {
    super.initState();
    print(Otp.email.value +
        Otp.password.value +
        Otp.username.value +
        Otp.phoneNumber.value);
  }

  TextEditingController otp = new TextEditingController();

  void senddata() async {
    int otpfinal = int.parse(otp.text);
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/OtpVerification/SignUp/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "otp": otpfinal,
        "userName": Otp.username.value,
        "email": Otp.email.value,
        "phoneExtension": Otp.phoneExtension.value,
        "phoneNumber": Otp.phoneNumber.value,
        "userType": Otp.role.value,
        "password": Otp.password.value,
        "approved": "false"
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'East Bridge signUp',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // margin: EdgeInsets.fromLTRB(0, 55, 0, 40),
                    width: 120,
                    // height: 80,
                    child: Image.asset('../../images/English-Logo.jpeg'),
                  )
                ],
              ),
              const Spacer(
                flex: 1,
              ),

              // form container----------------
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                  ],
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
                width: 440,
                // height: 350,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                margin: EdgeInsets.fromLTRB(11, 0, 11, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        // heading section --------------------
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 25, 0, 30),
                          padding: EdgeInsets.fromLTRB(11, 0, 11, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Container(
                                    // width: medi,
                                    // width: 172,
                                    ),
                              ),
                              Flexible(
                                child: Container(
                                  // width: 172,
                                  // margin: EdgeInsets.fromLTRB(381, 0, 205, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'OTP Verification',
                                        style: DashTextController.Heading,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // button row------------------------
                              Flexible(
                                child: Container(
                                  // width: 172,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // ------------1st

                                      Container(
                                        // width: 60,
                                        height: 16,
                                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding:
                                                EdgeInsets.fromLTRB(3, 0, 3, 0),
                                            side: BorderSide(
                                              width: 0.5,
                                              color: Color.fromRGBO(
                                                  215, 207, 207, 1),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                // width: 15,
                                                height: 7,
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 10, 0),
                                                child: Image.asset(
                                                    "../../images//En_Flag.png"),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Text(
                                                  'English',
                                                  style:
                                                      DashTextController.Lanbtn,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // -------------2nd

                                      Container(
                                        // width: 83,
                                        height: 16,
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              side: BorderSide(
                                                width: 0.5,
                                                color: Color.fromRGBO(
                                                    215, 207, 207, 1),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              )),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                // width: 15,
                                                height: 7,
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 10, 0),
                                                child: Image.asset(
                                                    "../../images/Ar_Flag.png"),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Text(
                                                  'Arabic',
                                                  style:
                                                      DashTextController.Lanbtn,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // button row end------------------------
                            ],
                          ),
                        ),
                        // heading section end ----------------

                        // input section --------------------

                        // user input ------------

                        Container(
                          width: 330,
                          // color: Colors.amber,
                          margin: EdgeInsets.fromLTRB(11, 0, 11, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                  child: Center(
                                    child: Text(
                                      'OTP',
                                      style: DashTextController.label,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 250,
                                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Pinput(
                                  length: 6,
                                  controller: otp,
                                  defaultPinTheme: PinTheme(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  ColorSelect.tabBorderColor),
                                          borderRadius:
                                              BorderRadius.circular(0.0),
                                          color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Submit button --------------

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 130,
                                height: 25,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(49, 106, 140, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2),
                                      )),
                                  onPressed: () {
                                    senddata();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Logins(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Submit',
                                    style: DashTextController.MainBtn,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          )),
    );
  }
}
