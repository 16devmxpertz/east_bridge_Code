import 'dart:convert';
import 'package:east_bridge/Global.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'GloablIndividual.dart';

enum SingingCharacter { yes, no }

class CustodianInfo extends StatefulWidget {
  CustodianInfo({@required controller}) {
    tabController = controller;
  }

  @override
  State<CustodianInfo> createState() => _CustodianInfoState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;
final _formKey = GlobalKey<FormState>();

class _CustodianInfoState extends State<CustodianInfo> {
  String btn = "Next";
  // CustodianInfo({@required controller}) {
  //   tabController = controller;
  // }
  TextEditingController _name = new TextEditingController();
  TextEditingController _address = new TextEditingController();
  TextEditingController _broker = new TextEditingController();
  TextEditingController _portfolio = new TextEditingController();
  TextEditingController _accountName = new TextEditingController();
  TextEditingController _accountNumber = new TextEditingController();
  TextEditingController _bankName = new TextEditingController();
  TextEditingController _branchName = new TextEditingController();
  String dropdownvalue = "";
  @override
  void initState() {
    super.initState();
    // getdata(9043);

    print("Init Runnng");
    if (GlobalIndividual.individualdraftprogress["CustodianInformation"] ==
        true) {
      print("ftechinggg----------");
      getdata(GlobalIndividual.individualclientid);
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/CustodianInformation/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // await Future.delayed(Duration(seconds: 2));

      _name.text = data["name"];
      _accountName.text = data["accountName"];
      _accountNumber.text = data["accountNumber"];
      _address.text = data["correspondenceAddress"];
      _bankName.text = data["bankName"];
      _branchName.text = data["branchName"];
      _broker.text = data["brokerLicense"];
      _portfolio.text = data["portfolioNumber"];

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
        '${GlobalPermission.urlLink}/api/CustodianInformation/CustodianInformation/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalIndividual.individualclientid,
        "name": _name.text,
        "correspondenceAddress": _address.text,
        "accountName": _accountName.text,
        "accountNumber": _accountNumber.text,
        "bankName": _bankName.text,
        "branchName": _branchName.text,
        "brokerLicense": _broker.text,
        "portfolioNumber": _portfolio.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        GlobalIndividual.getdraftprogressindividual(
            GlobalIndividual.individualclientid);
        tabController?.animateTo(9);
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
        '${GlobalPermission.urlLink}/api/CustodianInformation/CustodianInformation?ClientId=${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "name": _name.text,
        "correspondenceAddress": _address.text,
        "accountName": _accountName.text,
        "accountNumber": _accountNumber.text,
        "bankName": _bankName.text,
        "branchName": _branchName.text,
        "brokerLicense": _broker.text,
        "portfolioNumber": _portfolio.text
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController?.animateTo(9);
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
    SingingCharacter? _character = SingingCharacter.yes;

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
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

    return Container(
      // height: 500,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        S.of(context).Name,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 175,
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value!.isNotEmpty) {
                            //     if (!value!.contains(RegExp(r'^[a-zA-Z]+$'))) {
                            //       return 'Name should only contain letters';
                            //     }
                            //   } else {
                            //     return 'This field is required.';
                            //   }
                            //   return null; // Return null if the input is valid
                            // },
                            controller: _name,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextController.BodyText,
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
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).CorrespondenceAddress,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'This field is required.';
                            //   }
                            //   return null; // Return null if the input is valid
                            // },
                            controller: _address,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextController.BodyText,
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
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).AccountName,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            // validator: (value) {
                            //   if (value!.isNotEmpty) {
                            //     if (!value!.contains(RegExp(r'^[a-zA-Z]+$'))) {
                            //       return 'Name should only contain letters';
                            //     }
                            //   } else {
                            //     return 'This field is required.';
                            //   }
                            //   return null; // Return null if the input is valid
                            // },
                            controller: _accountName,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextController.BodyText,
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
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).AccountNumber,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            controller: _accountNumber,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextController.BodyText,
                            inputFormatters: [AlphaNumericTextInputFormatter()],
                            // validator: (value) {
                            //   if (!(value!.contains(RegExp(
                            //     r'^[A-Z]{2}\d{2}[A-Z0-9]{1,30}$',
                            //     caseSensitive: false,
                            //     multiLine: false,
                            //   )))) {
                            //     return 'Enter Valid IBAN';
                            //   }
                            //   return null; // Return null if the input is valid
                            // },
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: S.of(context).IbanLabel,
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
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).BankName,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 140,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextFormField(
                              controller: _bankName,
                              style: TextController.BodyText,
                              decoration: InputDecoration(
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).BranchName,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextFormField(
                              controller: _branchName,
                              style: TextController.BodyText,
                              decoration: InputDecoration(
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  /* Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).Country,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 160,
                      ),
                      Container(
                        width: 400,
                        height: 44,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorSelect.textField)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(focusColor: Colors.white),
                              child: DropdownButtonFormField(
                                hint: Text(
                                  S.of(context).SelectHere,
                                  style: TextController.labelText,
                                ),
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hoverColor: Colors.white,
                                ),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items,
                                        style: TextController.BodyText),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).City,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 155,
                      ),
                      Container(
                        width: 400,
                        height: 44,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorSelect.textField)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(focusColor: Colors.white),
                              child: DropdownButtonFormField(
                                hint: Text(
                                  S.of(context).SelectHere,
                                  style: TextController.labelText,
                                ),
                                isExpanded: true,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hoverColor: Colors.white,
                                ),
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items,
                                        style: TextController.BodyText),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),*/
                  Row(
                    children: [
                      Text(
                        "Broker License",
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextFormField(
                              controller: _broker,
                              style: TextController.BodyText,
                              decoration: InputDecoration(
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Portfolio Number",
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextFormField(
                              controller: _portfolio,
                              style: TextController.BodyText,
                              decoration: InputDecoration(
                                  hintText: S.of(context).TypeHere,
                                  isDense: true,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none),
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
                              tabController?.animateTo(7);
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
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                if (GlobalIndividual.individualdraftprogress[
                                        "CustodianInformation"] ==
                                    true) {
                                  putdata(GlobalIndividual.individualclientid);
                                } else {
                                  if (GlobalIndividual.individualclientid !=
                                      0) {
                                    senddata();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please fill personal info first",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
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

class AlphaNumericTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // This function is called whenever the text changes in the TextField.
    // You can implement your formatting logic here.

    // Allow only alphabetic characters and numbers.
    final alphaNumericOnly = RegExp(r'^[a-zA-Z0-9]*$');
    if (!alphaNumericOnly.hasMatch(newValue.text)) {
      // If the new value contains characters other than alphabetic and numbers, reject the change.
      return oldValue;
    }

    // Otherwise, allow the change.
    return newValue;
  }
}
