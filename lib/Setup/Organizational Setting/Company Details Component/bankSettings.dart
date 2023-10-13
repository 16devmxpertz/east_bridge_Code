import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/Setup/Organizational%20Setting/companyDetailsNew.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class BankSettings extends StatefulWidget {
  const BankSettings({super.key});

  @override
  State<BankSettings> createState() => _BankSettingsState();
}

class _BankSettingsState extends State<BankSettings> {
  TextEditingController BankName = new TextEditingController();
  TextEditingController BankNameAr = new TextEditingController();
  TextEditingController BankBranch = new TextEditingController();
  TextEditingController BankBranchAr = new TextEditingController();
  TextEditingController iban = new TextEditingController();
  TextEditingController AccountHolder = new TextEditingController();
  TextEditingController AccountHolderAr = new TextEditingController();

  String OfficePop = "";
  String BranchPop = "";
  String BranchName = "";
  var BranchList = [""];
  String OfficeName = "";
  var OfficeList = [""];

  List<Map<String, dynamic>> branchData = [];
  List<Map<String, dynamic>> officeData = [];
  List<Map<String, dynamic>> bankData = [];

  List li1 = [];
  List li2 = [];

  @override
  void initState() {
    super.initState();
    getBranchList();
  }

  void getBranchList() async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/EastBridgeBranches/getBranches');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("----------done");
        dynamic responseData = jsonDecode(response.body);
        if (responseData is List) {
          setState(() {
            branchData = List<Map<String, dynamic>>.from(responseData);
          });
        }
        li1.clear();
        for (var i in branchData) {
          print(i);
          setState(() {
            li1.add(i["branchnameEnglish"]);
          });
        }
        print("LSITTTTTTTT");
        print(li1);

        print(responseData);
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getOfficeList(int id) async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/EastBridgeBranches/getOffices?branchId=${id}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("----------done");
        dynamic responseData = jsonDecode(response.body);
        if (responseData is List) {
          setState(() {
            officeData = List<Map<String, dynamic>>.from(responseData);
          });
        }
        li2.clear();
        for (var i in officeData) {
          print(i);
          setState(() {
            li2.add(i["officenameEnglish"]);
          });
        }
        print(responseData);
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getBankList(int id, int offid) async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/EastBridgeBranches/getBank?branchId=${id}&officeId=${offid}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("----------done");
        dynamic responseData = jsonDecode(response.body);
        if (responseData is List) {
          setState(() {
            bankData = List<Map<String, dynamic>>.from(responseData);
          });
        }

