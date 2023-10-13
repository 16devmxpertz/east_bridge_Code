import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/Log%20In/Login.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RowData1 {
  late String dropdownValue;
  late String dropdownValue1;
  late String dropdownValue2;
  late String dropdownValue3;
  late String dropdownValue4;

  RowData1() {
    dropdownValue = " ";
    dropdownValue1 = "No";
    dropdownValue2 = "No";
    dropdownValue3 = "No";
    dropdownValue4 = "No";
  }
}

class Approval extends StatefulWidget {
  Approval({@required controller}) {
    tabController = controller;
  }
  @override
  _DynamicTableState createState() => _DynamicTableState();
  static ValueNotifier<int> id = new ValueNotifier(0);
  static ValueNotifier<String> name = ValueNotifier("");
  static ValueNotifier<String> role = ValueNotifier("");
}

TabController? tabController;

class _DynamicTableState extends State<Approval> {
  List<RowData1> rowDataList = [];

  @override
  void dispose() {
    for (var rowData in rowDataList) {
      rowData.dropdownValue = "";
      rowData.dropdownValue1 = "";
      rowData.dropdownValue2 = "";
      rowData.dropdownValue3 = "";
      rowData.dropdownValue4 = "";
    }
    super.dispose();
  }

  void addRow() {
    setState(() {
      rowDataList.add(RowData1());
    });
  }

  void removeRow(int index) {
    setState(() {
      rowDataList.removeAt(index);
    });
  }

  Map<String, dynamic> form = {};
  List<RowData1> newlist = []; // Assuming you have a list of RowData objects

  void Permissions() async {
    // List<Map<String, dynamic>> feesList = [];
    // List<String> list = [];
    // int level = 0;
    // for (var rowData in rowDataList) {
    //   if (rowData.dropdownValue1 == "No" ||
    //       rowData.dropdownValue2 == "No" ||
    //       rowData.dropdownValue3 == "No" ||
    //       rowData.dropdownValue4 == "No") {
    //     level = level + 1;
    //   }

    //   list.add(rowData.dropdownValue1);
    //   list.add(rowData.dropdownValue2);
    //   list.add(rowData.dropdownValue3);
    //   list.add(rowData.dropdownValue4);
    //   list.add(level.toString());

    //   form[rowData.dropdownValue] = list;
    //   list.clear();

    //   // form = {rowData.dropdownValue: list};

    //   // feesList.add(form);
    // }
    Map<String, List<String>> formMap = {};

    for (var rowData in rowDataList) {
      int level = 0;

      // if (rowData.dropdownValue1 == "No" ||
      //     rowData.dropdownValue2 == "No" ||
      //     rowData.dropdownValue3 == "No" ||
      //     rowData.dropdownValue4 == "No") {
      //   level = level + 1;
      // }
      if (rowData.dropdownValue1 != "No") {
        level++;
      }
      if (rowData.dropdownValue2 != "No") {
        level++;
      }
      if (rowData.dropdownValue3 != "No") {
        level++;
      }
      if (rowData.dropdownValue4 != "No") {
        level++;
      }
      List<String> list = [
        rowData.dropdownValue1,
        rowData.dropdownValue2,
        rowData.dropdownValue3,
        rowData.dropdownValue4,
        level.toString(),
      ];

      if (!formMap.containsKey(rowData.dropdownValue)) {
        formMap[rowData.dropdownValue] = [];
      }

      formMap[rowData.dropdownValue]!.addAll(list);
    }

    print(formMap); // Output the resulting map

    Map<String, dynamic> combinedMap = {};

    // for (var form in feesList) {
    //   String key = form.keys.first; // Get the key from the form map
    //   Map<String, dynamic> permission =
    //       form.values.first; // Get the permission map

    //   combinedMap[key] =
    //       permission; // Add the permission map to the combined map
    // }

    // print(list);

    print(form);

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FormPermissionAssign/UpdateForms');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "dc": formMap,
      };

