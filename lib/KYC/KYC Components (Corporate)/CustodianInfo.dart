import 'dart:convert';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
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
  String btn = "Next";
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
    setState(() {
      btn = "Loading...";
    });
    print("data sendinggg");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/CustodianInformationCorporate/CustodianInformationCorporate');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalPermissionCorporate.corporateclientid,
        "name": _name.text,
        "correspondenceAddress": _address.text,
        "accountNumber": _accountNumber.text,
        "bankName": _bankName.text,
        "branchName": _branchName.text,
        "brokerLicense": _broker.text,
        "portfolioNumber": _portfolio.text,
        "accountHolderName": _accountName.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        GlobalPermissionCorporate.getdraftprogresscorporate(
            GlobalPermissionCorporate.corporateclientid);
        tabController?.animateTo(8);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void PutData(int Id) async {
    setState(() {
      btn = "Loading...";
    });
    // int commercial = int.parse(CommercialRegistraction.text);
    //int percentageOwnership = int.parse(percentage.text);

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": Id,
      "name": _name.text,
      "correspondenceAddress": _address.text,
      "accountName": _accountName.text,
      "accountNumber": _accountNumber.text,
      "bankName": _bankName.text,
      "branchName": _branchName.text,
      "brokerLicense": _broker.text,
      "portfolioNumber": _portfolio.text,
      "accountHolderName": _accountName.text
    };
    final response = await http.put(
        Uri.parse(
            '${GlobalPermission.urlLink}/api/CustodianInformationCorporate/CustodianInformationCorporate?ClientId=${Id}'),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      // Request successful, handle the response

      print("Successfull");
      tabController?.animateTo(8);
      setState(() {
        btn = "Next";
      });
      // Process the responseData
    } else {
      setState(() {
        btn = "Next";
      });
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      // Display or handle the error
    }
  }

  Future<void> fetchData(int id) async {
    var url =
        '${GlobalPermission.urlLink}/api/CustodianInformationCorporate/${id}';
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Request successful, parse the response body

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);

        setState(() {
          _name.text = jsonResponse["name"];
          _address.text = jsonResponse['correspondenceAddress'];
          _accountName.text = jsonResponse['accountHolderName'];
          _accountNumber.text = jsonResponse['accountNumber'];
          _bankName.text = jsonResponse['bankName'];
          _branchName.text = jsonResponse['branchName'];
          _broker.text = jsonResponse['brokerLicense'];
          _portfolio.text = jsonResponse['portfolioNumber'];
        });

        // setState(() {
        //   data = jsonDecode(response.body);
        // });
      } else {
        // Request failed, handle the error
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Request failed, handle the exception
      print('Exception occurred while fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    print(GlobalPermissionCorporate.corporateclientid);
    if (GlobalPermissionCorporate
            .corporatedraftprogress["CustodianInformationCorporate"] ==
        true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionCorporate.corporateclientid);
    }
    print(GlobalPermissionCorporate.corporatedraftprogress);
    // fetchData();
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

  @override
  Widget build(BuildContext context) {
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
                              S.of(context).Name,
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
                              S.of(context).CorrespondenceAddress,
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
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorSelect.east_blue),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState?.save();
                                if (GlobalPermissionCorporate
                                            .corporatedraftprogress[
                                        "CustodianInformationCorporate"] ==
                                    true) {
                                  PutData(GlobalPermissionCorporate
                                      .corporateclientid);
                                } else {
                                  if (GlobalPermissionCorporate
                                          .corporateclientid !=
                                      0) {
                                    custodian();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please fill general info first",
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
