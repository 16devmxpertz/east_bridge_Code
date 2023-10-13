import 'dart:convert';

import 'package:csc_picker/csc_picker.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { yes, no }

class BankInfo extends StatefulWidget {
  BankInfo({@required controller}) {
    tabController = controller;
  }

  @override
  State<BankInfo> createState() => BankInfoState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

TextEditingController _bankName = new TextEditingController();
TextEditingController _branchName = new TextEditingController();
TextEditingController _accountNum = new TextEditingController();
TextEditingController _accountName = new TextEditingController();

TextEditingController _codeNum = new TextEditingController();
String dropdownvalue = "";
String? bankCode;

class BankInfoState extends State<BankInfo> {
  final _formKey = GlobalKey<FormState>();

  String? countryValue;
  String? stateValue;
  String? cityValue;
  String? currentCountryValue2;
  String? currentCityValue2;
  String? currentStateValue2;

  bool showCountryError = false;
  bool showStateError = false;

  bool showCityError = false;


  bool bankNameError = false;
  bool accountNumError = false;
  bool branchNameError = false;
  bool accountNameError = false;

  @override
  Widget build(BuildContext context) {
    void bank() async {
      var url = Uri.parse(
          'https://eastbridge.online/apicore/api/BankInformationCorporate/BankInformationCorporate');

      try {
        var headers = {
          'Content-Type': 'application/json',
        };

        var body = {
          "clientId": BankInfo.id.value,
          "bankName": _bankName.text,
          "branchName": _branchName.text,
          "mainAccountNumber": _accountNum.text,
          "accountHolderName": _accountName.text,
          "country": currentCountryValue2,
          "city": currentCityValue2,
          "bankCode": bankCode,
          "codeNumber": _codeNum.text,
          "state": currentStateValue2
        };

        var response =
            await http.post(url, headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print("Bank Info is Working");
          tabController?.animateTo(6);
        } else {
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

    // List of items in our dropdown menu
    var items = [
      'IFSC Code',
      'SWIFT Code',
      'Other',
    ];

    @override
    void initState() {
      super.initState();
    }

    return Material(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Container(
              // height: 400,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // width: 300,
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).Country,
                                    style: TextController.BodyText,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    S.of(context).State,
                                    style: TextController.BodyText,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    S.of(context).City,
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
                                      children: [
                                        CSCPicker(
                                          layout: Layout.vertical,
                                          flagState: CountryFlag.DISABLE,
                                          cityDropdownLabel:
                                              S.of(context).SelectHere,
                                          countryDropdownLabel:
                                              S.of(context).SelectHere,
                                          stateDropdownLabel:
                                              S.of(context).SelectHere,
                                          dropdownItemStyle:
                                              TextController.BodyText,
                                          dropdownHeadingStyle:
                                              TextController.labelText,
                                          selectedItemStyle:
                                              TextController.BodyText,
                                          onCountryChanged: (value) {
                                            setState(() {
                                              currentCountryValue2 = value;
                                              showCountryError = false;
                                            });
                                          },
                                          onStateChanged: (value) {
                                            setState(() {
                                              currentStateValue2 = value;
                                              showStateError = false;
                                            });
                                          },
                                          onCityChanged: (value) {
                                            setState(() {
                                              currentCityValue2 = value;
                                              showCityError = false;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        if (showCountryError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              'Select a country, state & city',
                                              style: TextController.errorText,
                                            ),
                                          ),
                                        // Show state error below state dropdown
                                        if (showStateError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              'Select a state',
                                              style: TextController.errorText,
                                            ),
                                          ),
                                        // Show city error below city dropdown
                                        if (showCityError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              'Select a city',
                                              style: TextController.errorText,
                                            ),
                                          ),
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
                                                    bankNameError = true;
                                                  });
                                                  // return 'This field is required.';
                                                } else {
                                                  setState(() {
                                                    bankNameError = false;
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
                                                errorStyle: TextController
                                                    .inputErrorText,
                                              ),
                                            ),
                                          ),
                                          if (bankNameError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "This field is required.",
                                                style: TextController.errorText,
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
                                                    S.of(context).IbanLabel,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText,
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    accountNumError = true;
                                                  });
                                                  // return 'This field is required.';
                                                } else if (!(value
                                                    .contains(RegExp(
                                                  r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$',
                                                  caseSensitive: false,
                                                  multiLine: false,
                                                )))) {
                                                  setState(() {
                                                    accountNumError = true;
                                                  });
                                                  // return 'Enter Valid IBAN';
                                                } else {
                                                  setState(() {
                                                    accountNumError = false;
                                                  });
                                                }
                                                // return null; // Return null if the input is valid
                                              },
                                            ),
                                          ),
                                          if (accountNumError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child:
                                               Text(
                                                ((!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$')
                                                            .hasMatch(
                                                                _accountNum.text)) &&
                                                        _accountNum.text.isNotEmpty)
                                                    ? "Enter Valid IBAN"
                                                    : "This field is required.",
                                                style: TextController.errorText,
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
                                                    branchNameError = true;
                                                  });
                                                  // return 'This field is required.';
                                                } else {
                                                  setState(() {
                                                    branchNameError = false;
                                                  });
                                                }
                                                // return null; // Return null if the input is valid
                                              },
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText,
                                              ),
                                            ),
                                          ),
                                          if (branchNameError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "This field is required.",
                                                style: TextController.errorText,
                                              ),
                                            ),
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
                            // padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).AccountHolderName,
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
                                                      color: ColorSelect
                                                          .textField)),
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
                                                  errorStyle: TextController
                                                      .inputErrorText,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      accountNameError = true;
                                                    });
                                                    // return 'This field is required.';
                                                  } else{
                                                    setState(() {
                                                      accountNameError = true;
                                                    });

                                                  }
                                                  // return null; // Return null if the input is valid
                                                },
                                              ),
                                            ),
                                            if (accountNameError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "This field is required.",
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              ),
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
                                            value: bankCode,
                                            isExpanded: true,
                                            underline: Container(),
                                            iconEnabledColor:
                                                ColorSelect.east_dark_blue,
                                            items: items.map(
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
                                                  bankCode = NewValue!;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      // Flexible(
                                      //   child: Container(
                                      //     width: 270,
                                      //     height: 35,
                                      //     alignment: Alignment.centerLeft,
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         border: Border.all(
                                      //             color:
                                      //                 ColorSelect.textField)),
                                      //     child: Center(
                                      //       child: Padding(
                                      //         padding: const EdgeInsets.only(
                                      //           left: 15,
                                      //         ),
                                      //         child:
                                      //             DropdownButtonHideUnderline(
                                      //           child: Theme(
                                      //             data: Theme.of(context)
                                      //                 .copyWith(
                                      //                     focusColor:
                                      //                         Colors.white),
                                      //             child:
                                      //                 DropdownButtonFormField(
                                      //               hint: Text(
                                      //                 S.of(context).SelectHere,
                                      //                 style: TextController
                                      //                     .labelText,
                                      //               ),
                                      //               isExpanded: true,
                                      //               icon: const Icon(Icons
                                      //                   .keyboard_arrow_down),
                                      //               decoration: InputDecoration(
                                      //                 enabledBorder:
                                      //                     InputBorder.none,
                                      //                 border: InputBorder.none,
                                      //                 hoverColor: Colors.white,
                                      //               ),
                                      //               items: items
                                      //                   .map((String items) {
                                      //                 return DropdownMenuItem(
                                      //                   value: items,
                                      //                   child: Text(items,
                                      //                       style:
                                      //                           TextController
                                      //                               .BodyText),
                                      //                 );
                                      //               }).toList(),
                                      //               onChanged:
                                      //                   (String? newValue) {
                                      //                 setState(() {
                                      //                   bankCode = newValue!;
                                      //                 });
                                      //               },
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
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
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState != null) {
                                  setState(() {
                                    showCountryError =
                                        currentCountryValue2 == null;

                                    if (currentCountryValue2 != null &&
                                        currentStateValue2 == null) {
                                      showStateError = true;
                                    }
                                    if (currentStateValue2 != null &&
                                        currentCityValue2 == null) {
                                      showCityError = true;
                                    }
                                  });

                                  if (_formKey.currentState!.validate() &&
                                      !showCountryError &&
                                      !showStateError &&
                                      !showCityError) {
                                    _formKey.currentState?.save();
                                    tabController?.animateTo(6);

                                    bank();
                                  }
                                } else {
                                  // Handle case where _formKey.currentState is null
                                }
                              }, // Switch tabs
                              child: Text(
                                S.of(context).Next,
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
