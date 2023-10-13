import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/GlobalPOA.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/SignUp/SignUp.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../RiskAssessmentFormInvidual.dart';

class EmployerInfoPOA extends StatefulWidget {
  EmployerInfoPOA({@required controller}) {
    tabController = controller;
  }

  @override
  State<EmployerInfoPOA> createState() => _EmployerInfoPOAState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

class _EmployerInfoPOAState extends State<EmployerInfoPOA>
    with TickerProviderStateMixin {
  String btn = "Next";
  // EmployerInfoPOA({@required controller}) {
  //   tabController = controller;
  // }

  bool _employerNameError = false;
  bool _employerAddressError = false;
  bool _durationError = false;
  bool _specifyError = false;

  final _formKey = GlobalKey<FormState>();
  bool networthError = false;
  bool employerPhoneError = false;
  TextEditingController _employerName = new TextEditingController();
  TextEditingController _employerAddress = new TextEditingController();
  TextEditingController _employerPhone = new TextEditingController();
  TextEditingController _duration = new TextEditingController();
  TextEditingController _specify = new TextEditingController();

  String? dropdownvalue;
  String code = "";
  @override
  void initState() {
    super.initState();
    // getdata(9151);

    print("Init Runnng");
    if (GlobalPOA.poadraftprogress["EmployerInformationPOA"] == true) {
      print("ftechinggg----------");
      getdata(GlobalPOA.poalclientid);
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/EmployerInformationPOA/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // await Future.delayed(Duration(seconds: 2));

      setState(() {
        dropdownvalue = data["postionTitle"];
      });
      _employerName.text = data["employerName"];
      _employerAddress.text = data["employerAddress"];
      _employerPhone.text = data["employerPhoneNumber"];
      _duration.text = data["durationOfEmployement"];
    } else {
      print(response.statusCode);
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
    }
  }

  void senddata() async {
    setState(() {
      btn = "Loading...";
    });
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/EmployerInformationPOA/EmployerInformationPOA/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalPOA.poalclientid,
        "EmployerName": _employerName.text,
        "EmployerAddress": _employerAddress.text,
        "EmployerPhoneNumber": _employerPhone.text,
        "DurationOfEmployement": _duration.text,
        "PostionTitle": dropdownvalue,
        "phoneCode": code
      };
      print(body);

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        GlobalPOA.getdraftprogresspoa(GlobalPOA.poalclientid);
        tabController?.animateTo(4);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
        print(response.statusCode);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  S.of(context).Status,
                  style: TextController.SubHeadingText,
                ),
                content: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).SomethingWentWrong + "!",
                        style: TextController.BodyText,
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void putdata(int clientId) async {
    setState(() {
      btn = "Loading...";
    });
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/EmployerInformationPOA/EmployerInformationPOAPut?ClientId=${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "EmployerName": _employerName.text,
        "EmployerAddress": _employerAddress.text,
        "EmployerPhoneNumber": _employerPhone.text,
        "DurationOfEmployement": _duration.text,
        "PostionTitle": dropdownvalue,
        "phoneCode": code
      };
      print(body);

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController?.animateTo(4);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
        print(response.statusCode);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  S.of(context).Status,
                  style: TextController.SubHeadingText,
                ),
                content: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).SomethingWentWrong + "!",
                        style: TextController.BodyText,
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    var items = [
      'Senior Politician',
      'Ruling Family',
      'Judicial',
      'Military',
      'Minister',
      'Self Employed',
      'Lawyer',
      'Student',
      'Retired',
      'Employee',
      'Other'
    ];

    // @override
    // void initState(){
    //   super.initState();
    //   dateController.text=" ";
    // }

    return Container(
      height: MediaQuery.of(context).size.height,
      //color: Colors.white,
      child: Scaffold(
        body: Container(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).EmployerName,
                                    style: TextController.BodyText,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 270,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller: _employerName,
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: S.of(context).TypeHere,
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextStyle(height: 0.0),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  _employerNameError = true;
                                                });
                                                return '';
                                              } else {
                                                setState(() {
                                                  _employerNameError = false;
                                                });
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                          ),
                                        ),
                                        if (_employerNameError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This field is required",
                                              style: TextController.errorText,
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).EmployerAddress,
                                    style: TextController.BodyText,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsetsDirectional.symmetric(
                                                  horizontal: 15),
                                          width: 270,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller: _employerAddress,
                                            style: TextController.BodyText,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: S.of(context).TypeHere,
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextStyle(height: 0.0),
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  _employerAddressError = true;
                                                });
                                                return '';
                                              } else {
                                                setState(() {
                                                  _employerAddressError = false;
                                                });
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                          ),
                                        ),
                                        if (_employerAddressError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This field is required",
                                              style: TextController.errorText,
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      S.of(context).EmployerPhone,
                                      style: TextController.BodyText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          width: 270,
                                          height: 35,
                                          child: IntlPhoneField(
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            disableLengthCheck: true,
                                            // dropdownDecoration : BoxDecoration(
                                            //   shape : BoxShape.rectangle,
                                            // ),
                                            // initialCountryCode: "",
                                            // validator: (value) {
                                            //   if (value!.number == "") {
                                            //     print(
                                            //         "++++++++++++++++");
                                            //     return 'Enter a valid phone number';
                                            //   }
                                            //   return null;
                                            // },

                                            autovalidateMode:
                                                AutovalidateMode.disabled,
                                            showDropdownIcon: false,
                                            pickerDialogStyle:
                                                PickerDialogStyle(
                                              width: 400,
                                            ),
                                            showCountryFlag: false,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller: _employerPhone,
                                            dropdownTextStyle:
                                                TextController.BodyText,
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              counterText: "",
                                              hintText:
                                                  S.of(context).ResPhLabel,
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle: TextStyle(
                                                fontFamily: 'Gotham',
                                                fontSize: 7.0,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500,
                                                height: 0.01,
                                              ),
                                            ),
                                            onCountryChanged: (country) {
                                              print('Country changed to: ' +
                                                  country.name);
                                            },
                                          ),
                                        ),
                                        if (employerPhoneError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This field is required",
                                              style: TextController.errorText,
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      S.of(context).DurationOfEmployment,
                                      style: TextController.BodyText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 270,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            controller: _duration,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: S.of(context).TypeHere,
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextStyle(height: 0.0),
                                            ),
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  _durationError = true;
                                                });
                                                return '';
                                              } else {
                                                setState(() {
                                                  _durationError = false;
                                                });
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                          ),
                                        ),
                                        if (_durationError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This field is required",
                                              style: TextController.errorText,
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).Position,
                                    style: TextController.BodyText,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 270,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: DropdownButton(
                                            hint: Text(
                                              S.of(context).SelectHere,
                                              style: TextController.labelText,
                                            ),
                                            value: dropdownvalue,
                                            isExpanded: true,
                                            underline: Container(),
                                            iconEnabledColor:
                                                ColorSelect.east_dark_blue,
                                            items: items.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items,
                                                    style: TextController
                                                        .BodyText),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                networthError = false;
                                                dropdownvalue = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                        if (networthError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This field is required.",
                                              style: TextController.errorText,
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            (dropdownvalue == "Other")
                                ? Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: double.infinity,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  _specifyError = true;
                                                });
                                                return '';
                                              } else {
                                                setState(() {
                                                  _specifyError = false;
                                                });
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            controller: _specify,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "Please Specify",
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextStyle(height: 0.0),
                                            ),
                                          ),
                                        ),
                                        if (_specifyError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This field is required",
                                              style: TextController.errorText,
                                            ),
                                          )
                                      ],
                                    ),
                                  )
                                : Flexible(
                                    child: Container(),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 35,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: ColorSelect.tabBorderColor)),
                              child: TextButton(
                                onPressed: () {
                                  tabController?.animateTo(2);
                                }, // Switch tabs
                                child: Text(
                                  S.of(context).Back,
                                  style: TextController.SideMenuText,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Container(
                                height: 35,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: ColorSelect.east_blue,
                                    border: Border.all(
                                        color: ColorSelect.tabBorderColor)),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        ColorSelect.east_blue),
                                  ),
                                  onPressed: () {
                                    print("Employeeee");
                                    print(_formKey.currentState?.validate());
                                    if (_formKey.currentState != null) {
                                      setState(() {
                                        networthError = dropdownvalue == null;
                                        employerPhoneError =
                                            _employerPhone.text == "";
                                      });

                                      if ((_formKey.currentState!.validate()) &&
                                          (!employerPhoneError &&
                                              !networthError)) {
                                        _formKey.currentState?.save();
                                        if (GlobalPOA.poadraftprogress[
                                                "EmployerInformationPOA"] ==
                                            true) {
                                          putdata(GlobalPOA.poalclientid);
                                        } else {
                                          if (GlobalPOA.poalclientid != 0) {
                                            senddata();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please fill personal info first",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }
                                        }
                                      }
                                    } else {
                                      // Handle case where _formKey.currentState is null
                                    }
                                    // tabController?.animateTo(5);
                                  }, // Switch tabs
                                  child: Text(
                                    btn,
                                    style: TextController.btnText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
