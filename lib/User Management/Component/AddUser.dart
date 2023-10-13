import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/User%20Management/Component/Permission.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  AddUser({@required controller}) {
    tabController = controller;
  }

  @override
  State<AddUser> createState() => _AddUserState();
}

TabController? tabController;

TextEditingController _UserName = TextEditingController();
TextEditingController _CompanyEmail = TextEditingController();
TextEditingController _Password = TextEditingController();
TextEditingController _ConfirmPassword = TextEditingController();
TextEditingController _PhoneNumber = TextEditingController();
CountryCode? countryCode;

class _AddUserState extends State<AddUser> {
  int? selectedValue = 0;
  AddUser({@required controller}) {
    tabController = controller;
  }

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  int _value = 0;
  var item = [
    'Admin',
    'Compliance',
    'Relationship Manager',
    'Investment Department',
    'Operation Manager',
    'Portfolio Manager',
    'Finance Manager',
    'CEO'
  ];

  bool userRole = false;
  late final id;

  String? userroledropdown;
  final _formKey = GlobalKey<FormState>();
  void senddata() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/OtpVerification/SignUpFromADmin/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "otp": 0,
        "userName": _UserName.text,
        "email": _CompanyEmail.text,
        "phoneExtension": countryCode.toString(),
        "phoneNumber": _PhoneNumber.text,
        "userType": userroledropdown,
        "password": _Password.text,
        "approved": "false"
      };
      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        id = int.parse(response.body);

        return id;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Container(
                width: 100,
                child: Text(
                  'User Detail',
                  style: DashFormTextController.SubHeading,
                ),
              ),
            ),
            Container(
              // height: 800,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(0, 24, 0, 24),
              padding: EdgeInsets.fromLTRB(32, 26, 32, 26),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(blurRadius: 2, color: Color.fromRGBO(0, 0, 0, 0.2)),
                ],
                color: Color(0xFFFFFFFF),
              ),

              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 44,
                                      child: Center(
                                        child: Text(
                                          'User Name',
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 44,
                                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: Center(
                                        child: Text(
                                          S.of(context).EmailId,
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 44,
                                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: Center(
                                        child: Text(
                                          'Password',
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 450,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: ColorSelect.textField,
                                          ),
                                        ),
                                        child: TextFormField(
                                          style: TextController.BodyText,
                                          controller: _UserName,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        width: 450,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: ColorSelect.textField,
                                          ),
                                        ),
                                        margin:
                                            EdgeInsets.fromLTRB(0, 15, 0, 0),
                                        child: TextFormField(
                                          style: TextController.BodyText,
                                          controller: _CompanyEmail,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        height: 35,
                                        width: 450,
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
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 65,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 44,
                                      child: Center(
                                        child: Text(
                                          'User Role',
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 44,
                                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: Center(
                                        child: Text(
                                          'Phone Number',
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 44,
                                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: Center(
                                        child: Text(
                                          'Confirm Password',
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 450,
                                        height: 35,
                                        margin:
                                            EdgeInsets.fromLTRB(0, 0, 0, 10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
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
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (NewValue) {
                                            setState(
                                              () {
                                                userRole = false;
                                                userroledropdown = NewValue;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      if (userRole)
                                        Text(
                                          "This field is required.",
                                          style: TextController.errorText,
                                        ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 15, 0, 0),
                                        height: 35,
                                        width: 450,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          border: Border.all(
                                            color: Color.fromRGBO(
                                                215, 214, 214, 1),
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
                                                width: 450,
                                                height: 35,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  textAlign: TextAlign.left,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  controller: _PhoneNumber,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xFF070404),
                                                  ),
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
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        height: 35,
                                        width: 450,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          border: Border.all(
                                            color: ColorSelect.textField,
                                          ),
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Radios
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      width: double.infinity,
                      height: 35,
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Container(
                                //   height: 35,
                                //   child: Center(
                                //     child: Text(
                                //       'Gender',
                                //       style: TextController.BodyText,
                                //     ),
                                //   ),
                                // ),
                                // Flexible(
                                //   child: Container(
                                //     width: 450,
                                //     child: Row(
                                //       children: [
                                //         Text(
                                //           'Male',
                                //           style: TextController.BodyText,
                                //         ),
                                //         // male radio
                                //         Radio(
                                //           value: 1,
                                //           groupValue: _value,
                                //           onChanged: (value) {
                                //             setState(() {
                                //               _value = value!;
                                //             });
                                //           },
                                //         ),
                                //         Text(
                                //           'Female',
                                //           style: TextController.BodyText,
                                //         ),
                                //         // female radio
                                //         Radio(
                                //           value: 2,
                                //           groupValue: _value,
                                //           onChanged: (value) {
                                //             setState(() {
                                //               _value = value!;
                                //             });
                                //           },
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            width: 75,
                          ),
                          Expanded(flex: 1, child: Container())
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  width: 140,
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  color: ColorSelect.east_blue,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      side: BorderSide(
                        width: 1.0,
                        color: Color(0xFFC9BBBB),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      //   tabController!.animateTo(1);
                      // }

                      if (_formKey.currentState!.validate()) {
                        if (RegExp(
                                "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(_CompanyEmail.text)) {
                          if (userroledropdown != null) {
                            if (_Password.text == _ConfirmPassword.text) {
                              senddata();
                              // Otp.email.value = _CompanyEmail.text;
                              // Otp.password.value = _Password.text;
                              // Otp.username.value = _UserName.text;
                              // Otp.phoneNumber.value = _PhoneNumber.text;
                              // Otp.phoneExtension.value = countryCode.toString();
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => Otp(),
                              //   ),
                              // );
                              // Permission.name.value = _UserName.text;
                              Permission.id.value = id;

                              Permission.role.value = userroledropdown!;
                              tabController!.animateTo(1);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Confirm Password Do Not Match",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            setState(() {
                              userRole = true;
                            });
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
                    },
                    child: Text(
                      S.of(context).Next,
                      style: TextController.btnText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class AddUser extends StatefulWidget {
//   const AddUser({@required controller}){
//     tabController = controller;
//   }

//   @override
//   State<AddUser> createState() => _AddUserState();
// }

// TabController? tabController;


// class _AddUserState extends State<AddUser> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }