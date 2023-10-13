import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { yes, no }

class BankInfoInv extends StatefulWidget {
  BankInfoInv({@required controller}) {
    tabController = controller;
  }

  @override
  State<BankInfoInv> createState() => _BankInfoInvState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

class _BankInfoInvState extends State<BankInfoInv> {
  String btn = "Next";
  final _formKey = GlobalKey<FormState>();
  // BankInfo({@required controller}) {
  //   tabController = controller;
  // }.

  bool _bankNameError = false;
  bool _accountNumError = false;
  bool _branchNameError = false;
  bool _accountNameError = false;

  TextEditingController _bankName = new TextEditingController();
  TextEditingController _branchName = new TextEditingController();
  TextEditingController _accountNum = new TextEditingController();
  TextEditingController _accountName = new TextEditingController();

  TextEditingController _codeNum = new TextEditingController();
  TextEditingController countryValuenew = new TextEditingController();
  TextEditingController cityValuenew = new TextEditingController();
  TextEditingController stateValuenew = new TextEditingController();
  // String dropdownvalue = "";
  String bankCode = "";
  String? countryValue;
  String? stateValue;
  String? cityValue;
  String? currentCountryValue2;
  String? currentCityValue2;
  String? currentStateValue2;

  bool showCountryError = false;
  bool showStateError = false;

  bool showCityError = false;
  String _selectedItem = '';
  List<String> dropdownlist = [""];
  List<String> dropdownlistcountry = ["Loading..."];
  List<String> dropdownliststate = [""];
  List<String> dropdownlistcity = [""];
  bool isstate = false;
  bool iscity = false;
  bool isstate2 = false;
  bool iscity2 = false;

