import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class GeneralInfo extends StatefulWidget {
  GeneralInfo({@required controller}) {
    tabController = controller;
  }
  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

class _GeneralInfoState extends State<GeneralInfo> {
  String btn = "Next";

  final _formKey = GlobalKey<FormState>();
  int? selectedValue = 0;
  // GeneralInfo({@required controller}) {
  //   tabController = controller;
  // }

  TextEditingController _text1 = new TextEditingController();
  TextEditingController _text2 = new TextEditingController();
  TextEditingController _text3 = new TextEditingController();
  TextEditingController _text4 = new TextEditingController();
  TextEditingController _text5 = new TextEditingController();
  TextEditingController _text6 = new TextEditingController();
  TextEditingController _text7 = new TextEditingController();
  String? Q1;
  String? Q2;
  String? Q3;
  String? Q4;
  String? Q5;
  String? Q6;
  String? Q7;
  bool Q1Error = false;
  bool Q2Error = false;
  bool Q3Error = false;
  bool Q4Error = false;
  bool Q5Error = false;
  bool _text1Error = false;
  bool _text2Error = false;
  bool _text3Error = false;
  bool _text4Error = false;
  bool _text6Error = false;
  @override
  void initState() {
    super.initState();
    // getdata(9191);

    print("Init Runnng");
    if (GlobalIndividual.individualdraftprogress["GenralInformation"] == true) {
      print("ftechinggg----------");
      getdata(GlobalIndividual.individualclientid);
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GenralInformation/genralInformation/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // await Future.delayed(Duration(seconds: 2));

      setState(() {
        Q1 = data["genralInfo1"];
        Q2 = data["genralInfo3"];
        Q3 = data["genralInfo5"];
        Q4 = data["genralInfo7"];
        Q5 = data["genralInfo9"];

        // currentCityValue2 = data["city"];
        // currentStateValue2 = data["state"];
      });
      _text1.text = data["genralInfo2"];
      _text2.text = data["genralInfo4"];
      _text3.text = data["genralInfo6"];
      _text4.text = data["genralInfo8"];
      _text5.text = data["genralInfo10"];
      _text6.text = data["genralInfo11"];
      _text7.text = data["genralInfo12"];

      // _branchName.text = data["branchName"];
      // _accountNum.text = data["mainAccountNumber"];
      // _accountName.text = data["accountHolderName"];
      // _codeNum.text = data["codeNumber"];
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
        '${GlobalPermission.urlLink}/api/GenralInformation/GenralInformation/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalIndividual.individualclientid,
        "genralInfo1": Q1,
        "genralInfo2": _text1.text,
        "genralInfo3": Q2,
        "genralInfo4": _text2.text,
        "genralInfo5": Q3,
        "genralInfo6": _text3.text,
        "genralInfo7": Q4,
        "genralInfo8": _text4.text,
        "genralInfo9": Q5,
        "genralInfo10": _text5.text,
        "genralInfo11": _text6.text,
        "genralInfo12": _text7.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        GlobalIndividual.getdraftprogressindividual(
            GlobalIndividual.individualclientid);
        tabController?.animateTo(8);
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
        '${GlobalPermission.urlLink}/api/GenralInformation/GenralInformation/${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "genralInfo1": Q1,
        "genralInfo2": _text1.text,
        "genralInfo3": Q2,
        "genralInfo4": _text2.text,
        "genralInfo5": Q3,
        "genralInfo6": _text3.text,
        "genralInfo7": Q4,
        "genralInfo8": _text4.text,
        "genralInfo9": Q5,
        "genralInfo10": _text5.text,
        "genralInfo11": _text6.text,
        "genralInfo12": _text7.text
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController?.animateTo(8);
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
    return Container(
      // height: 400,
      color: Colors.white,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                width: 500,
                                child: Text(
                                  "Is the Client a Board of Director or an Audit Committee member or a Senior Executive in a Listed Company? *",
                                  style: TextController.BodyTextCC,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        // flex: 1,
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).Yes,
                                            style: TextController.BodyText,
                                          ),
                                          value: "Yes",
                                          tileColor: Colors.white,
                                          groupValue: Q1,
                                          onChanged: (value) {
                                            setState(() {
                                              Q1Error = false;
                                              Q1 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        // flex: 1,
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).No,
                                            style: TextController.BodyText,
                                          ),
                                          value: "No",
                                          tileColor: Colors.white,
                                          groupValue: Q1,
                                          onChanged: (value) {
                                            setState(() {
                                              Q1Error = false;
                                              Q1 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (Q1Error)
                                    Text(
                                      "Select option",
                                      style: TextController.errorText,
                                    )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 270,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      validator: (value) {
                                        if (value!.isEmpty && Q1 == "Yes") {
                                          setState(() {
                                            _text1Error = true;
                                          });
                                          return '';
                                        } else {
                                          setState(() {
                                            _text1Error = false;
                                          });
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      controller: _text1,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: S.of(context).TypeHere,
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none,
                                        errorStyle: TextStyle(height: 0.0),
                                      ),
                                    ),
                                  ),
                                  if (_text1Error)
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
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                  width: 500,
                                  child: Text(
                                    "Does the client have, a close association with a Board of Director or an Audit Committee member or a Senior Executive in a Listed Company? *",
                                    style: TextController.BodyTextCC,
                                    maxLines: 2,
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        // flex: 1,
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).Yes,
                                            style: TextController.BodyText,
                                          ),
                                          value: "Yes",
                                          tileColor: Colors.white,
                                          groupValue: Q2,
                                          onChanged: (value) {
                                            setState(() {
                                              Q2Error = false;
                                              Q2 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        // flex: 1,
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).No,
                                            style: TextController.BodyText,
                                          ),
                                          value: "No",
                                          tileColor: Colors.white,
                                          groupValue: Q2,
                                          onChanged: (value) {
                                            setState(() {
                                              Q2Error = false;
                                              Q2 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (Q2Error)
                                    Text(
                                      "Select option",
                                      style: TextController.errorText,
                                    )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 270,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      validator: (value) {
                                        if (value!.isEmpty && Q2 == "Yes") {
                                          setState(() {
                                            _text2Error = true;
                                          });
                                          return '';
                                        } else {
                                          setState(() {
                                            _text2Error = false;
                                          });
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      controller: _text2,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: S.of(context).TypeHere,
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none,
                                        errorStyle: TextStyle(height: 0.0),
                                      ),
                                    ),
                                  ),
                                  if (_text2Error)
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
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                  width: 500,
                                  child: Text(
                                    "Is the client entrusted with prominent public function in the Kingdom or a foreign country, senior management position, or a position in an international organization? *",
                                    style: TextController.BodyTextCC,
                                    maxLines: 2,
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).Yes,
                                            style: TextController.BodyText,
                                          ),
                                          value: "Yes",
                                          tileColor: Colors.white,
                                          groupValue: Q3,
                                          onChanged: (value) {
                                            setState(() {
                                              Q3Error = false;
                                              Q3 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).No,
                                            style: TextController.BodyText,
                                          ),
                                          value: "No",
                                          tileColor: Colors.white,
                                          groupValue: Q3,
                                          onChanged: (value) {
                                            setState(() {
                                              Q3Error = false;
                                              Q3 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (Q3Error)
                                    Text(
                                      "Select option",
                                      style: TextController.errorText,
                                    )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 270,
                                    height: 35,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      validator: (value) {
                                        if (value!.isEmpty && Q3 == "Yes") {
                                          setState(() {
                                            _text3Error = true;
                                          });
                                          return '';
                                        } else {
                                          setState(() {
                                            _text3Error = false;
                                          });
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      style: TextController.BodyText,
                                      controller: _text3,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          errorStyle: TextStyle(height: 0.0),
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  if (_text3Error)
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
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                  width: 500,
                                  child: Text(
                                    "Does the client have a relationship (by blood or marriage up to the second degree) , or have anassociation with a person entrusted with the prominent public function in the kingdom or a foreign country, senior management position, or a position in an international organization? *",
                                    style: TextController.BodyTextCC,
                                    maxLines: 4,
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).Yes,
                                            style: TextController.BodyText,
                                          ),
                                          value: "Yes",
                                          tileColor: Colors.white,
                                          groupValue: Q4,
                                          onChanged: (value) {
                                            setState(() {
                                              Q4Error = false;
                                              Q4 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).No,
                                            style: TextController.BodyText,
                                          ),
                                          value: "No",
                                          tileColor: Colors.white,
                                          groupValue: Q4,
                                          onChanged: (value) {
                                            setState(() {
                                              Q4Error = false;
                                              Q4 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (Q4Error)
                                    Text(
                                      "Select option",
                                      style: TextController.errorText,
                                    )
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 270,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      validator: (value) {
                                        if (value!.isEmpty && Q4 == "Yes") {
                                          setState(() {
                                            _text4Error = true;
                                          });
                                          return '';
                                        } else {
                                          setState(() {
                                            _text4Error = false;
                                          });
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      style: TextController.BodyText,
                                      controller: _text4,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          errorStyle: TextStyle(height: 0.0),
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  if (_text4Error)
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
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                  width: 500,
                                  child: Text(
                                    "Is the client the beneficial owner of the account or business relationship? *",
                                    style: TextController.BodyTextCC,
                                    maxLines: 2,
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).Yes,
                                            style: TextController.BodyText,
                                          ),
                                          value: "Yes",
                                          tileColor: Colors.white,
                                          groupValue: Q5,
                                          onChanged: (value) {
                                            setState(() {
                                              Q5Error = false;
                                              Q5 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                      Flexible(
                                        child: RadioListTile(
                                          title: Text(
                                            S.of(context).No,
                                            style: TextController.BodyText,
                                          ),
                                          value: "No",
                                          tileColor: Colors.white,
                                          groupValue: Q5,
                                          onChanged: (value) {
                                            setState(() {
                                              Q5Error = false;
                                              Q5 = value.toString();
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (Q5Error)
                                    Text(
                                      "Select option",
                                      style: TextController.errorText,
                                    )
                                ],
                              ),
                            ),
                            // Flexible(
                            //   flex: 1,
                            //   child: Container(
                            //     padding: EdgeInsets.symmetric(horizontal: 10),
                            //     width: 270,
                            //     height: 35,
                            //     alignment: Alignment.centerLeft,
                            //     decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         border: Border.all(
                            //             color: ColorSelect.textField)),
                            //     child: TextFormField(
                            //       textAlignVertical: TextAlignVertical.center,
                            //       // validator: (value) {
                            //       //   if (value!.isEmpty && Q5 == "No") {
                            //       //     return 'This field is required.';
                            //       //   }
                            //       //   return null; // Return null if the input is valid
                            //       // },
                            //       style: TextController.BodyText,
                            //       controller: _text5,
                            //       decoration: InputDecoration(
                            //           isDense: true,
                            //           errorStyle: TextStyle(height: 0.0),
                            //           hintText: S.of(context).TypeHere,
                            //           hintStyle: TextController.labelText,
                            //           border: InputBorder.none),
                            //     ),
                            //   ),
                            // ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: 270,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (Q5 == "No")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: SizedBox(
                                    width: 500,
                                    child: Text(
                                      S.of(context).GeneralInfoQ6 + " *",
                                      style: TextController.BodyTextCC,
                                      maxLines: 2,
                                    )),
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 270,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        validator: (value) {
                                          if (value!.isEmpty && Q5 == "No") {
                                            setState(() {
                                              _text6Error = true;
                                            });
                                            return '';
                                          } else {
                                            setState(() {
                                              _text6Error = false;
                                            });
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        controller: _text6,
                                        style: TextController.BodyText,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(height: 0.0),
                                        ),
                                      ),
                                    ),
                                    if (_text6Error)
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
                            ],
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 500,
                                child: Text(
                                  S.of(context).GeneralInfoQ7,
                                  style: TextController.BodyTextCC,
                                  maxLines: 2,
                                )),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 270,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'This field is required.';
                                  //   }
                                  //   return null; // Return null if the input is valid
                                  // },
                                  style: TextController.BodyText,
                                  controller: _text7,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: S.of(context).TypeHere,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none,
                                    errorStyle: TextController.inputErrorText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Container(
                                height: 35,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.tabBorderColor)),
                                child: TextButton(
                                  onPressed: () {
                                    tabController?.animateTo(6);
                                  }, // Switch tabs
                                  child: Text(
                                    S.of(context).Back,
                                    style: TextController.SideMenuText,
                                  ),
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
                                    if (_formKey.currentState != null) {
                                      setState(() {
                                        Q1Error = Q1 == null;
                                        Q2Error = Q2 == null;
                                        Q3Error = Q3 == null;
                                        Q4Error = Q4 == null;
                                        Q5Error = Q5 == null;
                                      });

                                      if (_formKey.currentState!.validate() &&
                                          !Q1Error &&
                                          !Q2Error &&
                                          !Q3Error &&
                                          !Q4Error &&
                                          !Q5Error) {
                                        _formKey.currentState?.save();
                                        if (GlobalIndividual
                                                    .individualdraftprogress[
                                                "GenralInformation"] ==
                                            true) {
                                          putdata(GlobalIndividual
                                              .individualclientid);
                                        } else {
                                          if (GlobalIndividual
                                                  .individualclientid !=
                                              0) {
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
                                    // if (Q1 != null) {
                                    //   if (Q2 != null) {
                                    //     if (Q3 != null) {
                                    //       if (Q4 != null) {
                                    //         if (Q5 != null) {
                                    //           if ((_formKey.currentState!
                                    //               .validate())) {
                                    //             _formKey.currentState?.save();
                                    //             General();
                                    //           }
                                    //         } else {
                                    //           setState(() {
                                    //             Q5Error = true;
                                    //           });
                                    //         }
                                    //       } else {
                                    //         setState(() {
                                    //           Q4Error = true;
                                    //         });
                                    //       }
                                    //     } else {
                                    //       setState(() {
                                    //         Q3Error = true;
                                    //       });
                                    //     }
                                    //   } else {
                                    //     setState(() {
                                    //       Q2Error = true;
                                    //     });
                                    //   }
                                    // } else {
                                    //   setState(() {
                                    //     Q1Error = true;
                                    //   });
                                    // }
                                  },
                                  // Switch tabs
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
              )),
        ),
      ),
    );
  }
}
