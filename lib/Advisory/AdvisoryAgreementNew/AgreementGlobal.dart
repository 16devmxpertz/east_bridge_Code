import 'package:east_bridge/Advisory/AdvisoryAgreementNew/tabOfAgreement.dart';
import 'package:east_bridge/Advisory/AdvisoryGlobal.dart';
import 'package:east_bridge/FundAgreement/FundAgreement.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/CorporateClientList.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/CorporatedraftList.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:east_bridge/Fund Creation/TabOfFundCreation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utility/Drawer.dart';
import '../AdvisoryCustomerAgreement/Customer Advisory Agreement/Customer Advisory Agreement/CustomerMilestoneFeesAgreement.dart';

//import 'package:todo/Colors.dart';

class DefaulAgreementCreation extends StatefulWidget {
  DefaulAgreementCreation({@required controller}) {
    tabController = controller;
  }
  @override
  _DefaulAgreementCreationState createState() =>
      _DefaulAgreementCreationState();
}

TabController? tabController;

class _DefaulAgreementCreationState extends State<DefaulAgreementCreation> {
  late Map<String, dynamic> permission = {};
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

  final HtmlEditorController controller = HtmlEditorController();
  TextEditingController tempName = new TextEditingController();
  String? valueText;
  List<String> finalitems = [];

  int? editIndex; // Updated type to int?

  @override
  void initState() {
    super.initState();
    loadTodoItems();
    print("----");
  }

  List<String> content = [];
  void setContent() async {
    content.clear();
    for (String i in finalitems) {
      String t = "";
      String y = "";
      for (int x = 0; x < i.length - 3; x++) {
        if (i[x] + i[x + 1] + i[x + 2] + i[x + 3] == '<ul>') {
          break;
        }
        t += i[x];
      }
      bool skip = false;
      for (int x = 0; x < t.length; x++) {
        if (t[x] == '<') {
          skip = true;
          continue;
        }
        if (t[x] == '>') {
          skip = false;
          continue;
        }
        if (skip == false) {
          y += t[x];
        }
      }
      setState(() {
        content.add(y.trim().replaceAll(RegExp(r'\s+'), ' '));
      });
    }
    print(content);
  }