  @override
  void initState() {
    super.initState();
    // getdata(9177);

    print("Init Runnng");
    if (GlobalIndividual.individualdraftprogress["BankInformation"] == true) {
      print("ftechinggg----------");
      getdata(GlobalIndividual.individualclientid);
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/BankInformation2/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // await Future.delayed(Duration(seconds: 2));

      _bankName.text = data["bankName"];
      _branchName.text = data["branchName"];
      _accountNum.text = data["mainAccountNumber"];
      _accountName.text = data["accountHolderName"];
      _codeNum.text = data["codeNumber"];
      countryValuenew.text = data["country"];
      cityValuenew.text = data["city"];
      stateValuenew.text = data["state"];
      setState(() {
        bankCode = data["bankCode"] ?? Null;
      });
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
        '${GlobalPermission.urlLink}/api/BankInformation2/BankInformation/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalIndividual.individualclientid,
        "bankName": _bankName.text,
        "branchName": _branchName.text,
        "mainAccountNumber": _accountNum.text,
        "accountHolderName": _accountName.text,
        "country": countryValuenew.text,
        "city": cityValuenew.text,
        "bankCode": bankCode,
        "codeNumber": _codeNum.text,
        "state": stateValuenew.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      print(body);

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        GlobalIndividual.getdraftprogressindividual(
            GlobalIndividual.individualclientid);
        tabController?.animateTo(6);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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
        '${GlobalPermission.urlLink}/api/BankInformation2/BankInformation?ClientId=${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "bankName": _bankName.text,
        "branchName": _branchName.text,
        "mainAccountNumber": _accountNum.text,
        "accountHolderName": _accountName.text,
        "country": countryValuenew.text,
        "city": cityValuenew.text,
        "bankCode": bankCode,
        "codeNumber": _codeNum.text,
        "state": stateValuenew.text
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController?.animateTo(6);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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
      'IFSC Code',
      'SWIFT Code',
      'Other',
    ];

    return Material(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).Country + "*",
                                    style: TextController.BodyText,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    S.of(context).State + "*",
                                    style: TextController.BodyText,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    S.of(context).City + "*",
                                    style: TextController.BodyText,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: 270,
                                child: FormField<String>(
                                  builder: (FormFieldState<String> field) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TypeAheadField(
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                        onTap: () {},
                                                        controller:
                                                            countryValuenew,
                                                        style: TextController
                                                            .BodyText,
                                                        decoration:
                                                            InputDecoration(
                                                                isDense: true,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                hintStyle:
                                                                    TextController
                                                                        .labelText,
                                                                hintText: S
                                                                    .of(context)
                                                                    .Country)),
                                                suggestionsCallback: (pattern) {
                                                  print("error");
                                                  return GlobalPermission
                                                      .countries
                                                      .where((item) => item
                                                          .toLowerCase()
                                                          .contains(pattern
                                                              .toLowerCase()))
                                                      .toList();
                                                },
                                                itemBuilder:
                                                    (context, suggestion) {
                                                  return ListTile(
                                                    title: Text(
                                                      suggestion,
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  );
                                                },
                                                onSuggestionSelected:
                                                    (suggestion) {
                                                  // Update the selected item when a suggestion is selected.
                                                  countryValuenew.text =
                                                      suggestion;
                                                  print(
                                                      "selectetd countryy uis ${countryValuenew.text}");
                                                  setState(() {
                                                    stateValuenew.text = "";
                                                    cityValuenew.text = "";
                                                    isstate = false;
                                                    iscity = false;

                                                    if (countryValuenew.text ==
                                                        "") {
                                                      print("state false");
                                                      isstate = false;
                                                    } else {
                                                      print("state ture");
                                                      isstate = true;
                                                    }
                                                  });
                                                  setState(() {
                                                    _selectedItem = suggestion;
                                                    countryValuenew.text =
                                                        suggestion;
                                                    print("fdgfdgdfg-");
                                                  });

                                                  GlobalPermission.getState(
                                                      countryValuenew.text);
                                                },
                                              ),
                                            ),
                                            if (showCountryError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'Select Country',
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TypeAheadField(
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                        enabled: isstate,
                                                        onTap: () {},
                                                        controller:
                                                            stateValuenew,
                                                        style: TextController
                                                            .BodyText,
                                                        decoration:
                                                            InputDecoration(
                                                                isDense: true,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                hintStyle:
                                                                    TextController
                                                                        .labelText,
                                                                hintText: S
                                                                    .of(context)
                                                                    .State)),
                                                suggestionsCallback: (pattern) {
                                                  // Return a filtered list of suggestions based on the search pattern.
                                                  return GlobalPermission.states
                                                      .where((item) => item
                                                          .toLowerCase()
                                                          .contains(pattern
                                                              .toLowerCase()))
                                                      .toList();
                                                },
                                                itemBuilder:
                                                    (context, suggestion) {
                                                  return ListTile(
                                                    title: Text(
                                                      suggestion,
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  );
                                                },
                                                onSuggestionSelected:
                                                    (suggestion) {
                                                  // Update the selected item when a suggestion is selected.
                                                  stateValuenew.text =
                                                      suggestion;
                                                  cityValuenew.text = "";
                                                  print(
                                                      "Select ted satted is ${stateValuenew.text}");
                                                  setState(() {
                                                    if (stateValuenew.text ==
                                                        "") {
                                                      iscity = false;
                                                    } else {
                                                      print("city ture");
                                                      iscity = true;
                                                    }
                                                  });
                                                  setState(() {
                                                    _selectedItem = suggestion;
                                                    stateValuenew.text =
                                                        suggestion;
                                                  });
                                                  GlobalPermission.getCity(
                                                      countryValuenew.text,
                                                      stateValuenew.text);
                                                },
                                              ),
                                            ),
                                            if (showStateError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'Select State',
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TypeAheadField(
                                                  textFieldConfiguration:
                                                      TextFieldConfiguration(
                                                          enabled: iscity,
                                                          onTap: () {
                                                            // setState(
                                                            //     () async {

                                                            // });
                                                          },
                                                          controller:
                                                              cityValuenew,
                                                          style: TextController
                                                              .BodyText,
                                                          decoration: InputDecoration(
                                                              isDense: true,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                              hintText: S
                                                                  .of(context)
                                                                  .City)),
                                                  suggestionsCallback:
                                                      (pattern) {
                                                    // Return a filtered list of suggestions based on the search pattern.
                                                    return GlobalPermission
                                                        .cities
                                                        .where((item) => item
                                                            .toLowerCase()
                                                            .contains(pattern
                                                                .toLowerCase()))
                                                        .toList();
                                                  },
                                                  itemBuilder:
                                                      (context, suggestion) {
                                                    return ListTile(
                                                      title: Text(
                                                        suggestion,
                                                        style: TextController
                                                            .BodyText,
                                                      ),
                                                    );
                                                  },
                                                  onSuggestionSelected:
                                                      (suggestion) {
                                                    // Update the selected item when a suggestion is selected.
                                                    setState(
                                                      () {
                                                        _selectedItem =
                                                            suggestion;
                                                        cityValuenew.text =
                                                            suggestion;
                                                      },
                                                    );
                                                  }),
                                            ),
                                            if (showCityError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'Select City',
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              ),
                                          ],
                                        ),

