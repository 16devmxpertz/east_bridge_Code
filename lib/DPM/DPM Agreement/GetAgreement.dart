import 'package:dio/dio.dart';
import 'package:east_bridge/DPM/Buy.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/CustomerDPMAgreement.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/CustomerFundAgreement.dart';
import 'package:east_bridge/FundAgreement/FundAgreement.dart';
import 'package:east_bridge/Global.dart';
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

//import 'package:todo/Colors.dart';

class GetAgreement extends StatefulWidget {
  GetAgreement(@required String x) {
    Id = int.parse(x);
  }

  @override
  _GetAgreementState createState() => _GetAgreementState();
  static ValueNotifier<int> clientId = ValueNotifier(0);

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

int Id = 0;

class _GetAgreementState extends State<GetAgreement> {
  final HtmlEditorController controller = HtmlEditorController();

  List<String> todoItemsenglish = [];
  List<String> finalitems = [];

  List<String> todoItemsarbic = [];

  int? editIndex;
  Map map = {};
  List<dynamic> li = [];
  List key = []; // Updated type to int?

  @override
  void initState() {
    super.initState();

    customerData();
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
    print(
        'https://localhost:44323/api/GetDPMAgreements/GetDPMAgreements?AgreementId=${Id}');
    final response = await http.get(
      Uri.parse(
          'https://eastbridge.online/apicore/api/GetDPMAgreements/GetDPMAgreements?AgreementId=${Id}'),
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      todoItemsenglish = [
        '<b>1. DFSDFSDRDEFINITIONS AND INTERPRETATION</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)<p>',
        '<b>2. APPOINTMENT</b> <br> <p><br> <p>مشغل الصندوق وأمين الحفظ: شركة البالد املالية<p>',
        '<b>3. DUTIES OF THE ADVISOR</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)<p>',
        '<b>4. DUTIES OF THE CLIENT</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)<p>',
        '<b>5. DUTIES OF THE ADVISOR</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)<p>',
        '<b>6. 5.FEES AND EXPENSES</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)<p>',
        '<b>7. DUTIES OF THE ADVISOR</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)<p>',
        '<b>8. REPRESENTATIONS AND WARRANTIES</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)<p>',
        '<b>9. PROVISION OF INFORMATION AND DOCUMENTATION</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)<p>',
        '<b>10.CONFIDENTIAL INFORMATION</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)<p>',
        '<b>11.DATA PROTECTION</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)</p>',
        '<b>12. TERM AND TERMINATION</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)</p>',
        '<b>13. GOVERNING LAW AND JURISDICTION</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)</p>',
        '<b>14. FORCE MAJEURE</b> <br> <p>THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8" day of September 2022 (the “Effective Date”)</p>',
      ];

      prefs.setStringList('todoItemsfinal', todoItemsenglish);
    });
  }

  void addTodoItem(String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (editIndex != null) {
        // Editing existing item
        finalitems[editIndex!] = item;
        editIndex = null;
      } else {
        // Adding new item
        finalitems.add(item);
      }

      prefs.setStringList(
          "todoItemsfinal", finalitems); // Save the updated list
      print(finalitems);
      print("fgfdgfd=======");
      print(todoItemsarbic);
    });
  }

  void chagetoenglish() {
    print("----Hii");
    print(finalitems);
    setState(() {
      finalitems = todoItemsenglish;
    });
    print(finalitems);
  }

  void changetoarabic() {
    print("----Hii habibi");
    print(finalitems);
    setState(() {
      finalitems = todoItemsarbic;
    });
    print(finalitems);
  }

  void clearEdit() {
    setState(() {
      editIndex = null;
      controller.setText('');
    });
  }

  void startEdit(int index) async {
    editIndex = index;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    controller.setText(prefs.getStringList("todoItemsfinal")?[index] ?? '');
    controller.setText(finalitems[index]);
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
                      initialText:
                          prefs.getStringList("todoItems")?[index] ?? ''),
                ),
                TextButton(
                  onPressed: () async {
                    final newItem = await controller.getText();
                    if (newItem.isNotEmpty) {
                      finalitems[index] = newItem;
                      prefs.setStringList("todoItemsfinal", finalitems);
                      clearEdit(); // Clear the edit state
                      Navigator.pop(context); // Close the AlertDialog
                    }
                  },
                  child: Text(editIndex != null ? 'Update Todo' : 'Add Todo'),
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
      "ClientId": GetAgreement.clientId.value,
      "EmployeeId": GlobalPermission.employeeId,
      "AgreementName": codeDialog,
      "AgreementData": finalitems,
    };

    print(data);

    final response = await http.post(
      Uri.parse(
          'https://eastbridge.online/apicore/api/DPMagreements/LinkAgreementToCostumer/'),
      headers: headers,
      body: jsonEncode(data),
    );

    print("________________");

    if (response.statusCode == 200) {
      // Request successful, handle the response
      // var responseData = jsonDecode(response.toString());
      // id = int.parse(response.toString());
      // print("Successful");
      Fluttertoast.showToast(
          msg: "Agreement Saved Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => DPMBuy()));
      // Process the responseData
    } else {
      // Request failed, handle the error
      print("Request failed with status code: ${response.body}");
      // print("Response data: ${response.data}");
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
  }

  void customerData() async {
    print("Shah");
    final response = await http.get(Uri.parse(
        'https://eastbridge.online/api/GetClientDataForAgreement?id=${GetAgreement.clientId.value}'));

    print("Shah1");

    if (response.statusCode == 200) {
      print("Shah2");
      final json = response.body;
      //print(json.decode(response.body));
      setState(() {
        map = jsonDecode(json);
      });

      // title=json.decode(response.body);
      li = map.values.toList();
      key = map.keys.toList();
      print(li);
      print("Shah3");
    } else {
      print("ShahError");
      throw Exception('Failed to fetch data');
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
                                      " DPM SERVICES AGREEMENT",
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
                                        // SizedBox(
                                        //   height: 20,
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(10),
                                        //   child: Text(
                                        //     "Client Name :   ${li[1]}  ",
                                        //     style: TextController.BodyText,
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(10),
                                        //   child: Text(
                                        //     "Address  :    ${li[2]} ",
                                        //     style: TextController.BodyText,
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(10),
                                        //   child: Text(
                                        //     "Mobile No. :  ${li[3]}  ",
                                        //     style: TextController.BodyText,
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(10),
                                        //   child: Text(
                                        //     "Email    :   ${li[4]}  ",
                                        //     style: TextController.BodyText,
                                        //   ),
                                        // ),
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
                                                    fontSize: FontSize.medium),
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        height: 35,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect
                                                    .tabBorderColor)),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CustomerDPMAgreement()));
                                          }, // Switch tabs
                                          child: Text(
                                            S.of(context).Back,
                                            style: TextController.SideMenuText,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 50, horizontal: 40),
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
                                                          style: TextController
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
                                                                  isDense: true,
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
                                                        onPressed: () {
                                                          if (tempName.text !=
                                                              "") {
                                                            setState(() {
                                                              codeDialog =
                                                                  valueText;
                                                              senddata();

                                                              Navigator.pop(
                                                                  context);
                                                            });
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
