import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:east_bridge/Advisory/GenerateFinanceExpenseBooking.dart';
import 'package:east_bridge/DPM/PortfolioCreation/ShareCreation.dart';
import 'package:east_bridge/Fund%20Creation/FundFinancialDetails.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/KYC%20Components%20(Corporate)/Fatqa.dart';
import 'package:east_bridge/KYC/KYC%20Components/KYC%20pdf%20Upload/KYCUploadCustomerSearh.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../utility/NewHeader1.dart';

class InvoiceGeneration extends StatefulWidget {
  // InvoiceGeneration({required final List<dynamic> li2}) {
  //   // TODO: implement InvoiceGeneration
  //   throw UnimplementedError();
  // }
  @override
  ClientApprovalState createState() => ClientApprovalState();
  static ValueNotifier<int> id = new ValueNotifier(0);
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<List> list = new ValueNotifier([]);
  static ValueNotifier<List> nameList = new ValueNotifier([]);
  static String type = "";
}

int? Id;

class ClientApprovalState extends State<InvoiceGeneration> {
  TextEditingController desc = new TextEditingController();

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

  final List<dynamic> li2 = [];

  // InvoiceGeneration({required this.li2}) {
  //   // TODO: implement InvoiceGeneration
  //   throw UnimplementedError();
  // }

  late Map<String, dynamic> permission = {};

  // void a() async {
  //   var data = await HeaderTop.number();
  //   setState(() {
  //     permission = data;
  //   });
  // }