  void loadTodoItems() async {
    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/DefaultAgreements/DefaultAgreementGet?type=Advisory'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.body);
      print("Successful");
      List<String> li = [];
      for (int i = 0; i < responseData.length; i++) {
        li.add(responseData[i]);
      }
      setState(() {
        finalitems = li;
      });
      setContent();
    } else {
      print("Error");
    }
  }

  void startEdit(int index) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            height: 500,
            width: 1500,
            child: Column(
              children: [
                HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: HtmlEditorOptions(
                      shouldEnsureVisible: true,
                      initialText: finalitems[index]),
                ),
                TextButton(
                  onPressed: () async {
                    print("press");
                    final newItem = await controller.getText();
                    if (newItem.isNotEmpty) {
                      setState(() {
                        finalitems[index] = newItem;
                        setContent();
                      });
                      Navigator.pop(context); // Close the AlertDialog
                    }
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void Addtodo() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            height: 500,
            width: 1500,
            child: Column(
              children: [
                HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: HtmlEditorOptions(
                      shouldEnsureVisible: true,
                      initialText: "#num. Heading<br><ul><li>Points</li></ul>"),
                ),
                TextButton(
                  onPressed: () async {
                    print("press");
                    final newItem = await controller.getText();
                    if (newItem.isNotEmpty) {
                      setState(() {
                        finalitems.add(newItem);
                      });
                      Navigator.pop(context);
                      setContent();
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> senddata() async {
    print("data sending");
    var headers = {
      'Content-Type': 'application/json',
    };

    var data = {
      "clientId": GlobalPermissionAdvisory.Advisoryclientid,
      "advisoryId": GlobalPermissionAdvisory.AdvisoryIdService,
      "agreementName": valueText,
      "todos": finalitems
    };
    print(data);
    final response = await http.post(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/ClientAdvisoiryAgreementLink/ClientAdvisoryAgreementLinking'),
      headers: headers,
      body: jsonEncode(data),
    );

    print(response.body);
    if (response.statusCode == 200) {
      LinkingData();

      // Request successful, handle the response

      Fluttertoast.showToast(
          msg: "Agreement Saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      print("Successful");
      Navigator.pop(context);
      setState(() {
        GlobalPermissionAdvisory.description.text = "";
      });
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => TabOfAgreement()),
      );
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) =>
      //         // customerGetAdvisoryAgreement(AdvisorygreementSearch.id.value)));
      //         AdvisoryAgreement(
      //             // GlobalPermissionAdvisory.AdvisoryIdglobal
      //             )));
      return true;

      // Process the responseData
    } else {
      print("It's now working");
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      return false;
      // Display or handle the error
    }
  }

  void LinkingData() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ClientAdvisoiryAgreementLink/ClientAdvisoryLinking');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPermissionAdvisory.Advisoryclientid,
      "advisoryId": GlobalPermissionAdvisory.AdvisoryIdService,
      "duration": 0,
      "date": "2023-15-4"
    };
    print(body);
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Client is Linked");
      bool y = await GlobalPermission.formApproval(
          "Advisory Service",
          GlobalPermissionAdvisory.Advisoryclientid,
          GlobalPermissionAdvisory.clientNameGlobal +
              "~" +
              GlobalPermissionAdvisory.AdvisoryServiceNameGlobal +
              "~" +
              GlobalPermissionAdvisory.AdvisoryIdService.toString(),
          GlobalPermissionAdvisory.AdvisoryIdService);

      // GlobalPermissionAdvisory.AdvisoryIdService = 0;
      // GlobalPermissionAdvisory.Advisoryclientid = 0;
      // GlobalPermissionAdvisory.clientIdglobalRedeem = 0;
      // GlobalPermissionAdvisory.AdvisoryIdglobalRedeem = 0;

      // GlobalPermissionAdvisory.clientNameGlobal = "";
      // GlobalPermissionAdvisory.AdvisoryServiceNameGlobal = "";
      // GlobalPermissionAdvisory.milestones = [];
      // GlobalPermissionAdvisory.milestonesduration = [];
      // GlobalPermissionAdvisory.li = [];
      // GlobalPermissionAdvisory.duration = [];
      // GlobalPermissionAdvisory.FeesList = [];
      // GlobalPermissionAdvisory.feesListfinal = [];
      // GlobalPermissionAdvisory.items = {};
      // GlobalPermissionAdvisory.scopeOfWork.text = "";
      // GlobalPermissionAdvisory.description.text = "";
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                                        builder: (context) =>
                                            CorporateClientList(),
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
                                          CorporateDraftList(),
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
                            // height: 10,
                            // width: 600,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    color: ColorSelect.east_grey,
                                    child: Center(
                                        child: Text(
                                      "Advisory Agreement",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: ColorSelect.east_blue),
                                    )),
                                  ),
                                  Container(
                                    height: 500,
                                    child: ListView.builder(
                                      itemCount: content.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Container(
                                            child: Text('${content[index]}'),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 500,
                                    child: ListView.builder(
                                      itemCount: finalitems.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Container(
                                            child: ListTile(
                                              title: Html(
                                                data: finalitems[index],
                                                style: {
                                                  'body': Style(
                                                      fontSize:
                                                          FontSize.medium),
                                                },
                                              ),
                                              trailing: SizedBox(
                                                width: 80,
                                                child: Row(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.edit),
                                                      onPressed: () {
                                                        startEdit(index);
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.delete),
                                                      onPressed: () {
                                                        setState(() {
                                                          finalitems
                                                              .removeAt(index);
                                                          content
                                                              .removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 1100,
                                            top: 15,
                                            bottom: 15,
                                            right: 15),
                                        child: Container(
                                          width: 100,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              Addtodo();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: ColorSelect
                                                  .east_blue, // Set the desired background color
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    0), // Set border radius to 0
                                              ),
                                            ),
                                            child: Text("Add"),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 100,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      S.of(context).Save,
                                                      style: TextController
                                                          .SubHeadingText,
                                                    ),
                                                    content: Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .EnterTemplateName,
                                                            style:
                                                                TextController
                                                                    .BodyText,
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Flexible(
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              width: 290,
                                                              height: 35,
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border.all(
                                                                      color: ColorSelect
                                                                          .textField)),
                                                              child:
                                                                  TextFormField(
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    valueText =
                                                                        value;
                                                                  });
                                                                },
                                                                controller:
                                                                    tempName,
                                                                textAlignVertical:
                                                                    TextAlignVertical
                                                                        .center,
                                                                style: TextController
                                                                    .BodyHeadingText,
                                                                decoration: InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    hintText: S
                                                                        .of(
                                                                            context)
                                                                        .TypeHere,
                                                                    hintStyle:
                                                                        TextController
                                                                            .labelText,
                                                                    border:
                                                                        InputBorder
                                                                            .none),
                                                              ),
                                                            ),
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
                                                            setState(() {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .Cancel,
                                                            style: TextController
                                                                .SideMenuText,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 140,
                                                        decoration: BoxDecoration(
                                                            color: ColorSelect
                                                                .east_blue,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .tabBorderColor)),
                                                        child: TextButton(
                                                          onPressed: () async {
                                                            print("pressedd");
                                                            if (valueText ==
                                                                null) {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "Please Enter Agreement Name.",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER,
                                                                  timeInSecForIosWeb:
                                                                      3,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                            } else {
                                                              senddata();
                                                              GlobalPermissionAdvisory
                                                                  .li
                                                                  .clear();
                                                              GlobalPermissionAdvisory
                                                                  .milestones
                                                                  .clear();
                                                              GlobalPermissionAdvisory
                                                                  .duration
                                                                  .clear();
                                                              GlobalPermissionAdvisory
                                                                      .FeesList
                                                                  .clear();
                                                              GlobalPermissionAdvisory
                                                                  .feesListfinal
                                                                  .clear();
                                                              GlobalPermissionAdvisory
                                                                  .scopeOfWork
                                                                  .clear();
                                                            }
                                                          },
                                                          child: Text(
                                                            S.of(context).OK,
                                                            style:
                                                                TextController
                                                                    .btnText,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: Text("Save"),
                                          style: ElevatedButton.styleFrom(
                                            primary: ColorSelect
                                                .east_blue, // Set the desired background color
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                          ),
                                        ),
                                      )
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
}
