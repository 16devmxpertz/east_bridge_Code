import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class BranchSettingsMain extends StatefulWidget {
  const BranchSettingsMain({super.key});

  @override
  State<BranchSettingsMain> createState() => _BranchSettingsMainState();
}

class _BranchSettingsMainState extends State<BranchSettingsMain> {
  List<Map<String, dynamic>> branchData = [];
  List<dynamic> masterList = [];
  List<dynamic> masterListArabic = [];

  List<dynamic> itemList = [];
  TextEditingController newItem = new TextEditingController();
  TextEditingController newItemArabic = new TextEditingController();
  List<dynamic> itemListArabic = [];

  List keys = [];

  List values = [];
  Map valuesMap = {};
  Map dropdownvaluesMap = {};
  List keys2 = [];

  List values2 = [];
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
    print(itemList);
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/EastBridgeBranches/AddBranch');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        // "branchId": 0,
        "branchnameEnglish": newItem.text,
        "branchnameArabic": newItemArabic.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      print(body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Branch Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        newItem.text = "";
        newItemArabic.text = "";

        Navigator.pop(context);
        getBranchList();
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

  void addNewItem() {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text(
              S.of(context).AddNew,
              style: TextController.BodyHeadingText,
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 450,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorSelect.textField),
                        ),
                        child: TextFormField(
                          controller: newItem,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextController.BodyHeadingText,
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: S.of(context).TypeHere + "(in English)",
                              hintStyle: TextController.labelText,
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 450,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorSelect.textField),
                        ),
                        child: TextFormField(
                          controller: newItemArabic,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextController.BodyHeadingText,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[\u0600-\u06FF\s]')),
                          ],
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: S.of(context).TypeHere + "(in Arabic)",
                              hintStyle: TextController.labelText,
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    color: ColorSelect.east_blue,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0xFFC9BBBB),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.of(context).Cancel,
                        style: TextController.btnText,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    color: ColorSelect.east_blue,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0xFFC9BBBB),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        postdata();
                      },
                      child: Text(
                        S.of(context).Save,
                        style: TextController.btnText,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List li1 = [];
  List li2 = [];
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
            border: Border.all(width: 1, color: ColorSelect.tabBorderColor),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Branch Settings",
                    style: TextController.SubHeadingText,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 700,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Table(
                  border: TableBorder.all(color: ColorSelect.tabBorderColor),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(3),
                  },
                  children: [
                    TableRow(
                      children: [
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            "Branch Id",
                            style: TextController.BodyHeadingText,
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            "Branch Name (in English)",
                            style: TextController.BodyHeadingText,
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(
                            "Branch Name (in Arabic)",
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
                  width: 700,

                  // height: 700,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: branchData.length,
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
                          color: Colors.white,
                          border:
                              Border.all(color: ColorSelect.tabBorderColor)),
                      child: TextButton(
                        onPressed: () {
                          addNewItem();
                        }, // Switch tabs
                        child: Text(
                          S.of(context).AddNew,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    // Container(
                    //   height: 35,
                    //   width: 140,
                    //   decoration: BoxDecoration(
                    //     color: ColorSelect.east_blue,
                    //   ),
                    //   child: ElevatedButton(
                    //     style: ButtonStyle(
                    //       backgroundColor:
                    //           MaterialStatePropertyAll(ColorSelect.east_blue),
                    //     ),
                    //     onPressed: () {},
                    //     child: Text(
                    //       S.of(context).Save,
                    //       style: TextController.btnText,
                    //     ),
                    //   ),
                    // ),
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
        width: 700,
        // margin: EdgeInsets.symmetric(horizontal: 20),
        // padding: EdgeInsets.symmetric(horizontal: 20),
        child: Table(
          border: TableBorder.all(color: ColorSelect.tabBorderColor),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
          },
          children: [
            TableRow(
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    branchData[index]["branchId"].toString(),
                    style: TextController.BodyText,
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    branchData[index]["branchnameEnglish"],
                    style: TextController.BodyText,
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    branchData[index]["branchnameArabic"],
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
