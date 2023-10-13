import 'dart:convert';
import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';

enum SingingCharacter { yes, no }

class FundBankInfo extends StatefulWidget {
  FundBankInfo({@required controller}) {
    tabController = controller;
  }

  @override
  State<FundBankInfo> createState() => _FundBankInfoState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

TabController? tabController;


class _FundBankInfoState extends State<FundBankInfo> {
TextEditingController _bankName = new TextEditingController();
TextEditingController _branchName = new TextEditingController();
TextEditingController _accNum = new TextEditingController();
TextEditingController _accHolder = new TextEditingController();


  void Fundbank() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundBankDetail/FundBankDetail');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "fundId": GlobalPermissionFund.Fundclientid,
        "bankName": _bankName.text,
        "branchName": _branchName.text,
        "mainAccountNumber": _accNum.text,
        "accountHolderName": _accHolder.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        GlobalPermissionFund.getdraftprogressfund(
            GlobalPermissionFund.Fundclientid);
        tabController!.animateTo(4);

        // print(jsonDecode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void PutData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundBankDetail/FundBankDetail?FundId=$Id');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "fundId": GlobalPermissionFund.Fundclientid,
      "bankName": _bankName.text,
      "branchName": _branchName.text,
      "mainAccountNumber": _accNum.text,
      "accountHolderName": _accHolder.text
    };

    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      tabController!.animateTo(4);

      // print(jsonDecode(response.body));
    } else {
      print(response.statusCode);
    }
  }

  Future<void> fetchData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundBankDetail/FundBankDetail/$Id'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Data is Fetching");
      // Request was successful
      var jsonResponse = json.decode(response.body);
      setState(() {
        _bankName.text = jsonResponse['bankName'];
        _branchName.text = jsonResponse['branchName'];
        _accNum.text = jsonResponse['mainAccountNumber'];
        _accHolder.text = jsonResponse['accountHolderName'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  //GET API Link:  /api/FundBankDetail/FundBankDetail/0

  @override
  void initState() {
    super.initState();
    if (GlobalPermissionFund.Funddraftprogress["FundBankDetail"] == true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionFund.Fundclientid);
      print(GlobalPermissionFund.Funddraftprogress);
      print("ftechinggg----------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      child: Scaffold(
        body: Container(
            child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
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
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).BranchName,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 85,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            controller: _branchName,
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
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).IBAN,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _accNum,
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
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Bank account title",
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            controller: _accHolder,
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
                  SizedBox(
                    height: 50,
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
                                tabController!.animateTo(2);
                              }, // Switch tabs
                              child: Text(
                                S.of(context).Back,
                                style: TextController.SideMenuText,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 35,
                            width: 140,
                            decoration: BoxDecoration(
                                color: ColorSelect.east_blue,
                                border: Border.all(
                                    color: ColorSelect.tabBorderColor)),
                            child: TextButton(
                              onPressed: () {
                                if (GlobalPermissionFund
                                        .Funddraftprogress["FundBankDetail"] ==
                                    true) {
                                  PutData(GlobalPermissionFund.Fundclientid);
                                } else {
                                  if (GlobalPermissionFund.Fundclientid != 0) {
                                    Fundbank();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please fill Fund Detail first",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              }, // Switch tabs
                              child: Text(
                                S.of(context).Next,
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
        )),
      ),
    );
  }
}
