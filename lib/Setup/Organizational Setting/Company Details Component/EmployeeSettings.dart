import 'dart:convert';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/Setup/Organizational%20Setting/companyDetailsNew.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';

class EmployessSettingsMain extends StatefulWidget {
  const EmployessSettingsMain({super.key});

  @override
  State<EmployessSettingsMain> createState() => _EmployessSettingsMainState();
}

class _EmployessSettingsMainState extends State<EmployessSettingsMain> {
  TextEditingController addEmployeeName = new TextEditingController();

  String OfficePop = "";
  String BranchPop = "";
  String BranchName = "";

  String OfficeName = "";

  List li1 = [];
  List li2 = [];
  List<Map<String, dynamic>> branchData = [];
  List<Map<String, dynamic>> employeeData = [];

  List<Map<String, dynamic>> officeData = [];
  List<Map<String, dynamic>> deptData = [];

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

  void getEmployeeList() async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/EastBridgeEmployees/getEmployees');

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
            employeeData = List<Map<String, dynamic>>.from(responseData);
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
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/EastBridgeEmployees/AddEmployees');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "branchId": li1.indexOf(BranchName) + 1,
        "officeId": li2.indexOf(OfficeName) + 1,
        "employeeName": addEmployeeName.text
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
            fontSize: 16.0);
        addEmployeeName.text = "";

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CompanyDetailsNew(),
          ),
        );
      } else {
        print(response.body);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getBranchList();
  }

  void AddNew() {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text(
              "Add Employee",
              style: TextController.BodyHeadingText,
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 300,
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
                                  //       Text("Branch Name",
                                  //           style: TextController.BodyText),
                                  //       Container(
                                  //         margin: EdgeInsets.symmetric(vertical: 10),
                                  //         padding:
                                  //             EdgeInsets.symmetric(horizontal: 10),
                                  //         width: 250,
                                  //         height: 35,
                                  //         alignment: Alignment.centerLeft,
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //                 color: ColorSelect.textField)),
                                  //         child: DropdownButton(
                                  //           hint: Text("Select here",
                                  //               style: TextController.labelText),
                                  //           value: BranchPop.isNotEmpty
                                  //               ? BranchPop
                                  //               : null,
                                  //           isExpanded: true,
                                  //           underline: Container(),
                                  //           iconEnabledColor:
                                  //               ColorSelect.east_dark_blue,
                                  //           items: BranchList.map(
                                  //             (String items) {
                                  //               return DropdownMenuItem(
                                  //                 value: items,
                                  //                 child: Text(
                                  //                   items,
                                  //                   style: TextController.BodyText,
                                  //                 ),
                                  //               );
                                  //             },
                                  //           ).toList(),
                                  //           onChanged: (NewValue) {
                                  //             setState(
                                  //               () {
                                  //                 if (NewValue != null &&
                                  //                     NewValue.isNotEmpty) {
                                  //                   BranchPop = NewValue;
                                  //                 }
                                  //               },
                                  //             );
                                  //           },
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   width: 15,
                                  // ),
                                  // Flexible(
                                  //   child: Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text("Office Name",
                                  //           style: TextController.BodyText),
                                  //       Container(
                                  //         margin: EdgeInsets.symmetric(vertical: 10),
                                  //         padding:
                                  //             EdgeInsets.symmetric(horizontal: 10),
                                  //         width: 250,
                                  //         height: 35,
                                  //         alignment: Alignment.centerLeft,
                                  //         decoration: BoxDecoration(
                                  //             color: Colors.white,
                                  //             border: Border.all(
                                  //                 color: ColorSelect.textField)),
                                  //         child: DropdownButton(
                                  //           hint: Text("Select here",
                                  //               style: TextController.labelText),
                                  //           value: OfficePop.isNotEmpty
                                  //               ? OfficePop
                                  //               : null,
                                  //           isExpanded: true,
                                  //           underline: Container(),
                                  //           iconEnabledColor:
                                  //               ColorSelect.east_dark_blue,
                                  //           items: OfficeList.map(
                                  //             (String items) {
                                  //               return DropdownMenuItem(
                                  //                 value: items,
                                  //                 child: Text(
                                  //                   items,
                                  //                   style: TextController.BodyText,
                                  //                 ),
                                  //               );
                                  //             },
                                  //           ).toList(),
                                  //           onChanged: (NewValue) {
                                  //             setState(
                                  //               () {
                                  //                 if (NewValue != null &&
                                  //                     NewValue.isNotEmpty) {
                                  //                   OfficePop = NewValue;
                                  //                 }
                                  //               },
                                  //             );
                                  //           },
                                  //         ),
                                  //       ),
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
                                  Text("Employee Name",
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
                                          color: ColorSelect.textField),
                                    ),
                                    child: TextFormField(
                                      controller: addEmployeeName,
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
                              child: Container(),
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
            border: Border.all(width: 1, color: ColorSelect.tabBorderColor),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Employee Settings",
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
                                "Branch Name",
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
                                        getEmployeeList();
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
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 600,
                child: Table(
                  border: TableBorder.all(color: ColorSelect.tabBorderColor),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: FlexColumnWidth(1),
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
                            "Name",
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
                  width: 600,
                  // height: 700,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: employeeData.length,
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
        width: 600,

        // margin: EdgeInsets.symmetric(horizontal: 20),
        // padding: EdgeInsets.symmetric(horizontal: 20),
        child: Table(
          border: TableBorder.all(color: ColorSelect.tabBorderColor),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: {
            0: FlexColumnWidth(0.5),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    employeeData[index]["employeeName"],
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
