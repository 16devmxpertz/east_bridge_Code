import 'dart:convert';

import 'package:east_bridge/ANBAccountCustomerSearch.dart';
import 'package:east_bridge/Fund%20Creation/TabOfFundCreation.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/KYC/KYC%20Components/IndividualDraftList.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'FundGlobal.dart';

class fundList extends StatefulWidget {
  const fundList({super.key});

  @override
  State<fundList> createState() => _fundListState();
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<String> name = ValueNotifier("");
}

final _formKey = GlobalKey<FormState>();

class _fundListState extends State<fundList> {
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

  List li = [];
  List key = [];
  List perUnitValue = [];
  List noOfShares = [];

  var customers;

  void getclientlist() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GetFundsByClientID/GetAllFunds');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        customers = jsonDecode(response.body);
        for (var i in customers) {
          setState(() {
            li.add(i['fundName']);
            key.add(i['fundId']);
            perUnitValue.add(i['perUnitValue']);
            noOfShares.add(i['noOfShares']);
          });
          print(li);
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteclient(int id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/DisableClients/DisableClient?ClientId=${id}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      var response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        Navigator.pop(context);

        Fluttertoast.showToast(
          msg: "Client Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  late Map<String, dynamic> permission = {};

  // void a() async {
  //   var data = await GlobalPermission.formPermission(
  //       "Client\'s Investment Account Opening");
  //   setState(() {
  //     permission = data;
  //   });
  // }

  void initState() {
    super.initState();
    getclientlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                              if (permission['New'] == true)
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => fundList(),
                                      ));
                                    },
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
                              if (permission['Edit'] == true)
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
                              if (permission['View'] == true)
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
                              if (permission['Delete'] == true)
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
                              if (permission['Print'] == true)
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) => KYCPdfUploadIND(),
                                      // ));
                                    },
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
                              //
                              if (permission['Download'] == true)
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
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          IndividualDraftList(),
                                    ));
                                  },
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
                                            "Draft",
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
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 60),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Fund List",
                                    style: TextController.MainHeadingText,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  if (li.isNotEmpty)
                                    Container(
                                      width: 1000,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Table(
                                        border: TableBorder.all(
                                            color: ColorSelect.tabBorderColor),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        columnWidths: {
                                          0: FlexColumnWidth(1),
                                          1: FlexColumnWidth(1)
                                          // 0: FixedColumnWidth(500),
                                          // 1: FixedColumnWidth(500)
                                        },
                                        children: [
                                          TableRow(children: [
                                            Container(
                                                height: 50,
                                                color: ColorSelect.east_grey,
                                                child: Center(
                                                    child: Text(
                                                  "Fund Name",
                                                  style: TextController
                                                      .tableHeading,
                                                ))),
                                            Container(
                                                height: 50,
                                                color: ColorSelect.east_grey,
                                                child: Center(
                                                    child: Text(
                                                  "Per Unit Value",
                                                  style: TextController
                                                      .tableHeading,
                                                ))),
                                            Container(
                                                height: 50,
                                                color: ColorSelect.east_grey,
                                                child: Center(
                                                    child: Text(
                                                  "No Of Shares",
                                                  style: TextController
                                                      .tableHeading,
                                                ))),
                                            Container(
                                                height: 50,
                                                color: ColorSelect.east_grey,
                                                child: Center(
                                                    child: Text(
                                                  "Edit/Delete",
                                                  style: TextController
                                                      .tableHeading,
                                                ))),
                                            // Container(
                                            //   height: 50,
                                            //   color: ColorSelect.east_grey,
                                            // ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  SingleChildScrollView(
                                    child: Container(
                                      // height: 800,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: li.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                              onTap: () async {},
                                              child: table(li[index],  perUnitValue[index],  noOfShares[index], index,
                                                  key[index], context));
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(50.0),
                                        child: Container(
                                          height: 35,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            color: ColorSelect.east_blue,
                                          ),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      ColorSelect.east_blue),
                                            ),
                                            onPressed: () async {
                                              GlobalPermissionFund.Fundclientid = 0;
                                              GlobalPermissionFund.Funddraftprogress = {};
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          new TabOfFundCreation()));
                                            }, // Switch tabs
                                            child: Text(
                                              S.of(context).New,
                                              style: TextController.btnText,
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
                        ),
                        if (sidebarVisible) SideBar() else Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Navigation(),
          ],
        ),
      ),
    );
  }

  Widget table(String templateName, int perUnitValue, int noOfShares, int index,
      int templateKeys, BuildContext context) {
    bool _isHovered = false;

    void _onHover(bool isHovered) {
      setState(() {
        _isHovered = isHovered;
      });
    }

    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              width: 1000,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Table(
                border: TableBorder.all(color: ColorSelect.tabBorderColor),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1)
                  // 0: FixedColumnWidth(500),
                  // 1: FixedColumnWidth(500)
                },
                children: [
                  TableRow(children: [
                    Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          templateName.split("-").join(" "),
                          style: TextController.BodyText,
                        ))),
                    Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          perUnitValue.toString(),
                          style: TextController.BodyText,
                        ))),
                    Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          noOfShares.toString(),
                          style: TextController.BodyText,
                        ))),
                    // Container(
                    //     height: 50,
                    //     child: Center(
                    //         child: Text(
                    //       templateKeys,
                    //       style: TextController.BodyText,
                    //     ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MouseRegion(
                          onEnter: (_) => _onHover(true),
                          onExit: (_) => _onHover(false),
                          child: InkWell(
                            onTap: () async {
                              GlobalPermissionFund.Fundclientid = templateKeys;
                              await GlobalPermissionFund.getdraftprogressfund(
                                  templateKeys);
                              // ANBAccountIndividual.name.value =
                              //     li[index];
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      new TabOfFundCreation()));
                            },
                            child: Icon(
                              Icons.edit,
                              color: ColorSelect.east_blue,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MouseRegion(
                          onEnter: (_) => _onHover(true),
                          onExit: (_) => _onHover(false),
                          child: InkWell(
                            hoverColor: Colors.white,
                            child: Icon(
                              Icons.delete,
                              color: ColorSelect.east_blue,
                            ),
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Are you sure you want to delete this Fund?",
                                              style: TextController.BodyText,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        Container(
                                          height: 35,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: ColorSelect
                                                      .tabBorderColor)),
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              S.of(context).No,
                                              style:
                                                  TextController.SideMenuText,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          width: 140,
                                          decoration: BoxDecoration(
                                              color: ColorSelect.east_blue,
                                              border: Border.all(
                                                  color: ColorSelect
                                                      .tabBorderColor)),
                                          child: TextButton(
                                            onPressed: () async {
                                              deleteclient(templateKeys);
                                              setState(() {
                                                print(li);
                                                li.removeAt(index);
                                                print("NEWLIIIIIIIIII");
                                                print(li);
                                              });
                                            },
                                            child: Text(
                                              S.of(context).Yes,
                                              style: TextController.btnText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
