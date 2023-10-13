import 'dart:convert';

import 'package:east_bridge/Forgot%20Password/ForgotPassword.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/SignUp/SignUp.dart';
import 'package:east_bridge/User%20Management/UserManagement.dart';
import 'package:east_bridge/dropdownValuesGlobal.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/LandingPage.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

TabController? tabController;

class Logins extends StatefulWidget {
  Logins({@required controller}) {
    tabController = controller;
  }
  @override
  State<Logins> createState() => Login();
}

TextEditingController _Email = TextEditingController();
TextEditingController _Password = TextEditingController();
final _formKey = GlobalKey<FormState>();

class Login extends State<Logins> {
  bool _passwordVisible = false;

  int id = 0;

  void senddata() async {
    var url =
        Uri.parse('${GlobalPermission.urlLink}/api/OtpVerification/LoginData/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {"credential": _Email.text, "password": _Password.text};

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        var r = response.body;

        GlobalPermission.SetDefault();
        DropdownValuesGlobal.getDropownValues("English");

        if (r == "Wrong") {
          Fluttertoast.showToast(
              msg: "Invalid Credentials",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          GlobalPermission.getCountries();
          GlobalPermission.employeeId = int.parse(r.split("-")[0]);
          GlobalPermission.userType = r.split("-")[1];

          if ("Admin" == r.split("-")[1]) {
            var response = await GlobalPermission.getnotoficationslist(
                GlobalPermission.userType);
            Fluttertoast.showToast(
                msg: "Welcome Admin",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LandingPage(),
            ));
          } else {
            Fluttertoast.showToast(
                msg: "Welcome ${GlobalPermission.userType}",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            var response = await GlobalPermission.getnotoficationslist(
                GlobalPermission.userType);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LandingPage(),
              ),
            );
          }
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'East Bridge Login',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Form(
            key: _formKey,
            child: Column(
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
                      child: Image.network(
                          '${GlobalPermission.urlLink}/api/CompanyDetail/GetCompanyLogo?language=English'),
                    )
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),

                // form container----------------
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                      ],
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    width: 440,
                    // height: 290,
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
                                  alignment: Alignment.center,
                                  // width: 172,
                                  // margin: EdgeInsets.fromLTRB(381, 0, 205, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          'Log In',
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
                                                    "images/En_Flag.png"),
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
                                                    "images/Ar_Flag.png"),
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
                              Container(
                                // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                child: Text(
                                  'User Name',
                                  style: DashTextController.label,
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 250,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: ColorSelect.textField,
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  controller: _Email,
                                  style: TextController.BodyText,
                                  textAlignVertical: TextAlignVertical.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    errorStyle: TextController.inputErrorText,
                                    border: InputBorder.none,

                                    // focusedBorder: OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.circular(0),
                                    //   borderSide: BorderSide(
                                    //     color: Color.fromRGBO(
                                    //         138, 138, 138, 1),
                                    //   ),
                                    // ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                child: Text(
                                  'Password',
                                  style: DashTextController.label,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(32, 0, 0, 0),
                                padding: EdgeInsets.only(left: 5),
                                height: 35,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: ColorSelect.textField,
                                  ),
                                ),
                                child: TextFormField(
                                  obscureText: !_passwordVisible,
                                  controller: _Password,
                                  style: TextController.BodyText,
                                  textAlignVertical: TextAlignVertical.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    isDense: true,
                                    errorStyle: TextController.inputErrorText,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 12,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),

                                    // focusedBorder: OutlineInputBorder(
                                    //   borderRadius:
                                    //       BorderRadius.circular(0),
                                    //   borderSide: BorderSide(
                                    //     color: Color.fromRGBO(
                                    //         138, 138, 138, 1),
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // forgot password sec--------------------

                        Container(
                          width: 170,
                          // margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                // margin: EdgeInsets.fromLTRB(290, 0, 0, 0),
                                child: Text.rich(
                                  TextSpan(
                                    text: 'Forgot Password?',
                                    style: DashTextController.Textlink,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPasswordNew(),
                                              ),
                                            )
                                          },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // SignUp button --------------

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
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
                                    if (_formKey.currentState!.validate()) {
                                      senddata();
                                    }
                                    // if (_Email.text.isEmpty ||
                                    //     _Password.text.isEmpty) {
                                    //   Fluttertoast.showToast(
                                    //       msg:
                                    //           "Please Enter All the Fields",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.CENTER,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.red,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0);
                                    // } else if (!RegExp(
                                    //         "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    //     .hasMatch(_Email.text)) {
                                    //   Fluttertoast.showToast(
                                    //       msg: "Enter Valid Email",
                                    //       toastLength: Toast.LENGTH_SHORT,
                                    //       gravity: ToastGravity.CENTER,
                                    //       timeInSecForIosWeb: 1,
                                    //       backgroundColor: Colors.red,
                                    //       textColor: Colors.white,
                                    //       fontSize: 16.0);
                                    // } else {
                                    //   senddata();
                                    // }
                                  },
                                  child: Text(
                                    'Log In',
                                    style: DashTextController.MainBtn,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 25, 0, 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // margin: EdgeInsets.fromLTRB(290, 0, 0, 0),
                                child: Text.rich(
                                  TextSpan(
                                    text: S.of(context).DontHaveAnAcc,
                                    style: TextStyle(
                                      fontFamily: 'Gotham',
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF565252),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: S.of(context).SignIn,
                                        style: DashTextController.Textlink,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUps(),
                                                  ),
                                                )
                                              },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.symmetric(vertical: 5),
                        //   child: Center(
                        //       child: Text(
                        //           "version-- ${GlobalPermission.version}",style:TextStyle(
                        //               fontFamily: 'Gotham',
                        //               fontSize: 9,
                        //               fontWeight: FontWeight.w400,
                        //               color: Color(0xFF565252),
                        //             ),)),
                        // ),
                      ],
                    ),
                  ),
                ),
                const Spacer(
                  flex: 5,
                ),
              ],
            ),
          )),
    );
  }
}
