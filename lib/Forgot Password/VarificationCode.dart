import 'dart:convert';

import 'package:east_bridge/Log%20In/Login.dart';
import 'package:east_bridge/SignUp/SignUp.dart';
import 'package:east_bridge/User%20Dashboard/UserDashboard.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';

class Varification extends StatefulWidget {
  const Varification({super.key});

  @override
  State<Varification> createState() => _VarificationState();
  static ValueNotifier<String> email = ValueNotifier("");
}

GlobalKey<FormState> _formKey = GlobalKey<FormState>();
TextEditingController _VarificationCode = TextEditingController();
TextEditingController _Password = TextEditingController();
TextEditingController _ConfirmPassword = TextEditingController();
TextEditingController _email = TextEditingController();

class _VarificationState extends State<Varification> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _email.text = Varification.email.value;
  }

  void senddata() async {
    var url = Uri.parse(
        'https://eastbridge.online/apicore/api/forgetpassword/ForgotPassword/changepassword/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "newPassword": _Password.text,
        "email": _email.text,
        "token": _VarificationCode.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("yesss200s");
        print(response.body);
        var r = response.body;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Logins(),
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
      title: 'East Bridge Varification',
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
                width: 550,
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
                                      Flexible(
                                        child: Text(
                                          'Create New Password',
                                          style: DashTextController.Heading,
                                        ),
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
                                      Spacer(),
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

                        Form(
                          key: _formKey,
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
                                        'Verification Code',
                                        style: DashTextController.label,
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        height: 25,
                                        width: 250,
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Pinput(
                                          length: 4,
                                          controller: _VarificationCode,
                                          defaultPinTheme: PinTheme(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .tabBorderColor),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: 330,
                                // color: Colors.amber,
                                margin: EdgeInsets.fromLTRB(11, 0, 11, 20),
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
                                        margin:
                                            EdgeInsets.fromLTRB(50, 0, 0, 0),
                                        height: 35,
                                        width: 225,
                                        child: TextFormField(
                                          controller: _email,
                                          style: TextStyle(
                                            fontSize: 12,
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

                              // password input -------------------------

                              Container(
                                width: 330,
                                // color: Colors.amber,
                                margin: EdgeInsets.fromLTRB(11, 0, 11, 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                      child: Text(
                                        'New Password',
                                        style: DashTextController.label,
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(33, 0, 0, 0),
                                        height: 35,
                                        width: 250,
                                        child: TextFormField(
                                          obscureText: !_passwordVisible,
                                          controller: _Password,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 12,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
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
                              Container(
                                width: 330,
                                // color: Colors.amber,
                                margin: EdgeInsets.fromLTRB(11, 0, 11, 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                      child: Text(
                                        'Confirm Password',
                                        style: DashTextController.label,
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(15, 0, 0, 0),
                                        height: 35,
                                        width: 250,
                                        child: TextFormField(
                                          obscureText: !_confirmPasswordVisible,
                                          controller: _ConfirmPassword,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _confirmPasswordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                size: 12,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _confirmPasswordVisible =
                                                      !_confirmPasswordVisible;
                                                });
                                              },
                                            ),
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
                                          ),
                                        ),
                                        onPressed: () {
                                          if (_VarificationCode.text.isEmpty ||
                                              _Password.text.isEmpty ||
                                              _ConfirmPassword.text.isEmpty ||
                                              _email.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please Enter All the Fields",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          } else if (_Password.text !=
                                              _ConfirmPassword.text) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Confirm Password Do Not Match",
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

                        // input section end --------------------
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