  void sendData(int index) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GenerateInvoiceForDPM/generateInvoiceForDPM?transcationId=${int.parse(datavalues[index].split("~")[1])}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "transcationId": int.parse(datavalues[index].split("~")[1]),
      };
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Invoice Generated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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
          },
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String _clientName = "";

  List li = [];
  List key = [];
  List datakeys = [];
  List datavalues = [];
  List totals = [];
  List colors = [];
  List formname = [];
  List advisorykeys = [];
  List milMap = [];
  List milKeys = [];
  List milId = [];

  Future getdata(String formName, String? Approvalby) async {
    print("Fetching formss---");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FormTableLive/getFormsForApproval?FormName=$formName&Approvalby=$Approvalby');
    print(url);
    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        var x = jsonDecode(response.body);
        x = x.reversed.toList();
        datakeys.clear();
        for (var i in x) {
          datakeys.add(i["clientId"]);
        }

        if (formName == "MileStone Achived") {
          print("MileeStoneeeeess");
          print(x);

          milMap.clear();
          milKeys.clear();
          for (var i in x) {
            milMap.add(i["name"] + "~" + i["formid"].toString());
            milKeys.add(i["clientId"]);
          }

          for (String i in milMap) {
            datavalues.add(i.split("~")[0]);
            milId.add(i.split("~")[1]);
          }
        } else {
          for (var i in x) {
            datavalues.add(i["name"] + "~" + i["formid"].toString());
          }
          print(datavalues);
        }
      });
    } else {
      print("Error");
    }
  }

  Future approveform(String FormName, int owner, int? FormId) async {
    if (FormId == null) {
      FormId = 0;
    }
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FormTableLive/FormApprovalsIncreaseLevel?FormName=$FormName&owner=$owner&FormId=$FormId');
    print(url);
    var headers = {
      'Content-Type': 'application/json',
    };
    var data = {"FormName": FormName, "owner": owner};
    var response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      if (GlobalPermission.userType != "Relationship Manager") {
        Fluttertoast.showToast(
            msg: "Invoice sent to RM",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Invoice Paid",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      setState(() {
        print("approved");
        print(datakeys);
        print(datavalues);
        setState(() {
          int indextoremove = datakeys.indexOf(owner);
          datakeys.removeAt(indextoremove);
          datavalues.removeAt(indextoremove);
          int x =
              GlobalPermission.notificationList.indexOf(InvoiceGeneration.type);
          setState(() {
            GlobalPermission.count = GlobalPermission.count - 1;
            GlobalPermission.notifiacationbottomvalues[x] =
                GlobalPermission.notifiacationbottomvalues[x] - 1;
            print("notiiiiii---");
            print(GlobalPermission.notifiacationbottomvalues);
            print(GlobalPermission.notificationList);
          });
        });
      });
    } else {
      Fluttertoast.showToast(
          msg: "Fail",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print("Error");
    }
  }

  void initState() {
    super.initState();
    print('clinetapprobval');

    getdata(InvoiceGeneration.type, GlobalPermission.userType);
  }

  static _launchurl(int id, String formname, int clientId) async {
    print(clientId);
    // formname = formname.split('~')[1];

    // Replace 'your_username' and 'your_password' with your actual credentials
    var username = 'Administrator';
    var password = 'hX9b7aBd\$2Z';
    var url = Uri.parse(
        "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${formname}&rs:Command=Render&TID=${id}&CID=${clientId}");

    //   if (await canLaunchUrl(url)) {
    //     await launchUrl(url);
    //   } else {
    //     print("error can' ssrs launch");
    //   }
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                color: Colors.white,
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
                                          builder: (context) =>
                                              InvoiceGeneration(
                                                  // li2: [],
                                                  ),
                                        ));
                                      },
                                      child: Container(
                                        //color: ColorSelect.east_blue,
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
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
                                                style: TextController
                                                    .ControllerText,
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
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.edit_calendar_outlined,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                S.of(context).Edit,
                                                style: TextController
                                                    .ControllerText,
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
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.content_paste_search,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                S.of(context).View,
                                                style: TextController
                                                    .ControllerText,
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
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons
                                                    .free_cancellation_outlined,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                S.of(context).Cancel,
                                                style: TextController
                                                    .ControllerText,
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
                                        //   builder: (context) => InvoiceGeneration(),
                                        // ));
                                      },
                                      child: Container(
                                        //color: ColorSelect.east_blue,
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.print,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                S.of(context).Print,
                                                style: TextController
                                                    .ControllerText,
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
                                            const Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons.download,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Center(
                                              child: Text(
                                                S.of(context).Download,
                                                style: TextController
                                                    .ControllerText,
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
                                          const Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.save_as_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
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
                            transform: Matrix4.translationValues(
                                xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ColorSelect.east_grey,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            InvoiceGeneration.type +
                                                " " +
                                                S.of(context).Approval,
                                            style:
                                                TextController.MainHeadingText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
                                      // height: 800,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: datakeys.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                              onTap: () {
                                                print(datakeys[index]);
                                              },
                                              child: SingleChildScrollView(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SingleChildScrollView(
                                                      child: Container(
                                                        height: 120,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal: 40),
                                                        child: Card(
                                                          elevation: 5.0,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20.0),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                Text(
                                                                  datavalues[
                                                                          index]
                                                                      .split(
                                                                          "~")[0],
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Gotham',
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                                if (GlobalPermission
                                                                        .userType !=
                                                                    "Relationship Manager")
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (InvoiceGeneration
                                                                              .type ==
                                                                          "MileStone Achived") {
                                                                        showHtmlAlert(
                                                                            context,
                                                                            milKeys[index].toString(),
                                                                            milId[index].toString());
                                                                      } else if (InvoiceGeneration
                                                                              .type ==
                                                                          "Product Invoice") {
                                                                        sendData(
                                                                            index);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                        "Generate Invoice"),
                                                                  ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    if (InvoiceGeneration.type ==
                                                                            "Product Invoice" &&
                                                                        int.parse(datakeys[index]) !=
                                                                            0) {
                                                                      print(
                                                                          "ffff");
                                                                      _launchurl(
                                                                          int.parse(datavalues[index].split("~")[
                                                                              1]),
                                                                          "ProductInvoice",
                                                                          datakeys[
                                                                              index]);
                                                                    } else {
                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              "Please Generate Invoice First",
                                                                          toastLength: Toast
                                                                              .LENGTH_SHORT,
                                                                          gravity: ToastGravity
                                                                              .CENTER,
                                                                          timeInSecForIosWeb:
                                                                              3,
                                                                          backgroundColor: Colors
                                                                              .red,
                                                                          textColor: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16.0);
                                                                    }
                                                                  },
                                                                  child: Text(
                                                                      "View Invoice"),
                                                                ),
                                                                (InvoiceGeneration.type ==
                                                                            "Product Invoice" &&
                                                                        GlobalPermission.userType !=
                                                                            "Relationship Manager")
                                                                    ? Container(
                                                                        height:
                                                                            35,
                                                                        width:
                                                                            140,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              ColorSelect.east_blue,
                                                                        ),
                                                                        child:
                                                                            TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            approveform(
                                                                                "Product Invoice",
                                                                                datakeys[index],
                                                                                int.parse(datavalues[index].split("~")[1]));
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            "Send to RM",
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Gotham',
                                                                              fontSize: 12.0,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                                if (GlobalPermission
                                                                        .userType ==
                                                                    "Relationship Manager")
                                                                  Container(
                                                                    height: 35,
                                                                    width: 140,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: ColorSelect
                                                                          .east_blue,
                                                                    ),
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        approveform(
                                                                            "Product Invoice",
                                                                            datakeys[index],
                                                                            int.parse(datavalues[index].split("~")[1]));
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Paid",
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'Gotham',
                                                                          fontSize:
                                                                              12.0,
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ));
                                          // child: table(,d,
                                          //    context));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (sidebarVisible) SideBar() else Container(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Navigation(),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showHtmlAlert(BuildContext context, String id, String data) async {
  String htmlcontent = "";
  if (InvoiceGeneration.type == "KYC") {
    htmlcontent = await getkycdata(int.parse(id));
  }
  print(InvoiceGeneration.type);
  if (InvoiceGeneration.type == "Fund Creation") {
    htmlcontent = await getfunddata(int.parse(id));
  }
  if (InvoiceGeneration.type == "Advisory Service") {
    htmlcontent = await getAdvisorydata(int.parse(id), int.parse(data));
  }
  if (InvoiceGeneration.type == "MileStone Achived") {
    htmlcontent = await getMilestone(int.parse(id), int.parse(data));
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Details'),
        content: SingleChildScrollView(
          child: Html(data: htmlcontent),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
              SizedBox(
                width: 10,
              ),
              if (InvoiceGeneration.type == "MileStone Achived")
                TextButton(
                  onPressed: () {
                    FinanceExpenseBooking.clientid.value = int.parse(id);
                    FinanceExpenseBooking.advisoryId.value = advisoryid;
                    FinanceExpenseBooking.mId.value = int.parse(data);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FinanceExpenseBooking(),
                      ),
                    );
                  },
                  child: Text('Generate Invoice'),
                ),
            ],
          ),
        ],
      );
    },
  );
}

