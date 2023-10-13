import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:east_bridge/Advisory/GenerateFinanceExpenseBooking.dart';
import 'package:east_bridge/Approval/RiskCorporateApproval.dart';
import 'package:east_bridge/Approval/RiskIndividualApproval.dart';
import 'package:east_bridge/Approval/RiskPOAApproval.dart';
import 'package:east_bridge/DPM/PortfolioCreation/ShareCreation.dart';
import 'package:east_bridge/Fund%20Creation/FundFinancialDetails.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/KYC%20Components%20(Corporate)/Fatqa.dart';
import 'package:east_bridge/KYC/KYC%20Components/KYC%20pdf%20Upload/KYCUploadCustomerSearh.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/RiskAssessmentFormInvidual.dart';
import 'package:east_bridge/RiskAssessmentFormPOA.dart';
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

import '../RiskAssessmentFormCorporate.dart';
import '../utility/NewHeader1.dart';

class ClientApproval extends StatefulWidget {
  // ClientApproval({required final List<dynamic> li2}) {
  //   // TODO: implement ClientApproval
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

class ClientApprovalState extends State<ClientApproval> {
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

  // ClientApproval({required this.li2}) {
  //   // TODO: implement ClientApproval
  //   throw UnimplementedError();
  // }

  late Map<String, dynamic> permission = {};

  // void a() async {
  //   var data = await HeaderTop.number();
  //   setState(() {
  //     permission = data;
  //   });
  // }

  String _clientName = "";

