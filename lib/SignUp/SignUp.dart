import 'package:country_code_picker/country_code_picker.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/Log%20In/Login.dart';
import 'package:east_bridge/SignUp/OTP.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'dart:convert';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_localizations/flutter_localizations.dart';

TabController? tabController;

class SignUps extends StatefulWidget {
  SignUps({@required controller}) {
    tabController = controller;
  }

  @override
  State<SignUps> createState() => SignUp();
}

final _formKey = GlobalKey<FormState>();

TextEditingController _UserName = TextEditingController();
TextEditingController _userRole = TextEditingController();

TextEditingController _CompanyEmail = TextEditingController();
TextEditingController _Password = TextEditingController();
TextEditingController _ConfirmPassword = TextEditingController();
TextEditingController _PhoneNumber = TextEditingController();
CountryCode? countryCode;
String? userroledropdown;

class SignUp extends State<SignUps> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  void senddata() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/OtpVerification/GETOtp/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "username": _UserName.text,
        "email": _CompanyEmail.text,
        "phoneExtention": countryCode.toString(),
        "phoneNumber": _PhoneNumber.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        var r = response.body;
        print(r);
        if (r == "Email Already Exist") {
          Fluttertoast.showToast(
              msg: "Email Already Exist",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (r == "Phone Number Already Exist") {
          Fluttertoast.showToast(
              msg: "Phone Number Already Exist",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (r == "Username Already Exist") {
          Fluttertoast.showToast(
              msg: "Username Already Exist",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Otp.email.value = _CompanyEmail.text;
          Otp.password.value = _Password.text;
          Otp.username.value = _UserName.text;
          Otp.role.value = userroledropdown!;
          Otp.phoneNumber.value = _PhoneNumber.text;
          Otp.phoneExtension.value = countryCode.toString();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Otp(),
            ),
          );
        }
        print(jsonDecode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // margin: EdgeInsets.fromLTRB(0, 55, 0, 40),
                      width: 120,
                      height: 80,
                      child: Image.asset('images/English-Logo.jpeg'),
                    )
                  ],
                ),

                // form container----------------
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                    ],
                  ),
                  width: 500,
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
                                        S.of(context).SignUp,
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
                                                  "images/En_Flag.png"),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Text(
                                                "English",
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
                        child: Column(
                          children: [
                            Container(
                              width: 360,
                              // color: Colors.amber,
                              margin: EdgeInsets.fromLTRB(11, 0, 11, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                    child: Text(
                                      S.of(context).UserName,
                                      style: DashTextController.label,
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 250,
                                    margin: EdgeInsets.fromLTRB(28, 0, 0, 0),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: ColorSelect.textField,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _UserName,
                                      style: TextController.BodyText,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextController.inputErrorText,
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Company Email input -------------------------

                            Container(
                              width: 360,
                              // color: Colors.amber,
                              margin: EdgeInsets.fromLTRB(11, 0, 11, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Text(
                                      S.of(context).CompanyEmail,
                                      style: DashTextController.label,
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 250,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: ColorSelect.textField,
                                      ),
                                    ),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: _CompanyEmail,
                                      style: TextController.BodyText,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextController.inputErrorText,
                                        isDense: true,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // user role
                            Container(
                              width: 360,
                              // color: Colors.amber,
                              margin: EdgeInsets.fromLTRB(11, 0, 11, 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    child: Text(
                                      "User Role",
                                      style: DashTextController.label,
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 250,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: ColorSelect.textField,
                                      ),
                                    ),
                                    child: DropdownButton(
                                      hint: Text("Select Here",
                                          style: TextController.labelText),
                                      value: userroledropdown,
                                      isExpanded: true,
                                      underline: Container(),
                                      iconEnabledColor:
                                          ColorSelect.east_dark_blue,
                                      items: GlobalPermission.userRole.map(
                                        (String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(
                                              items,
                                              style: TextController.BodyText,
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (NewValue) {
                                        setState(
                                          () {
                                            userroledropdown = NewValue;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // password input -------------------------

                            Container(
                              width: 360,
                              // color: Colors.amber,
                              margin: EdgeInsets.fromLTRB(11, 0, 11, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                    child: Text(
                                      S.of(context).Password,
                                      style: DashTextController.label,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    margin: EdgeInsets.fromLTRB(35, 0, 0, 0),
                                    height: 35,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: ColorSelect.textField,
                                      ),
                                    ),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      obscureText: !_passwordVisible,
                                      controller: _Password,
                                      style: TextController.BodyHeadingText,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
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
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Confirm password input -------------------------

                            Container(
                              width: 370,
                              // color: Colors.amber,

                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              margin: EdgeInsets.fromLTRB(11, 0, 11, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),

                                    child: Text(
                                      S.of(context).confirmPassword,
                                      style: DashTextController.label,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    height: 35,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      border: Border.all(
                                        color: Color.fromRGBO(215, 214, 214, 1),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: TextFormField(
                                      obscureText: !_confirmPasswordVisible,
                                      controller: _ConfirmPassword,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      style: TextController.BodyHeadingText,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
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
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Phone Number Input--------------------

                            Container(
                              width: 360,
                              // color: Colors.amber,
                              margin: EdgeInsets.fromLTRB(11, 0, 11, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                    child: Text(
                                      S.of(context).PhoneNumber,
                                      style: DashTextController.label,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                    height: 35,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      border: Border.all(
                                        color: Color.fromRGBO(215, 214, 214, 1),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        CountryCodePicker(
                                          onChanged: (value) {
                                            countryCode = value;
                                          },
                                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                          initialSelection: 'sa',
                                          favorite: const ['+39', 'FR'],
                                          showFlagDialog: false,
                                          dialogTextStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),

                                          //Get the country information relevant to the initial selection
                                        ),
                                        Flexible(
                                          child: Container(
                                            width: 150,
                                            height: 35,
                                            child: TextFormField(
                                              textAlign: TextAlign.left,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              controller: _PhoneNumber,
                                              style: TextController.BodyText,
                                              keyboardType:
                                                  TextInputType.number,
                                              // validator: numberValidator,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'This field is required.';
                                                }
                                                return null; // Return null if the input is valid
                                              },
                                              decoration: InputDecoration(
                                                isDense: true,
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Container(
                            //   width: 360,
                            //   // color: Colors.amber,
                            //   margin: EdgeInsets.fromLTRB(11, 0, 11, 20),
                            //   child: Text(
                            //     _errorMessage,
                            //     style: TextStyle(color: Colors.red),
                            //   ),
                            // ),

                            // SignUp button --------------

                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                                        if (_formKey.currentState!.validate()) {
                                          if (RegExp(
                                                  "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                              .hasMatch(_CompanyEmail.text)) {
                                            if (_Password.text ==
                                                _ConfirmPassword.text) {
                                              senddata();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Confirm Password Do Not Match",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: "Enter Valid Email",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        }

                                        // if (!RegExp(
                                        //         "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                        //     .hasMatch(
                                        //         _CompanyEmail.text)) {
                                        // Fluttertoast.showToast(
                                        //     msg:
                                        //         "Enter Valid Email",
                                        //     toastLength:
                                        //         Toast.LENGTH_SHORT,
                                        //     gravity:
                                        //         ToastGravity.CENTER,
                                        //     timeInSecForIosWeb: 1,
                                        //     backgroundColor:
                                        //         Colors.red,
                                        //     textColor: Colors.white,
                                        //     fontSize: 16.0);
                                        // if (_Password.text !=
                                        //     _ConfirmPassword.text) {
                                        // Fluttertoast.showToast(
                                        //     msg:
                                        //         "Confirm Password Do Not Match",
                                        //     toastLength: Toast
                                        //         .LENGTH_SHORT,
                                        //     gravity: ToastGravity
                                        //         .CENTER,
                                        //     timeInSecForIosWeb: 1,
                                        //     backgroundColor:
                                        //         Colors.red,
                                        //     textColor:
                                        //         Colors.white,
                                        //     fontSize: 16.0);

                                        //     if ((_formKey
                                        //         .currentState!
                                        //         .validate())) {

                                        //         }
                                        //     // else {
                                        // Navigator.of(context)
                                        //     .push(
                                        //   MaterialPageRoute(
                                        //     builder:
                                        //         (context) =>
                                        //             Otp(),
                                        //   ),
                                        // );
                                        //     // }
                                        //   }
                                        // }
                                        // senddata();
                                        // Otp.email.value =
                                        //     _CompanyEmail.text;
                                        // Otp.password.value =
                                        //     _Password.text;
                                        // Otp.username.value =
                                        //     _UserName.text;
                                        // Otp.phoneNumber.value =
                                        //     _PhoneNumber.text;
                                      },
                                      child: Text(
                                        S.of(context).SignUp,
                                        style: DashTextController.MainBtn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Login sec--------------------

                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.fromLTRB(290, 0, 0, 0),
                                    child: Text.rich(
                                      TextSpan(
                                        text:
                                            S.of(context).Alreadyhaveanaccount,
                                        style: TextStyle(
                                          fontFamily: 'Gotham',
                                          fontSize: 9,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF565252),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: S.of(context).LogIn,
                                            style: DashTextController.Textlink,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Logins(),
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
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
