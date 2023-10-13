import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

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

class _CustodianInfoState extends State<CustodianInfo> {
  // CustodianInfo({@required controller}) {
  //   tabController = controller;
  // }

  final _formKey = GlobalKey<FormState>();
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

    void custodian() async {
      var url = Uri.parse(
          'https://eastbridge.online/apicore/api/CustodianInformationCorporate/CustodianInformationCorporate/');

      try {
        var headers = {
          'Content-Type': 'application/json',
        };

        var body = {
          "clientId": CustodianInfo.id.value,
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
          print(jsonDecode(response.body));
        } else {
          print(response.statusCode);
        }
      } catch (e) {
        print(e.toString());
      }
    }

    @override
    void initState() {
      super.initState();
    }

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
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).Name ,
                              style: TextController.BodyText,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
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
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).CorrespondenceAddress ,
                              style: TextController.BodyText,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).AccountName,
                              style: TextController.BodyText,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
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
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).AccountNumber,
                              style: TextController.BodyText,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                width: 400,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  controller: _accountNumber,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyText,
                                  keyboardType: TextInputType.number,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).BankName,
                              style: TextController.BodyText,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                width: 400,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  controller: _bankName,
                                  style: TextController.BodyText,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: S.of(context).TypeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).BranchName,
                              style: TextController.BodyText,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  controller: _branchName,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyText,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: S.of(context).TypeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
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
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Broker License",
                              style: TextController.BodyText,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                width: 400,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: _broker,
                                  style: TextController.BodyText,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: S.of(context).TypeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Portfolio Number",
                              style: TextController.BodyText,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Container(
                                width: 400,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  controller: _portfolio,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyText,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: S.of(context).TypeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
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
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();

                                custodian();
                                tabController?.animateTo(8);
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
