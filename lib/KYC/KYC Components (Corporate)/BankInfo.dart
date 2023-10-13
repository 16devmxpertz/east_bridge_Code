import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { yes, no }

class BankInfo extends StatefulWidget {
  BankInfo({@required controller}) {
    tabController = controller;
  }

  @override
  State<BankInfo> createState() => _BankInfoState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

class _BankInfoState extends State<BankInfo> {
  String btn = "Next";
  final _formKey = GlobalKey<FormState>();
  TextEditingController _bankName = new TextEditingController();
  TextEditingController _branchName = new TextEditingController();
  TextEditingController _accountNum = new TextEditingController();
  TextEditingController _accountName = new TextEditingController();
  TextEditingController _codeNum = new TextEditingController();
  TextEditingController currentCountryValue2 = new TextEditingController();
  TextEditingController currentStateValue2 = new TextEditingController();
  TextEditingController currentCityValue2 = new TextEditingController();

  String dropdownvalue = "";
  String bankCode = "";
  String _selectedItem = ''; // To store the selected item

  bool isstate = false;
  bool iscity = false;
  // List<String> dropdownlist = [""];
  List<String> dropdownlistcountry = ["Loading..."];
  List<String> dropdownliststate = [""];
  List<String> dropdownlistcity = [""];
  // BankInfo({@required controller}) {

  //   tabController = controller;
  // }.

  // String? currentCountryValue2;
  // String? currentCityValue2;
  // String? currentStateValue2;

  bool showCountryError = false;
  bool showStateError = false;

  bool showCityError = false;

  void bank() async {
    setState(() {
      btn = "Loading...";
    });
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/BankInformationCorporate/BankInformationCorporate');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalPermissionCorporate.corporateclientid,
        "bankName": _bankName.text,
        "branchName": _branchName.text,
        "mainAccountNumber": _accountNum.text,
        "accountHolderName": _accountName.text,
        "country": currentCountryValue2.text,
        "city": currentCityValue2.text,
        "bankCode": bankCode,
        "codeNumber": _codeNum.text,
        "state": currentStateValue2.text
      };
      print(body);

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Bank Info is Working");
        GlobalPermissionCorporate.getdraftprogresscorporate(
            GlobalPermissionCorporate.corporateclientid);
        tabController?.animateTo(6);
        setState(() {
          btn = "Next";
        });
        // print(jsonDecode(response.body));
      } else {
        setState(() {
          btn = "Next";
        });
        print(response.statusCode);
        print(response.body);
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/BankInformationCorporate/BankInformationCorporate/${Id}'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Data is Fetching");
      // Request was successful
      var jsonResponse = json.decode(response.body);
      setState(() {
        _bankName.text = jsonResponse['bankName'];
        _branchName.text = jsonResponse['branchName'];
        _accountNum.text = jsonResponse['mainAccountNumber'];
        _accountName.text = jsonResponse['accountHolderName'];
        currentCountryValue2.text = jsonResponse['country'];
        currentCityValue2.text = jsonResponse['city'];
        _codeNum.text = jsonResponse['codeNumber'].toString();
        currentStateValue2.text = jsonResponse['state'];
        bankCode = jsonResponse['bankCode'] ?? Null;
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void PutData(int Id) async {
    setState(() {
      btn = "Next";
    });
    print("Updating");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/BankInformationCorporate/BankInformationCorporate?ClientId=${Id}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": Id,
        "bankName": _bankName.text,
        "branchName": _branchName.text,
        "mainAccountNumber": _accountNum.text,
        "accountHolderName": _accountName.text,
        "country": currentCountryValue2.text,
        "city": currentCityValue2.text,
        "bankCode": bankCode,
        "codeNumber": _codeNum.text,
        "state": currentStateValue2.text
      };

      // Change the HTTP method to PUT and include any necessary identifiers in the URL
      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Bank Info is Updated"); // Successful update message
        tabController?.animateTo(6);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
        print("Failed to update bank information");
        print(response.statusCode); // Print the status code for debugging
        print(response.body); // Print the response body for debugging
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    if (GlobalPermissionCorporate
            .corporatedraftprogress["BankInformationCorporate"] ==
        true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionCorporate.corporateclientid);
      print(GlobalPermissionCorporate.corporatedraftprogress);
      print("ftechinggg----------");
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

    String? numberValidator(String? value) {
      if (value == null) {
        return "";
      }
      final n = num.tryParse(value);
      if (n == null) {
        return '"$value" is not a valid number';
      }
    }

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
                                                            currentCountryValue2,
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
                                                  currentCountryValue2.text =
                                                      suggestion;
                                                  print(
                                                      "selectetd countryy uis ${currentCountryValue2.text}");
                                                  setState(() {
                                                    currentStateValue2.text =
                                                        "";
                                                    currentCityValue2.text = "";
                                                    isstate = false;
                                                    iscity = false;

                                                    if (currentCountryValue2
                                                            .text ==
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
                                                    currentCountryValue2.text =
                                                        suggestion;
                                                    print("fdgfdgdfg-");
                                                  });

                                                  GlobalPermission.getState(
                                                      currentCountryValue2
                                                          .text);
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
                                                            currentStateValue2,
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
                                                  currentStateValue2.text =
                                                      suggestion;
                                                  currentCityValue2.text = "";
                                                  print(
                                                      "Select ted satted is ${currentStateValue2.text}");
                                                  setState(() {
                                                    if (currentStateValue2
                                                            .text ==
                                                        "") {
                                                      iscity = false;
                                                    } else {
                                                      print("city ture");
                                                      iscity = true;
                                                    }
                                                  });
                                                  setState(() {
                                                    _selectedItem = suggestion;
                                                    currentStateValue2.text =
                                                        suggestion;
                                                  });
                                                  GlobalPermission.getCity(
                                                      currentCountryValue2.text,
                                                      currentStateValue2.text);
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
                                                              currentCityValue2,
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
                                                        currentCityValue2.text =
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
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                              return 'This field is required.';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          controller: _bankName,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).TypeHere,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
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
                                      child: Container(
                                        width: 270,
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          controller: _accountNum,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).ResPhLabel,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            if (!(value.contains(RegExp(
                                              r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$',
                                              caseSensitive: false,
                                              multiLine: false,
                                            )))) {
                                              return 'Enter Valid IBAN';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                        ),
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
                                      child: Container(
                                        width: 270,
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _branchName,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).TypeHere,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
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
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          width: 270,
                                          height: 35,
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
                                            controller: _accountName,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: S.of(context).TypeHere,
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
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
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
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
                                        currentCountryValue2.text == "";

                                    if (currentCountryValue2.text != "" &&
                                        currentStateValue2.text == "") {
                                      showStateError = true;
                                    }
                                    if (currentStateValue2.text != "" &&
                                        currentCityValue2.text == "") {
                                      showCityError = true;
                                    }
                                  });

                                  if (_formKey.currentState!.validate() &&
                                      !(showCountryError) &&
                                      !showStateError &&
                                      !showCityError) {
                                    _formKey.currentState?.save();

                                    if (GlobalPermissionCorporate
                                                .corporatedraftprogress[
                                            "BankInformationCorporate"] ==
                                        true) {
                                      PutData(GlobalPermissionCorporate
                                          .corporateclientid);
                                    } else {
                                      if (GlobalPermissionCorporate
                                              .corporateclientid !=
                                          0) {
                                        bank();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please fill general info first",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                    // bank();
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
