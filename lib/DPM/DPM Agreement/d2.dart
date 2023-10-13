import 'package:dio/dio.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/CustomerDPMAgreement.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/CustomerFundAgreement.dart';
import 'package:east_bridge/FundAgreement/FundAgreement.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:east_bridge/Fund Creation/TabOfFundCreation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../utility/Drawer.dart';

//import 'package:todo/Colors.dart';

class DPMTEst extends StatefulWidget {
  @override
  _AdvisoryDefaultdatalanaAgreementorignalState createState() =>
      _AdvisoryDefaultdatalanaAgreementorignalState();

  static ValueNotifier<String> fmaddress = ValueNotifier("");
  static ValueNotifier<int> id = new ValueNotifier(0);
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

class _AdvisoryDefaultdatalanaAgreementorignalState extends State<DPMTEst> {
  final HtmlEditorController controller = HtmlEditorController();

  TextEditingController _TemplateName = new TextEditingController();
  TextEditingController myid = new TextEditingController();

  List<String> finalitems = [];

  int? editIndex; // Updated type to int?

  @override
  void initState() {
    myid.text = DPMTEst.id.value.toString();
    super.initState();
    loadTodoItemsarabic();
  }

  String? valueText;
  String? codeDialog;
  late final id;

  TextEditingController tempName = new TextEditingController();
  void loadTodoItemsarabic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse(
          'https://eastbridge.online/apicore/api/DefaultAgreements/DefaultAgreementGet?type=Advisory'),
      headers: headers,
    );
    List<String> li = [];
    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.body);
      print("Successful");
      for (int i = 0; i < responseData.length; i++) {
        li.add(responseData[i]);
      }

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
      finalitems = li;
    });
  }

  void addTodoItem(String item) async {
    finalitems.add(item);
  }

  void clearEdit() {
    setState(() {
      editIndex = null;
      controller.setText('');
    });
  }

  void UpdateTodo(int index, String item) async {
    finalitems[index] = item;
  }

  var dio = Dio();
  void senddata() async {
    print("data sending");
    var headers = {
      'Content-Type': 'application/json',
    };

    int n = finalitems.length;

    FormData data = FormData.fromMap({
      "EmployeeId": 139,
      "AgreementName": codeDialog,
      "AgreeemntData": finalitems
    });
    var response = await dio.post(
      'https://eastbridge.online/apicore/api/DPMagreements/AddDPMAgreement',
      data: data,
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );
    print(data);
    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.toString());
      id = int.parse(response.toString());
      print("Successful");

      // Process the responseData
    } else {
      // Request failed, handle the error

      print("Error");
      // Display or handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          height: 5000,
          width: 1600,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                          "MIDDLE EAST BRIDGE COMPANY",
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
                          style: TextController.BodyHeadingText,
                        ),
                      ),
                      Center(
                        child: Card(
                          child: Container(
                            //alignment: Alignment.center,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "1. DEFINITIONS AND INTERPRETATION",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "2. APPOINTMENT",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "3. DUTIES OF THE ADVISOR",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "4. DUTIES OF THE  CLIENT",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "5. FEES AND EXPENSES",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "6. REPRESENTATIONS AND WARRANTIES",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "7. PROVISION OF INFORMATION AND DOCUMENTATION",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "8. CONFIDENTIAL INFORMATION",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "9. DATA PROTECTION",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "10. INDEMNIFICATION OF THE ADVISOR",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "11. FORCE MAJEURE",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "12. CONFLICT OF INTEREST",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "13. INTELLECTUAL PROPERTY AND COPYRIGHTS",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "14. EXTERNAL ADVISORY ",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "15. TERM",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "16. TERMINATION",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "17. NOTICES ",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "18. GOVERNING LAW AND DISPUTE SETTLEMENT",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "19. GENERAL TERMS",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "APPENDIX I : DUTIES ",
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "APPENDIX II : FEES ",
                                    style: TextController.BodyText,
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
              Expanded(
                child: ListView.builder(
                  itemCount: finalitems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        child: ListTile(
                          title: Html(
                            data: finalitems[index],
                            style: {
                              'body': Style(fontSize: FontSize.medium),
                            },
                          ),
                          trailing: SizedBox(
                            width: 80,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
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
                                                    htmlEditorOptions:
                                                        HtmlEditorOptions(
                                                            shouldEnsureVisible:
                                                                true,
                                                            initialText:
                                                                finalitems[
                                                                    index])),
                                                TextButton(
                                                  onPressed: () async {
                                                    final newItem =
                                                        await controller
                                                            .getText();
                                                    if (newItem.isNotEmpty) {
                                                      // Update existing item

                                                      UpdateTodo(
                                                          index, newItem);
                                                    }
                                                    clearEdit(); // Clear the edit state
                                                    Navigator.pop(
                                                        context); // Close the AlertDialog
                                                  },
                                                  child: Text('Update Todo'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      finalitems.removeAt(index);
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
                        left: 1100, top: 15, bottom: 15, right: 15),
                    child: Container(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          // ignore: use_build_context_synchronously
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
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          final newItem =
                                              await controller.getText();
                                          if (newItem.isNotEmpty) {
                                            // Update existing item

                                            addTodoItem(newItem);
                                            // clearEdit(); // Clear the edit state
                                          } else {
                                            // Add new item
                                            addTodoItem(newItem);
                                          }
                                          clearEdit();
                                          Navigator.pop(
                                              context); // Close the AlertDialog
                                        },
                                        child: Text('Add Todo'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
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
                                  style: TextController.SubHeadingText,
                                ),
                                content: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).EnterTemplateName,
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Flexible(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 290,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                valueText = value;
                                              });
                                            },
                                            controller: _TemplateName,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style:
                                                TextController.BodyHeadingText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
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
                                            color: ColorSelect.tabBorderColor)),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text(
                                        S.of(context).Cancel,
                                        style: TextController.SideMenuText,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        color: ColorSelect.east_blue,
                                        border: Border.all(
                                            color: ColorSelect.tabBorderColor)),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          codeDialog = valueText;
                                          senddata();

                                          Navigator.pop(context);

                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      new CustomerDPMAgreement()));
                                        });
                                      },
                                      child: Text(
                                        S.of(context).OK,
                                        style: TextController.btnText,
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
    );
  }
}
