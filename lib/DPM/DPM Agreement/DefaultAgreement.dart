import 'package:dio/dio.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/CustomerDPMAgreement.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/CustomerFundAgreement.dart';
import 'package:east_bridge/FundAgreement/FundAgreement.dart';
import 'package:east_bridge/Global.dart';
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

import '../../generated/l10n.dart';
import '../../utility/Drawer.dart';

//import 'package:todo/Colors.dart';

class DPMDefaultAgreement extends StatefulWidget {
  @override
  _DPMDefaultAgreementState createState() => _DPMDefaultAgreementState();

  static ValueNotifier<String> fmaddress = ValueNotifier("");
  static ValueNotifier<String> fmcompany = ValueNotifier("");
  static ValueNotifier<String> custodianAddress = ValueNotifier("");
  static ValueNotifier<String> custodianCompany = ValueNotifier("");
  static ValueNotifier<String> foaddress = ValueNotifier("");
  static ValueNotifier<String> focompany = ValueNotifier("");
  static ValueNotifier<String> ataddress = ValueNotifier("");
  static ValueNotifier<String> le = ValueNotifier("");
  static ValueNotifier<String> investmentExp = ValueNotifier("");
  static ValueNotifier<String> riskAbility = ValueNotifier("");
  static ValueNotifier<String> investmentObj = ValueNotifier("");
  static ValueNotifier<String> source = ValueNotifier("");
  static ValueNotifier<String> annualIncome = ValueNotifier("");
  static ValueNotifier<String> netWorth = ValueNotifier("");
  static ValueNotifier<String> boardDirector = ValueNotifier("");
  static ValueNotifier<String> pep = ValueNotifier("");
  static ValueNotifier<String> owner = ValueNotifier("");
}

class _DPMDefaultAgreementState extends State<DPMDefaultAgreement> {
  final HtmlEditorController controller = HtmlEditorController();

  List<String> todoItemsenglish = [];
  List<String> finalitems = [];

  List<String> todoItemsarbic = [];

  int? editIndex; // Updated type to int?

  @override
  void initState() {
    super.initState();
    loadTodoItemsarabic();
    loadTodoItems();
  }

  String? valueText;
  String? codeDialog;

  TextEditingController tempName = new TextEditingController();
  void loadTodoItemsarabic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse(
          'https://8.213.23.26:8081/apicore/api/GetDPMAgreements/GetDPMAgreements?AgreementId=2'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.body);
      print("Successful");
      for (int i = 0; i < responseData.length; i++) {
        todoItemsarbic.add(responseData[i]);
      }
      prefs.setStringList('todoItemsarabic', todoItemsarbic);