Future getkycdata(int id) async {
  var url = Uri.parse(
      '${GlobalPermission.urlLink}/api/GetClientDataForAgreement?id=$id');

  var headers = {
    'Content-Type': 'application/json',
  };
  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    print("Strrt");
    var data = jsonDecode(response.body);
    print(data["Name"]);

    return '''
<style>
  body {
    font-family: 'Gotham';
  
  }

  .container {
   
    border-radius: 8px;
   
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);

    text-align: center;
  }

  h1 {
    color: #333;
    margin-bottom: 15px;
  }

</style>

  <h1>
    Name : ${data["Name"]}
  </h1>
  <div>
    Id: ${data["Id"]}
  </div>
  <div>
    Address: ${data["Address"]}
  </div>
  <div>
    Mobile: ${data["Mobile"]}
  </div>
  <div>
    Email: ${data["Email"]}
  </div>


''';
  } else {
    return "<h1>Data not found</h1>";
  }
}

Future getfunddata(int id) async {
  var url = Uri.parse(
      '${GlobalPermission.urlLink}/api/FundDetailandClassification/fundDetailandClassification/$id');

  var headers = {
    'Content-Type': 'application/json',
  };
  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    print("Strrt");
    var data = jsonDecode(response.body);
    print(data["fundName"]);

    return '''
<style>
  body {
    font-family: 'Gotham';
  
  }

  .container {
   
    border-radius: 8px;
   
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);

    text-align: center;
  }

  h1 {
    color: #333;
    margin-bottom: 15px;
  }

</style>

  <h1>
   Fund Name : ${data["fundName"]}
  </h1>
  <div>
    Fund Desc: ${data["fundDescription"]}
  </div>
  <div>
    Ind category : ${data["industryCategory"]}
  </div>
  <div>
    Stastus: ${data["status"]}
  </div>
  <div>
    fundCode: ${data["fundCode"]}
  </div>
    <div>
    fromDate: ${data["fromDate"]}
  </div>
   </div>
    <div>
    toDate: ${data["toDate"]}
  </div>


''';
  } else {
    return "<h1>Data not found</h1>";
  }
}

int advisoryid = 0;
Future getMilestone(int id, int mid) async {
  print("getting");
  var url = Uri.parse(
      '${GlobalPermission.urlLink}/api/AdvisoryMileStone/ClientMileStronegetByMileStoneId?ClientId=${id}&milestoneid=${mid}');
  print(url);
  var headers = {
    'Content-Type': 'application/json',
  };
  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    print("Strrt");
    var data;
    print("Workingggggggggggggggg");
    print(response.body);
    var jsonResponse = json.decode(response.body);
    if (jsonResponse is List<dynamic>) {
      data = jsonResponse;
      advisoryid = data[0]["advisoryId"];
      print(advisoryid);
    }

    return '''
<style>
  body {
    font-family: 'Gotham';
  
  }

  .container {
   
    border-radius: 8px;
   
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);

    text-align: center;
  }

  h1 {
    color: #333;
    margin-bottom: 15px;
  }
  

</style>
<h1>
   Servie Name : ${data[0]["advisoryname"]}
  </h1>
<h1>
   Milestone Name : ${data[0]["mileStone"]}
  </h1>
  <div>
    Duration: ${data[0]["duration"]}
  </div>
  <div>
    Status : ${data[0]["mark"] == true ? "Achieved" : "Not Achieved"}
  </div>

  



''';
  } else {
    return "<h1>Data not found</h1>";
  }
}

Future getAdvisorydata(int cid, int aid) async {
  var url = Uri.parse(
      '${GlobalPermission.urlLink}/api/AdvisoryMileStone/ClientMileStroneGet?ClientId=$cid&Advisoryid=$aid');
  print(url);

  var headers = {
    'Content-Type': 'application/json',
  };
  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    print("Strrt");
    Map x = jsonDecode(response.body);
    var data = x.keys.toList();
    var achive = x.values.toList();

    String header = '''
<style>
  body {
    font-family: 'Gotham';
  
  }
</style>
<h1>MileStones</h1>

''';
    String li = "";
    for (int i = 0; i < data.length; i++) {
      print(i);
      li +=
          '''<ul> <li>${data[i]}________Status: ${achive[i].split("~")[0] == "False" ? "Not Achieved" : "Achieved"}</li> </ul>''';
    }

    return header + li;
  } else {
    return "<h1>Data not found</h1>";
  }
}