                                        // Show state error below state dropdown

                                        // Show city error below city dropdown
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Flexible(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).BankName + " *",
                                      style: TextController.BodyText,
                                    ),
                                    SizedBox(
                                      width: 130,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 270,
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
                                                    _bankNameError = true;
                                                  });
                                                  return '';
                                                } else {
                                                  setState(() {
                                                    _bankNameError = false;
                                                  });
                                                }
                                                return null; // Return null if the input is valid
                                              },
                                              controller: _bankName,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0.0),
                                              ),
                                            ),
                                          ),
                                          if (_bankNameError)
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
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).IBAN + " *",
                                      style: TextController.BodyText,
                                    ),
                                    SizedBox(
                                      width: 20,
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
                                              controller: _accountNum,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).ResPhLabel,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextController.errorText,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    _accountNumError = true;
                                                  });
                                                  return '';
                                                } else if (!(value
                                                    .contains(RegExp(
                                                  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$',
                                                  caseSensitive: false,
                                                  multiLine: false,
                                                )))) {
                                                  setState(() {
                                                    _accountNumError = false;
                                                  });
                                                  return 'Enter Valid IBAN';
                                                } else {
                                                  setState(() {
                                                    _accountNumError = false;
                                                  });
                                                }
                                                return null; // Return null if the input is valid
                                              },
                                            ),
                                          ),
                                          if (_accountNumError)
                                            (RegExp(
                                              r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$',
                                              caseSensitive: false,
                                              multiLine: false,
                                            ).hasMatch(_accountNum.text))
                                                ? Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "Enter Valid IBAN",
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  )
                                                : Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "This field is required",
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        S.of(context).BranchName + " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
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
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: _branchName,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    _branchNameError = true;
                                                  });
                                                  return '';
                                                } else {
                                                  setState(() {
                                                    _branchNameError = false;
                                                  });
                                                }
                                                return null; // Return null if the input is valid
                                              },
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0.0),
                                              ),
                                            ),
                                          ),
                                          if (_branchNameError)
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
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Flexible(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).AccountHolderName + "*",
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              width: 270,
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField),
                                              ),
                                              child: TextFormField(
                                                style: TextController.BodyText,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller: _accountName,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none,
                                                  errorStyle:
                                                      TextStyle(height: 0.0),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      _accountNameError = true;
                                                    });
                                                    return '';
                                                  } else {
                                                    setState(() {
                                                      _accountNameError = false;
                                                    });
                                                  }
                                                  return null; // Return null if the input is valid
                                                },
                                              ),
                                            ),
                                            if (_accountNameError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "This field is required.",
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).BankCode,
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        width: 90,
                                      ),
                                      Flexible(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 270,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: DropdownButton<String>(
                                            hint: Text("Select Here",
                                                style:
                                                    TextController.labelText),
                                            value: bankCode!.isNotEmpty
                                                ? bankCode
                                                : null,
                                            isExpanded: true,
                                            underline: Container(),
                                            iconEnabledColor:
                                                ColorSelect.east_dark_blue,
                                            items: items.map(
                                              (String item) {
                                                return DropdownMenuItem(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (newValue) {
                                              setState(
                                                () {
                                                  if (newValue != null &&
                                                      newValue.isNotEmpty) {
                                                    bankCode = newValue;
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Code Number",
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                      ),
                                      Flexible(
                                        child: Container(
                                          width: 270,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField),
                                          ),
                                          child: TextFormField(
                                            style: TextController.BodyText,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            keyboardType: TextInputType.number,
                                            controller: _codeNum,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ]),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Row(
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
                                tabController?.animateTo(4);
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
                                    showCountryError =
                                        countryValuenew.text == "";

                                    showStateError = stateValuenew.text == "";

                                    showCityError = cityValuenew.text == "";
                                  });

                                  if (_formKey.currentState!.validate() &&
                                      !(showCountryError) &&
                                      !showStateError &&
                                      !showCityError) {
                                    _formKey.currentState?.save();
                                    if (GlobalIndividual
                                                .individualdraftprogress[
                                            "BankInformation"] ==
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
