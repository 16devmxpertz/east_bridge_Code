import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utility/Drawer.dart';
import '../utility/SideMenuBar.dart';

//import 'package:todo/Colors.dart';

class FundAgreement extends StatefulWidget {
  @override
  FundAgreementState createState() => FundAgreementState();
}

class FundAgreementState extends State<FundAgreement> {
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

  List<String> todoItemsenglish = [
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
  List<String> finalitems = [];

  List<String> todoItemsarbic = [];

  int? editIndex; // Updated type to int?

  @override
  void initState() {
    super.initState();
    chagetoenglish();
    //loadTodoItemsarabic();
    loadTodoItems();
  }

  void loadTodoItemsarabic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse(
          'http://8.213.23.26:8081/apicore/api/TandCDynamic/DefaultTandCGet'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.body);
      print("Successful");
      print(responseData.length);
      for (int i = 0; i < responseData.length; i++) {
        todoItemsarbic.add(responseData[i]);
      }
      prefs.setStringList('todoItemsarabic', todoItemsarbic);
      prefs.setStringList('final', todoItemsarbic);

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
    });
  }

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

      prefs.setStringList('todoItemsenglish', todoItemsenglish);
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

      prefs.setStringList("final", finalitems); // Save the updated list
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
    controller.setText(prefs.getStringList("final")?[index] ?? '');
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
                      initialText: prefs.getStringList("final")?[index] ?? ''),
                ),
                TextButton(
                  onPressed: () async {
                    final newItem = await controller.getText();
                    if (newItem.isNotEmpty) {
                      finalitems[index] = newItem;
                      prefs.setStringList("final", finalitems);
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
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
                                          style: TextController.ControllerText,
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
                                          style: TextController.ControllerText,
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
                                          style: TextController.ControllerText,
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
                                          style: TextController.ControllerText,
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
                                          style: TextController.ControllerText,
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
                                          style: TextController.ControllerText,
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
                                          style: TextController.ControllerText,
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

                  SingleChildScrollView(
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          width: MediaQuery.of(context).size.width,
                          height: 2000,
                          transform:
                              Matrix4.translationValues(xOffset, yOffset, 1.0),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: Column(
                            children: [
                              Card(
                                child: Container(
                                  color: ColorSelect.east_grey,
                                  child: Center(
                                      child: Text(
                                    "Fund",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: ColorSelect.east_blue),
                                  )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            "THIS FINANCIAL ADVISORY AGREEMENT (hereinafter referred to as the “Agreement”) is executed on the 8 day of September 2022 (the “Effective Date”)"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text("By and Between"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            "1.  Barq Altamayyuz Investment Company, a Saudi Limited Liability Company, registered under Commercial Registration number 1010692526 having its registered office at Riyadh, Saudi Arabia (hereinafter referred to as the “Client”);"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text("And"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            "2. Middle East Bridge Investment Company, a Saudi Closed Joint Stock Company registered under Commercial Registration number 1010774060 having its registered office is at Hittin District, Riyadh, Saudi Arabia (hereinafter referred to as the “Advisor”). "),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            "3. Each of the Client and Advisor are hereinafter jointly referred to as the “Parties” and individually as the “Party”."),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text("RECITALS"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            "A. WHEREAS the Client is an investment holding company based in Saudi Arabia;"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            "B. WHEREAS the Client has engaged the Advisor to provide it with financial advisory services relating to the investment in a Saudi digital bank named D360 based in Riyadh;"),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                            "C. WHEREAS the Advisor has the knowledge and capabilities to provide financial advisory services."),
                                      ),
                                      Card(
                                        child: Container(
                                          width: 1450,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text(
                                                  "Legal Entity Client",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text("Name"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text("Type"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child:
                                                    Text("Commercial Register"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text("Address"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text("P.O Box"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text("Postal Code"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child:
                                                    Text("Contact Information"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text("E-Mail"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text(
                                                    "ID Details of the legal Proxy / representative or acting on behalf of Legal Entity Client"),
                                              ),
                                              Card(
                                                child: Container(),
                                              )
                                            ],
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
                                                              await controller
                                                                  .getText();
                                                          if (newItem
                                                              .isNotEmpty) {
                                                            if (editIndex !=
                                                                null) {
                                                              // Update existing item
                                                              addTodoItem(
                                                                  newItem);
                                                            } else {
                                                              // Add new item
                                                              addTodoItem(
                                                                  newItem);
                                                            }
                                                            clearEdit(); // Clear the edit state
                                                            Navigator.pop(
                                                                context); // Close the AlertDialog
                                                          }
                                                        },
                                                        child: Text(
                                                            editIndex != null
                                                                ? 'Upda te Todo'
                                                                : 'Add Todo'),
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
                                        // senddata();
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
                        if (sidebarVisible) SideBar() else Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Navigation(),
          ],
        ),
      ),
    );
  }
}
