import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ProfessionalExp extends StatefulWidget {
  ProfessionalExp({@required controller}) {
    tabController = controller;
  }

  @override
  State<ProfessionalExp> createState() => _ProfessionalExpState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

class _ProfessionalExpState extends State<ProfessionalExp> {
  String btn = "Next";
  // ProfessionalExp({@required controller}) {
  //   tabController = controller;
  // }
  final _formKey = GlobalKey<FormState>();

  TextEditingController _text = new TextEditingController();
  TextEditingController _text1 = new TextEditingController();

  String? PeQ1;
  String? PeQ2;

  bool PeQ1Error = false;
  bool PeQ2Error = false;
  bool _text1Error = false;
  bool _textError = false;

  void initState() {
    super.initState();
    // getdata(9191);

    print("Init Runnng");
    if (GlobalIndividual.individualdraftprogress["ProfessionalExperience"] ==
        true) {
      print("ftechinggg----------");
      getdata(GlobalIndividual.individualclientid);
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ProfessionalExperience/ProfessionalExperience/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // await Future.delayed(Duration(seconds: 2));

      setState(() {
        PeQ2 = data["professionalExp2"];
        // currentCityValue2 = data["city"];
        // currentStateValue2 = data["state"];

        PeQ1 = data["professionalExp1"] == "No" ? "No" : "Yes";
        _text1.text =
            data["professionalExp1"] == "No" ? "" : data["professionalExp1"];
      });
      _text.text = data["professionalExp3"];

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
        '${GlobalPermission.urlLink}/api/ProfessionalExperience/ProfessionalExperience/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalIndividual.individualclientid,
        "ProfessionalExp1": PeQ1 == "Yes" ? _text1.text : PeQ1,
        "ProfessionalExp2": PeQ2,
        "ProfessionalExp3": _text.text,
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        GlobalIndividual.getdraftprogressindividual(
            GlobalIndividual.individualclientid);
        tabController?.animateTo(7);
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
        '${GlobalPermission.urlLink}/api/ProfessionalExperience/ProfessionalExperience?clientId=${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "ProfessionalExp1": PeQ1 == "Yes" ? _text1.text : PeQ1,
        "ProfessionalExp2": PeQ2,
        "ProfessionalExp3": _text.text,
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController?.animateTo(7);
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
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Scaffold(
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
              child: Container(
                color: Colors.white,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          S.of(context).ProfessionalExpQ1 + " *",
                          style: TextController.BodyText,
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              S.of(context).Yes,
                              style: TextController.BodyText,
                            ),
                            Radio<String>(
                              value: "Yes",
                              groupValue: PeQ1,
                              onChanged: (value) {
                                setState(() {
                                  PeQ1Error = false;
                                  PeQ1 = value!; //<-- change this
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              S.of(context).No,
                              style: TextController.BodyText,
                            ),
                            Radio<String>(
                              value: "No",
                              groupValue: PeQ1,
                              onChanged: (value) {
                                setState(() {
                                  PeQ1Error = false;
                                  PeQ1 = value!; //<-- change this
                                });
                              },
                            ),
                          ],
                        ),
                        if (PeQ1Error)
                          Text(
                            "Select option",
                            style: TextController.errorText,
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (PeQ1 == "Yes")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 300,
                                  height: 35,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: TextFormField(
                                    validator: (value) {
                                      if ((value!.isEmpty) && PeQ1 == "Yes") {
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
                                    textAlignVertical: TextAlignVertical.center,
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
                    SizedBox(
                      width: 180,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          S.of(context).ProfessionalExpQ2 + " *",
                          style: TextController.BodyText,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              S.of(context).Yes,
                              style: TextController.BodyText,
                            ),
                            Radio<String>(
                              value: "Yes",
                              groupValue: PeQ2,
                              onChanged: (value) {
                                setState(() {
                                  PeQ2Error = false;
                                  PeQ2 = value!; //<-- change this
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              S.of(context).No,
                              style: TextController.BodyText,
                            ),
                            Radio<String>(
                              value: "No",
                              groupValue: PeQ2,
                              onChanged: (value) {
                                setState(() {
                                  PeQ2Error = false;
                                  PeQ2 = value!; //<-- change this
                                });
                              },
                            ),
                          ],
                        ),
                        if (PeQ2Error)
                          Text(
                            "Select option",
                            style: TextController.errorText,
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        if (PeQ2 == "Yes")
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 300,
                                      height: 35,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        validator: (value) {
                                          if ((value!.isEmpty) &&
                                              PeQ2 == "Yes") {
                                            setState(() {
                                              _textError = true;
                                            });
                                            return '';
                                          } else {
                                            setState(() {
                                              _textError = false;
                                            });
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        controller: _text,
                                        textAlignVertical:
                                            TextAlignVertical.center,
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
                                    if (_textError)
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
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 35,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: ColorSelect.tabBorderColor)),
                              child: TextButton(
                                onPressed: () {
                                  tabController?.animateTo(5);
                                }, // Switch tabs
                                child: Text(
                                  S.of(context).Back,
                                  style: TextController.SideMenuText,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // padding: const EdgeInsets.only(right: 50),
                          child: Align(
                            alignment: Alignment.centerRight,
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
                                      PeQ1Error = PeQ1 == null;
                                      PeQ2Error = PeQ2 == null;
                                    });

                                    if (_formKey.currentState!.validate() &&
                                        !PeQ1Error &&
                                        !PeQ2Error) {
                                      _formKey.currentState?.save();
                                      if (GlobalIndividual
                                                  .individualdraftprogress[
                                              "ProfessionalExperience"] ==
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
                                  // if (PeQ1 != null) {
                                  //   if ((_formKey.currentState!.validate())) {
                                  //     if (PeQ2 != null) {
                                  //       _formKey.currentState?.save();
                                  //       Professional();
                                  //     } else {
                                  //       setState(() {
                                  //         PeQ2Error = true;
                                  //       });
                                  //     }
                                  //   }
                                  // } else {
                                  //   setState(() {
                                  //     PeQ1Error = true;
                                  //   });
                                  // }
                                }, // Switch tabs
                                child: Text(
                                  btn,
                                  style: TextController.btnText,
                                ),
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
        ),
      ),
    );
  }
}
