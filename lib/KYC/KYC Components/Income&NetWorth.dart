import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';

import '../../RiskAssessmentFormInvidual.dart';

class IncomeNetWorth extends StatefulWidget {
  IncomeNetWorth({@required controller}) {
    tabController = controller;
  }

  @override
  State<IncomeNetWorth> createState() => _IncomeNetWorthState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

class _IncomeNetWorthState extends State<IncomeNetWorth> {
  String btn = "Next";
  // IncomeNetWorth({@required controller}) {
  //   tabController = controller;
  // }
  final _formKey = GlobalKey<FormState>();

  bool sourceOfincomeError = false;
  bool networthError = false;
  bool annualIncomeError = false;
  bool _specifyError = false;

  String? sourceOfincome;
  String? networth;
  String? annualIncome;

  TextEditingController _specify = new TextEditingController();

  @override
  void initState() {
    super.initState();
    // getdata(9151);

    print("Init Runnng");
    if (GlobalIndividual.individualdraftprogress["IncomeNetWorth"] == true) {
      print("ftechinggg----------");
      getdata(GlobalIndividual.individualclientid);
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/IncomeNetWorthController1/IncomeNetWorth/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      setState(() {
        sourceOfincome = data["sourceOfIncome"];
        networth = data["approximateNetWorth"];
        annualIncome = data["approximateAnnualIncome"];
      });
      _specify.text = data['sourceOfIncomeSpecify'];
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
        '${GlobalPermission.urlLink}/api/IncomeNetWorthController1/IncomeNetWorth/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalIndividual.individualclientid,
        "SourceOfIncome": sourceOfincome,
        "ApproximateNetWorth": networth,
        "ApproximateAnnualIncome": annualIncome,
        "sourceOfIncomeSpecify": _specify.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      // print(body);
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        print("Incomeeeeeeeeeee");
        GlobalIndividual.getdraftprogressindividual(
            GlobalIndividual.individualclientid);
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
  void dispose() {
    _specify.dispose();
    super.dispose();
  }

  void putdata(int clientId) async {
    setState(() {
      btn = "Loading...";
    });
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/IncomeNetWorthController1/IncomeNetWorth?ClientId=${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "SourceOfIncome": sourceOfincome,
        "ApproximateNetWorth": networth,
        "ApproximateAnnualIncome": annualIncome,
        "sourceOfIncomeSpecify": _specify.text
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));
      print(body);
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
      'Less Than 100,000',
      '100,001 - 300,000',
      '300,001 - 600,000',
      '600,001 - 1500,000',
      '1500,001 - 5000,000',
      '5000,001 - 10,000,000',
      '10,000,001 - 50,000,000',
      'More Than 50,000,000'
    ];

    var incomesource = [
      'Salary',
      'Personal Business',
      'Pension',
      'Investment',
      'Inheritance',
      'Real Estate',
      'Marketable Securities',
      'Other'
    ];

    return Container(
      // height: 400,
      padding: EdgeInsets.all(1),
      color: Colors.white,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context).SourceOfIncome + " *",
                            style: TextController.BodyText,
                          ),
                          SizedBox(
                            width: 250,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: ColorSelect.textField)),
                                  child: DropdownButton(
                                    hint: Text("Select Here",
                                        style: TextController.labelText),
                                    value: sourceOfincome,
                                    isExpanded: true,
                                    underline: Container(),
                                    iconEnabledColor:
                                        ColorSelect.east_dark_blue,
                                    items: incomesource.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items,
                                            style: TextController.BodyText),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        sourceOfincomeError = false;
                                        sourceOfincome = newValue;
                                      });
                                    },
                                  ),
                                ),
                                if (sourceOfincomeError)
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
                          SizedBox(
                            width: 20,
                          ),
                          if (sourceOfincome == "Other")
                            Flexible(
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
                                      style: TextController.BodyHeadingText,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Please Specify",
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none,
                                        errorStyle: TextStyle(height: 0.0),
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
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Text(
                            S.of(context).ApproximateNetWorth + " *",
                            style: TextController.BodyText,
                          ),
                          SizedBox(
                            width: 37,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: ColorSelect.textField)),
                                  child: DropdownButton(
                                    hint: Text(
                                      S.of(context).SelectHere,
                                      style: TextController.labelText,
                                    ),
                                    value: networth,
                                    isExpanded: true,
                                    underline: Container(),
                                    iconEnabledColor:
                                        ColorSelect.east_dark_blue,
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items,
                                            style: TextController.BodyText),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        networthError = false;
                                        networth = newValue!;
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
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            S.of(context).ApproximateAnnualIncome + " *",
                            style: TextController.BodyText,
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: ColorSelect.textField)),
                                  child: DropdownButton(
                                    hint: Text(
                                      S.of(context).SelectHere,
                                      style: TextController.labelText,
                                    ),
                                    value: annualIncome,
                                    isExpanded: true,
                                    underline: Container(),
                                    iconEnabledColor:
                                        ColorSelect.east_dark_blue,
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items,
                                            style: TextController.BodyText),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        annualIncomeError = false;
                                        annualIncome = newValue!;
                                      });
                                    },
                                  ),
                                ),
                                if (annualIncomeError)
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
                          Container(
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
                                  print(GlobalIndividual.individualclientid);
                                  setState(() {
                                    annualIncomeError = annualIncome == null;
                                    networthError = networth == null;
                                    sourceOfincomeError =
                                        sourceOfincome == null;
                                  });

                                  if (_formKey.currentState!.validate() &&
                                      !annualIncomeError &&
                                      !networthError &&
                                      !sourceOfincomeError) {
                                    _formKey.currentState?.save();
                                    if (GlobalIndividual
                                                .individualdraftprogress[
                                            "IncomeNetWorth"] ==
                                        true) {
                                      putdata(
                                          GlobalIndividual.individualclientid);
                                    } else {
                                      if (GlobalIndividual.individualclientid !=
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
                              }, // Switch tabs
                              child: Text(
                                btn,
                                style: TextController.btnText,
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
    );
  }
}