      // Process the responseData
    } else {
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      // Display or handle the error
    }

    setState(() {
      finalitems = todoItemsarbic;
      prefs.setStringList('todoItemsfinal', todoItemsarbic);
    });
  }

  late final id;

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
                      });
                      Navigator.pop(context); // Close the AlertDialog
                    }
                  },
                  child: Text('Update Todo'),
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
                      shouldEnsureVisible: true, initialText: ""),
                ),
                TextButton(
                  onPressed: () async {
                    print("press");
                    final newItem = await controller.getText();
                    if (newItem.isNotEmpty) {
                      setState(() {
                        finalitems.add(newItem);
                      });
                      Navigator.pop(context); // Close the AlertDialog
                    }
                  },
                  child: Text('Add New'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var dio = Dio();
  void senddata() async {
    print("data sending");
    var headers = {
      'Content-Type': 'application/json',
    };

    int n = finalitems.length;

    var data = {
      "EmployeeId": GlobalPermission.employeeId,
      "AgreementName": tempName.text,
      "AgreeemntData": finalitems
    };
    final response = await http.post(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/DPMagreements/AddDPMAgreement/'),
      headers: headers,
      body: jsonEncode(data),
    );
    print(data);
    if (response.statusCode == 200) {
      // Request successful, handle the response
      // var responseData = jsonDecode(response.toString());
      print("Successful");
      id = int.parse(response.body.toString());
      print(id);
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Agreement Save Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CustomerDPMAgreement()));

      // Process the responseData
    } else {
      // Request failed, handle the error
      print(response.body);

      print("Error");

      // Display or handle the error
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
          constraints: BoxConstraints(),
          child: Stack(
            children: [
              Container(
                // height: 50000,
                // width: double.infinity,
                margin: EdgeInsets.only(top: 40),
                color: Colors.white,
                child: Column(
                  children: [
                    // Header(),
                    //Header(),

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

                    Stack(
                      children: [
                        AnimatedContainer(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          transform:
                              Matrix4.translationValues(xOffset, yOffset, 1.0),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                  child: Container(
                                    color: ColorSelect.east_grey,
                                    height: 30,
                                    child: Center(
                                        child: Text(
                                      " DPM AGREEMENT",
                                      style: TextStyle(
                                          fontFamily: 'Fruitiger',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: ColorSelect.east_blue),
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'dated',
                                          style: TextController.BodyText,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "THURSDAY SEPTEMBER 8, 2022",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "by",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "BARQ ALTAMMAYUZ INVESTMENT COMPANY",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "and",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "East Bridge Capital",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            "TABLE OF CONTENTS",
                                            style:
                                                TextController.BodyHeadingText,
                                          ),
                                        ),
                                        Center(
                                          child: Card(
                                            child: Container(
                                              //alignment: Alignment.center,
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "1. DEFINITIONS AND INTERPRETATION",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "2. APPOINTMENT",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "3. DUTIES OF THE ADVISOR",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "4. DUTIES OF THE  CLIENT",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "5. FEES AND EXPENSES",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "6. REPRESENTATIONS AND WARRANTIES",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "7. PROVISION OF INFORMATION AND DOCUMENTATION",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "8. CONFIDENTIAL INFORMATION",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "9. DATA PROTECTION",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "10. INDEMNIFICATION OF THE ADVISOR",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "11. FORCE MAJEURE",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "12. CONFLICT OF INTEREST",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "13. INTELLECTUAL PROPERTY AND COPYRIGHTS",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "14. EXTERNAL ADVISORY ",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "15. TERM",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "16. TERMINATION",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "17. NOTICES ",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "18. GOVERNING LAW AND DISPUTE SETTLEMENT",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "19. GENERAL TERMS",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "APPENDIX I : DUTIES ",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Text(
                                                      "APPENDIX II : FEES ",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 800,
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
                                                    fontSize: FontSize.medium),
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
                                                  content: StatefulBuilder(
                                                      builder:
                                                          (BuildContext context,
                                                              StateSetter
                                                                  setState) {
                                                    return Container(
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
                                                          // Container(
                                                          //   width: 300,
                                                          //   height: 35,
                                                          //   decoration: BoxDecoration(
                                                          //       color: Colors.white,
                                                          //       border: Border.all(
                                                          //           color: ColorSelect.textField)),
                                                          //   child: TextFormField(
                                                          //     onChanged: (value) {
                                                          //       setState(() {
                                                          //         valueText = value;
                                                          //       });
                                                          //     },
                                                          //     controller: tempName,
                                                          //     textAlignVertical:
                                                          //         TextAlignVertical.center,
                                                          //     style: TextController.BodyHeadingText,
                                                          //     decoration: InputDecoration(
                                                          //         isDense: true,
                                                          //         hintText: S.of(context).TypeHere,
                                                          //         hintStyle:
                                                          //             TextController.labelText,
                                                          //         border: InputBorder.none),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    );
                                                  }),
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
                                                          S.of(context).Cancel,
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

                                                          if (tempName.text !=
                                                              "") {
                                                            senddata();
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Please enter agreement name",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    3,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          }
                                                        },
                                                        child: Text(
                                                          S.of(context).OK,
                                                          style: TextController
                                                              .btnText,
                                                        ),
                                                      ),
                                                    ),
                                                    // MaterialButton(
                                                    //   color: Colors.red,
                                                    //   textColor: Colors.white,
                                                    //   child: const Text('CANCEL'),
                                                    //   onPressed: () {
                                                    //     setState(() {
                                                    //       Navigator.pop(context);
                                                    //     });
                                                    //   },
                                                    // ),
                                                    // MaterialButton(
                                                    //   color: Colors.green,
                                                    //   textColor: Colors.white,
                                                    //   child: const Text('OK'),
                                                    //   onPressed: () {
                                                    //     setState(() {
                                                    //       codeDialog = valueText;
                                                    //       senddata();

                                                    //       Navigator.pop(context);

                                                    //       Navigator.of(context).push(
                                                    //           MaterialPageRoute(
                                                    //               builder: (context) =>
                                                    //                   new CustomerFundAgreement()));
                                                    //     });
                                                    //   },
                                                    // ),
                                                  ],
                                                );
                                              });

                                          //customerGetAgreement.id.value=id;
                                        },
                                        child: Text("Save"),
                                        style: ElevatedButton.styleFrom(
                                          primary: ColorSelect
                                              .east_blue, // Set the desired background color
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                0), // Set border radius to 0
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
                        if (sidebarVisible) SideBar() else Container(),
                      ],
                    ),
                  ],
                ),
              ),
              Navigation()
            ],
          ),
        ),
      ),
    );
  }
}