  List li = [];
  List key = [];
  List datakeys = [];
  List datavalues = [];
  List risknames = [];

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
      setState(() {
        print("Strrt----");
        var x = jsonDecode(response.body);
        x = x.reversed.toList();

        datakeys.clear();
        for (var i in x) {
          datakeys.add(i["clientId"]);
        }

        if (formName == "Risk Assesment") {
          List<dynamic> y = [];

          for (var i in x) {
            y.add(i["name"] + "-" + i["formid"].toString());
          }
          for (String i in y) {
            datavalues.add(i.split("-")[0]);
            totals.add(i.split("-")[1]);
            colors.add(i.split("-")[2]);
            risknames.add(i.split("-")[3]);
          }
        } else if (formName == "Advisory Service") {
          List<dynamic> y = [];

          for (var i in x) {
            y.add(i["name"] + "~" + i["formid"].toString());
          }

          for (String i in y) {
            datavalues.add("Name:" +
                i.split("~")[0] +
                "\nService Name:" +
                i.split("~")[1]);
            advisorykeys.add(i.split("~")[2]);
          }
        } else {
          for (var i in x) {
            datavalues.add(i["name"]);
            //  datakeys = jsonDecode(response.body).keys;
            //  datakeys = jsonDecode(response.body).values;
          }
        }

        print(datavalues);
        print("END-----");
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
      Fluttertoast.showToast(
          msg: "Approved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        print("approved");
        print(datakeys);
        print(datavalues);
        setState(() {
          int indextoremove = datakeys.indexOf(owner);
          datakeys.removeAt(indextoremove);
          datavalues.removeAt(indextoremove);
          int x =
              GlobalPermission.notificationList.indexOf(ClientApproval.type);
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

  Future rejectForm(String FormName, int owner) async {
    print("reject Form");

    var url = Uri.parse('${GlobalPermission.urlLink}/api/RejectedForm');
    print(url);
    var headers = {
      'Content-Type': 'application/json',
    };
    var data = {
      "formId": owner,
      "rejectedBy": GlobalPermission.userType,
      "formType": FormName,
      "description": desc.text
    };
    print(data);
    var response =
        await http.post(url, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Rejected",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        print("rejected");
        print(datakeys);
        print(datavalues);
        setState(() {
          int indextoremove = datakeys.indexOf(owner.toString());
          datakeys.removeAt(indextoremove);
          datavalues.removeAt(indextoremove);
          int x =
              GlobalPermission.notificationList.indexOf(ClientApproval.type);
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
      setState(() {
        desc.text = "";
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

  // _launchURLApp(int id, String formname) async {
  //   var url = Uri.parse(
  //       "http://eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${formname}&rs:Command=Render&ID=${id}&rs:FORMAT=PDF");
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // _launchURLApp(int id, String formname) async {
  //   formname = formname.split('~')[1];

  //   if (formname == "Individual") {
  //     formname = "IndividualFinal";
  //   }
  //   if (formname == "Corporate") {
  //     formname = "Corporate";
  //   }
  //   if (formname == "POA") {
  //     formname = "POAFinal";
  //   }
  //   // Replace 'your_username' and 'your_password' with your actual credentials
  //   var username = 'Administrator';
  //   var password = 'hX9b7aBd\$2Z';
  //   var url = Uri.parse(
  //       "http://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${formname}&rs:Command=Render&ID=${id}&rs:FORMAT=PDF");

  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  Uri createConnectionString({
    String? reportName,
    int? id,
  }) {
    final serverUrl =
        Uri.parse('http://eastbridge.online/ReportServer'); // SSRS server URL
    final formname = Uri.encodeComponent(reportName!);
    final queryString =
        '?%2fEastBridgeReport%2f$formname&rs:Command=Render&ID=$id&rs:FORMAT=PDF';
    return Uri.parse('$serverUrl/Pages/ReportViewer.aspx$queryString');
  }

  Future<void> fetchReport(int id, String formname) async {
    final connectionString = createConnectionString(
      reportName: formname, // Replace with your actual report name
      id: id, // Replace with the ID or parameter value
    );

    final response = await http.get(connectionString);

    // Process the response here
    if (response.statusCode == 200) {
      // Report fetched successfully
      // Handle the response data or display the PDF report
      // response.body contains the binary PDF data
    } else {
      // Handle error
      print('Error fetching report: ${response.statusCode}');
    }
  }

  void initState() {
    super.initState();
    print('clinetapprobval');

    getdata(ClientApproval.type, GlobalPermission.userType);
  }

  Widget RiskDialog(int i) {
    print("RiskkkkOpening");
    print(datavalues[i].split("~")[1]);
    return AlertDialog(
      title: Text('Custom Dialog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Text('This is a custom dialog with your StatefulWidget.'),
          // if (datavalues[i].split("~")[1] == "Individual") RiskForm(),
          // if (datavalues[i].split("~")[1] == "Corporate") RiskFormCorporate(),
          // if (datavalues[i].split("~")[1] == "POA") RiskFormPOA()
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
    );
  }

  void AddNew(int i) {
    print("IDDD");
    // print(int.parse(datakeys[i]));
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            scrollable: true,
            title: Text(
              "Risk Assessment",
              style: TextController.BodyHeadingText,
            ),
            content: (ClientApproval.type == "Risk Assesment")
                ? (risknames[i] == "Individual")
                    ? RiskIndividualApproval(
                        id: datakeys[i],
                      )
                    : (risknames[i] == "Corporate")
                        ? RiskCorporateApproval(
                            id: datakeys[i],
                          )
                        : (risknames[i] == "POA")
                            ? RiskPOAApproval(id: datakeys[i])
                            : Container()
                : (datavalues[i].split("~")[1] == "Individual")
                    ? RiskIndividualApproval(
                        id: datakeys[i],
                      )
                    : (datavalues[i].split("~")[1] == "Corporate")
                        ? RiskCorporateApproval(
                            id: datakeys[i],
                          )
                        : (datavalues[i].split("~")[1] == "POA")
                            ? RiskPOAApproval(id: datakeys[i])
                            : Container(),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).Cancel,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Successfully Saved",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      S.of(context).Save,
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
                                          builder: (context) => ClientApproval(
                                              // li2: [],
                                              ),
                                        ));
                                      },
                                      child: Container(
                                        //color: ColorSelect.east_blue,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons
                                                    .free_cancellation_outlined,
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
                                        //   builder: (context) => ClientApproval(),
                                        // ));
                                      },
                                      child: Container(
                                        //color: ColorSelect.east_blue,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                            ClientApproval.type +
                                                " " +
                                                S.of(context).Approval,
                                            style:
                                                TextController.MainHeadingText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
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
                                                        padding: EdgeInsets
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
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Gotham',
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                                (ClientApproval
                                                                            .type ==
                                                                        "Risk Assesment")
                                                                    ? TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          AddNew(
                                                                              index);
                                                                        },
                                                                        child: Text(
                                                                            "Color : ${colors[index]}  Total: ${totals[index]} "),
                                                                      )
                                                                    : TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          print(
                                                                              "primnttttt");
                                                                          if (ClientApproval.type ==
                                                                              "Fund Creation") {
                                                                            showHtmlAlert(
                                                                                context,
                                                                                datakeys[index],
                                                                                "");
                                                                          } else if (ClientApproval.type ==
                                                                              "Advisory Service") {
                                                                            showHtmlAlert(
                                                                                context,
                                                                                datakeys[index],
                                                                                advisorykeys[index].toString());
                                                                          } else if (ClientApproval.type ==
                                                                              "MileStone Achived") {
                                                                            showHtmlAlert(
                                                                                context,
                                                                                milKeys[index],
                                                                                milId[index]);
                                                                          } else {
                                                                            GlobalPermission.reportsDownloadKYCApproval(datakeys[index],
                                                                                datavalues[index]);
                                                                          }
                                                                        },
                                                                        child: Text(
                                                                            "View Details"),
                                                                      ),
                                                                if (ClientApproval
                                                                            .type ==
                                                                        "KYC" &&
                                                                    GlobalPermission
                                                                            .userType ==
                                                                        "Compliance")
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      AddNew(
                                                                          index);
                                                                      // RiskDialog(
                                                                      //     index);
                                                                    },
                                                                    child: Text(
                                                                        "Risk Assessment"),
                                                                  ),
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
                                                                      if (ClientApproval
                                                                              .type ==
                                                                          "Advisory Service") {
                                                                        approveform(
                                                                            ClientApproval.type,
                                                                            datakeys[index],
                                                                            int.parse(advisorykeys[index]));
                                                                      } else {
                                                                        approveform(
                                                                            ClientApproval.type,
                                                                            datakeys[index],
                                                                            null);
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      "Approve",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gotham',
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
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
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                Text(
                                                                              'Enter Reason',
                                                                              style: TextController.BodyHeadingText,
                                                                            ),
                                                                            content:
                                                                                StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                                                                              return Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                width: 280,
                                                                                height: 35,
                                                                                alignment: Alignment.centerLeft,
                                                                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: ColorSelect.textField)),
                                                                                child: TextFormField(
                                                                                  controller: desc,
                                                                                  textAlignVertical: TextAlignVertical.center,
                                                                                  style: TextController.BodyText,
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    hintText: S.of(context).FirstName,
                                                                                    hintStyle: TextController.labelText,
                                                                                    border: InputBorder.none,
                                                                                    errorStyle: TextStyle(height: 0.0),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  setState(() {
                                                                                    desc.text = "";
                                                                                  });
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text('Cancel'),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  rejectForm(ClientApproval.type, datakeys[index]);

                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: Text('Reject'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      "Reject",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Gotham',
                                                                        fontSize:
                                                                            12.0,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
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

Future<void> showHtmlAlert(BuildContext context, int id, String data) async {
  String htmlcontent = "";
  if (ClientApproval.type == "KYC") {
    htmlcontent = await getkycdata(id);
  }
  print(ClientApproval.type);
  if (ClientApproval.type == "Fund Creation") {
    htmlcontent = await getfunddata(id);
  }
  if (ClientApproval.type == "Advisory Service") {
    htmlcontent = await getAdvisorydata(id, int.parse(data));
  }
  if (ClientApproval.type == "MileStone Achived") {
    htmlcontent = await getMilestone(id, int.parse(data));
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
              if (ClientApproval.type == "MileStone Achived")
                TextButton(
                  onPressed: () {
                    FinanceExpenseBooking.clientid.value = id;
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
      '${GlobalPermission.urlLink}/api/GetFundDetails/GetFundDetails?FundId=${id}');

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
    Total Value: ${data["totalValueOfFund"]}
  </div>
  <div>
    Number of Units : ${data["noOfShares"]}
  </div>
  <div>
    Per Unit Value: ${data["perShareValue"]}
  </div>
   <div>
    Status: ${data["status"]}
  </div>
  <div>
    Fund Code: ${data["fundCode"]}
  </div>
    <div>
    From Date: ${data["fromDate"]}
  </div>
   </div>
    <div>
    To Date: ${data["toDate"]}
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