        print(responseData);
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void postdata() async {
    var url =
        Uri.parse('${GlobalPermission.urlLink}/api/EastBridgeBranches/Addbank');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "bankId": 0,
        "bankNameEnglish": BankName.text,
        "bankNameArabic": BankNameAr.text,
        "branchNameEnglish": BankBranch.text,
        "branchNameArabic": BankBranchAr.text,
        "accountHolderNameEnglish": AccountHolder.text,
        "accountHolderNameArabic": AccountHolderAr.text,
        "mainAccountNumber": iban.text,
        "branchId": li1.indexOf(BranchPop) + 1,
        "officeId": li2.indexOf(OfficePop) + 1,
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      print(body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Department Added Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        BankName.text = "";
        BankNameAr.text = "";
        BankBranch.text = "";
        BankBranchAr.text = "";
        AccountHolder.text = "";
        AccountHolderAr.text = "";
        iban.text = "";

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CompanyDetailsNew(),
          ),
        );
      } else {
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

  void AddNew() {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text(
              "Add Bank Details",
              style: TextController.BodyHeadingText,
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 400,
                  child: Column(
                    children: [
                      Container(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bank Name",
                                    style: TextController.BodyText,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField),
                                    ),
                                    child: TextFormField(
                                      controller: BankName,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bank (Arabic)",
                                      style: TextController.BodyText),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      controller: BankNameAr,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Branch Name",
                                    style: TextController.BodyText,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField),
                                    ),
                                    child: TextFormField(
                                      controller: BankBranch,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Branch Name (Arabic)",
                                    style: TextController.BodyText,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      controller: BankBranchAr,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: S.of(context).TypeHere,
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).IBAN,
                                    style: TextController.BodyText,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField),
                                    ),
                                    child: TextFormField(
                                      controller: iban,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Container(
                                width: 250,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 500,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).AccountHolderName,
                                    style: TextController.BodyText,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField),
                                    ),
                                    child: TextFormField(
                                      controller: AccountHolder,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).AccountHolderName +
                                        "(Arabic)",
                                    style: TextController.BodyText,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 250,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      controller: AccountHolderAr,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).Cancel,
                ),
              ),
              TextButton(
                onPressed: () {
                  postdata();
                },
                child: Text(
                  S.of(context).Save,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: ColorSelect.tabBorderColor,
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Bank Settings",
                    style: TextController.SubHeadingText,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Company Branch Name",
                                style: TextController.BodyHeadingText,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 250,
                              height: 35,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: ColorSelect.textField)),
                              child: DropdownButton(
                                hint: Text("Select here",
                                    style: TextController.labelText),
                                value:
                                    BranchName.isNotEmpty ? BranchName : null,
                                isExpanded: true,
                                underline: Container(),
                                iconEnabledColor: ColorSelect.east_dark_blue,
                                items: li1.map<DropdownMenuItem<String>>(
                                  (dynamic item) {
                                    return DropdownMenuItem(
                                      value: item.toString(),
                                      child: Text(
                                        item.toString(),
                                        style: TextController.BodyText,
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (NewValue) {
                                  setState(
                                    () {
                                      if (NewValue != null &&
                                          NewValue.isNotEmpty) {
                                        BranchName = NewValue;
                                        getOfficeList(
                                            li1.indexOf(NewValue) + 1);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "Office Name",
                                style: TextController.BodyHeadingText,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 250,
                              height: 35,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: ColorSelect.textField)),
                              child: DropdownButton(
                                hint: Text("Select here",
                                    style: TextController.labelText),
                                value:
                                    OfficeName.isNotEmpty ? OfficeName : null,
                                isExpanded: true,
                                underline: Container(),
                                iconEnabledColor: ColorSelect.east_dark_blue,
                                items: li2.map<DropdownMenuItem<String>>(
                                  (dynamic item) {
                                    return DropdownMenuItem(
                                      value: item.toString(),
                                      child: Text(
                                        item.toString(),
                                        style: TextController.BodyText,
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (NewValue) {
                                  setState(
                                    () {
                                      if (NewValue != null &&
                                          NewValue.isNotEmpty) {
                                        OfficeName = NewValue;
                                        getBankList(li1.indexOf(NewValue) + 1,
                                            li2.indexOf(NewValue) + 1);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Text(
                  S.of(context).BankDetails,
                  style: TextController.BodyHeadingText,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),

                // width: 900,
                child: Table(
                  border: TableBorder.all(color: ColorSelect.tabBorderColor),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: ColorSelect.east_grey),
                      children: [
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).Name,
                            style: TextController.BodyHeadingText,
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).Branch,
                            style: TextController.BodyHeadingText,
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).IBAN,
                            style: TextController.BodyHeadingText,
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            S.of(context).AccountHolderName,
                            style: TextController.BodyHeadingText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  // width: 900,
                  // height: 700,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bankData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return table(index, context);
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 50,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 140,
                      decoration: BoxDecoration(
                        color: ColorSelect.east_blue,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ColorSelect.east_blue),
                        ),
                        onPressed: () {
                          AddNew();
                        },
                        child: Text(
                          S.of(context).AddNew,
                          style: TextController.btnText,
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
    );
  }

  Widget table(int index, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // width: 900,

        margin: EdgeInsets.symmetric(horizontal: 20),
        // padding: EdgeInsets.symmetric(horizontal: 20),
        child: Table(
          border: TableBorder.all(color: ColorSelect.tabBorderColor),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    bankData[index]["bankNameEnglish"],
                    overflow: TextOverflow.ellipsis,
                    style: TextController.BodyText,
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    bankData[index]["branchNameEnglish"],
                    overflow: TextOverflow.ellipsis,
                    style: TextController.BodyText,
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    bankData[index]["mainAccountNumber"],
                    overflow: TextOverflow.ellipsis,
                    style: TextController.BodyText,
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    bankData[index]["accountHolderNameEnglish"],
                    overflow: TextOverflow.ellipsis,
                    style: TextController.BodyText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