      print(body);

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Approval Given Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Approval(),
        ));
        print(jsonDecode(response.body));
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print(jsonDecode(response.body));
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  double yOffset = 0;
  double xOffset = 0;
  bool sidBarOpen = false;
  bool _sidebarVisible = false;

  bool get sidebarVisible => _sidebarVisible;

  void toggleSidebar() {
    _sidebarVisible = !_sidebarVisible;
  }

  void setSideBarState() {
    setState(() {
      xOffset = sidBarOpen ? 250 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                color: Colors.white,
                child: Column(
                  children: [
                    // Header(),

                    // HEADER START
                    Column(
                      children: [
                        HeaderTop(),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                          width: double.infinity,
                          height: 40,
                          color: ColorSelect.east_blue,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                child: Container(
                                  height: 40,
                                  child: Center(
                                    child: IconButton(
                                      color: Colors.white,
                                      icon: Icon(Icons.menu),
                                      onPressed: () {
                                        sidBarOpen = !sidBarOpen;
                                        setSideBarState();
                                        toggleSidebar();
                                      },
                                      // onPressed: () {

                                      // _globalKey.currentState?.openDrawer();
                                      // },
                                    ),
                                  ),
                                ),
                              ),

                              // new
                              Container(
                                // width: 100,
                                height: 44,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    //color: ColorSelect.east_blue,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.add_card_rounded,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            S.of(context).New,
                                            style:
                                                TextController.ControllerText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // EDIT
                              Container(
                                // width: 100,
                                height: 44,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    //color: ColorSelect.east_blue,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.edit_calendar_outlined,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            S.of(context).Edit,
                                            style:
                                                TextController.ControllerText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // view
                              Container(
                                // width: 100,
                                height: 44,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    //color: ColorSelect.east_blue,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.content_paste_search,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            S.of(context).View,
                                            style:
                                                TextController.ControllerText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // cancel
                              Container(
                                // width: 100,
                                height: 44,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    //color: ColorSelect.east_blue,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.free_cancellation_outlined,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            S.of(context).Cancel,
                                            style:
                                                TextController.ControllerText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // print
                              Container(
                                // width: 100,
                                height: 44,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    //color: ColorSelect.east_blue,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.print,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            S.of(context).Print,
                                            style:
                                                TextController.ControllerText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // download
                              Container(
                                // width: 100,
                                height: 44,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    //color: ColorSelect.east_blue,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.download,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            S.of(context).Download,
                                            style:
                                                TextController.ControllerText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // saveDraft
                              Container(
                                // width: 100,
                                height: 44,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    //color: ColorSelect.east_blue,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.save_as_outlined,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            S.of(context).SaveDraft,
                                            style:
                                                TextController.ControllerText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // HEADER END

                    Stack(
                      children: [
                        AnimatedContainer(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          transform:
                              Matrix4.translationValues(xOffset, yOffset, 1.0),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                  ),
                                  child: Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        "Approval",
                                        style: TextController.SubHeadingText,
                                      )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Table(
                                        border: TableBorder.all(
                                            color: ColorSelect.tabBorderColor),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        columnWidths: {
                                          0: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1),
                                        },
                                        children: [
                                          TableRow(
                                            decoration: BoxDecoration(
                                                color: ColorSelect.east_grey),
                                            children: [
                                              Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    'Form Name',
                                                    style:
                                                        DashFormTextController
                                                            .SubHeading,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    'Approval Level 1',
                                                    style:
                                                        DashFormTextController
                                                            .SubHeading,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    'Approval Level 2',
                                                    style:
                                                        DashFormTextController
                                                            .SubHeading,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    'Approval Level 3',
                                                    style:
                                                        DashFormTextController
                                                            .SubHeading,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    'Approval Level 4',
                                                    style:
                                                        DashFormTextController
                                                            .SubHeading,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                child: Center(
                                                  child: ElevatedButton(
                                                    onPressed: addRow,
                                                    child: Text('Add Row'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: rowDataList.length,
                                  itemBuilder: (context, index) {
                                    return buildRowWidget(index);
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, bottom: 25),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        height: 35,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect
                                                    .tabBorderColor)),
                                        child: TextButton(
                                          onPressed: () {
                                            tabController!.animateTo(0);
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
                                    padding: const EdgeInsets.only(
                                        right: 50, bottom: 25),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        height: 35,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: ColorSelect.east_blue,
                                            border: Border.all(
                                                color: ColorSelect
                                                    .tabBorderColor)),
                                        child: TextButton(
                                          onPressed: () {
                                            Permissions();
                                            // Navigator.of(context)
                                            //     .push(MaterialPageRoute(
                                            //   builder: (context) => Logins(),
                                            // ));
                                          }, // Switch tabs
                                          child: Text(
                                            S.of(context).Submit,
                                            style: TextController.btnText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (sidebarVisible) SideBar() else Container(),
                      ],
                    ),
                  ],
                ),
              ),
              Navigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRowWidget(int index) {
    var feesType = [
      'Establishment Expenses',
      'Entry Fees',
      'Management Fees',
      'Performance Advisory Fees',
      'Custody Advisory Fees',
      'Advisory Operator Fees',
      'Auditor Advisory Fees',
      'Trading Advisory Fees',
      'Arranging Financing',
      'Other Expenses',
    ];
    var items = [
      'KYC',
      'Fund Creation',
      'Risk Assesment',
      'Fund Agreement',
      'DPM Creation',
      'Clients Investment Account Opening',
      'DPM Agreement',
      'NDPM Creation',
      'NDPM Agreement',
    ];
    var roles = [
      'Compliance',
      'Relationship Manager',
      'Investment Department',
      'Operation Manager',
      'Portfolio Manager',
      'Finance Manager',
      'CEO'
    ];

    return Container(
      //  padding: EdgeInsets.all(25),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Table(
        border: TableBorder.all(color: ColorSelect.tabBorderColor),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          // 0: FixedColumnWidth(150),
          // 1: FixedColumnWidth(150),
          // 2: FixedColumnWidth(150),
          // 3: FixedColumnWidth(150),
          // 4: FixedColumnWidth(150),
          // 5: FixedColumnWidth(150),
          // 6: FixedColumnWidth(150),
          // 7: FixedColumnWidth(150),
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
        },
        children: [
          TableRow(
            children: [
              Container(
                height: 60,
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                      vertical: 05,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorSelect.tabBorderColor, width: 0.5),
                    ),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                    ),
                    height: 44,
                    width: 180,
                    child: DropdownButtonHideUnderline(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(focusColor: Colors.white),
                        child: DropdownButtonFormField(
                          hint: Center(
                            child: Text(
                              S.of(context).SelectHere,
                              style: TextController.labelText,
                            ),
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
                              child: Center(
                                  child: Text(items,
                                      style: TextController.BodyText)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              rowDataList[index].dropdownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                      vertical: 05,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorSelect.tabBorderColor, width: 0.5),
                    ),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                    ),
                    height: 44,
                    width: 180,
                    child: DropdownButtonHideUnderline(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(focusColor: Colors.white),
                        child: DropdownButtonFormField(
                          hint: Center(
                            child: Text(
                              S.of(context).SelectHere,
                              style: TextController.labelText,
                            ),
                          ),
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            hoverColor: Colors.white,
                          ),
                          items: GlobalPermission.userRole.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Center(
                                  child: Text(items,
                                      style: TextController.BodyText)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              rowDataList[index].dropdownValue1 = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                      vertical: 05,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorSelect.tabBorderColor, width: 0.5),
                    ),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                    ),
                    height: 44,
                    width: 180,
                    child: DropdownButtonHideUnderline(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(focusColor: Colors.white),
                        child: DropdownButtonFormField(
                          hint: Center(
                            child: Text(
                              S.of(context).SelectHere,
                              style: TextController.labelText,
                            ),
                          ),
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            hoverColor: Colors.white,
                          ),
                          items: GlobalPermission.userRole.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Center(
                                  child: Text(items,
                                      style: TextController.BodyText)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              rowDataList[index].dropdownValue2 = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                      vertical: 05,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorSelect.tabBorderColor, width: 0.5),
                    ),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                    ),
                    height: 44,
                    width: 180,
                    child: DropdownButtonHideUnderline(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(focusColor: Colors.white),
                        child: DropdownButtonFormField(
                          hint: Center(
                            child: Text(
                              S.of(context).SelectHere,
                              style: TextController.labelText,
                            ),
                          ),
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            hoverColor: Colors.white,
                          ),
                          items: GlobalPermission.userRole.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Center(
                                  child: Text(items,
                                      style: TextController.BodyText)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              rowDataList[index].dropdownValue3 = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                      vertical: 05,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorSelect.tabBorderColor, width: 0.5),
                    ),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                    ),
                    height: 44,
                    width: 180,
                    child: DropdownButtonHideUnderline(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(focusColor: Colors.white),
                        child: DropdownButtonFormField(
                          hint: Center(
                            child: Text(
                              S.of(context).SelectHere,
                              style: TextController.labelText,
                            ),
                          ),
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            hoverColor: Colors.white,
                          ),
                          items: GlobalPermission.userRole.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Center(
                                  child: Text(items,
                                      style: TextController.BodyText)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              rowDataList[index].dropdownValue4 = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeRow(index),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
