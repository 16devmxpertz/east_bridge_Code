import 'dart:convert';

import 'package:east_bridge/Forgot%20Password/VarificationCode.dart';
import 'package:east_bridge/SignUp/SignUp.dart';
import 'package:east_bridge/User%20Dashboard/UserDashboard.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordNew extends StatefulWidget {
  const ForgotPasswordNew({super.key});

  @override
  State<ForgotPasswordNew> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordNew> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _CompanyEmail = TextEditingController();

  void senddata() async {
    var url = Uri.parse(
        'https://eastbridge.online/apicore/api/forgetpassword/ForgotPassword/sendlink/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "email": _CompanyEmail.text,
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("yesss200s");
        print(response.body);
        var r = response.body;
        Varification.email.value = _CompanyEmail.text;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Varification(),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Email Not Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'East Bridge Forgot Password',
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
                                    'Forgot Password',
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
                                  Spacer(
                                    flex: 2,
                                  ),
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
                                          color:
                                              Color.fromRGBO(215, 207, 207, 1),
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
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Text(
                                              'English',
                                              style: DashTextController.Lanbtn,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  // -------------2nd

                                  Container(
                                    // width: 83,
                                    height: 16,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                            margin:
                                                EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            child: Text(
                                              'Arabic',
                                              style: DashTextController.Lanbtn,
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

                    // email input ------------

                    Form(
                      key: _formKey,
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              width: 330,
                              // color: Colors.amber,
                              margin: EdgeInsets.fromLTRB(11, 0, 11, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                    child: Text(
                                      'Email',
                                      style: DashTextController.label,
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      height: 35,
                                      width: 250,
                                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      child: TextFormField(
                                        controller: _CompanyEmail,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  215, 214, 214, 1),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  138, 138, 138, 1),
                                            ),
                                          ),
                                        ),
                                      ),
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
                                          primary:
                                              Color.fromRGBO(49, 106, 140, 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          )),
                                      onPressed: () {
                                        if (_CompanyEmail.text.isEmpty) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please Enter All the Fields",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else if (!RegExp(
                                                "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                            .hasMatch(_CompanyEmail.text)) {
                                          Fluttertoast.showToast(
                                              msg: "Enter Valid Email",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          senddata();
                                        }
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
                        ),
                      ),
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
