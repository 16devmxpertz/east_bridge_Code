import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
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

class Investment extends StatefulWidget {
  @override
  InvestmentState createState() => InvestmentState();
}

class InvestmentState extends State<Investment> {
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

  // Appropriate action depending upon the
  // server response

  void senddata() async {
    print("data sending");
    var headers = {
      'Content-Type': 'application/json',
    };

    int n = finalitems.length;
    var data = {};
    data["ClientId"] = "2";
    for (int i = 1; i <= n; i++) {
      String k = i.toString();
      data[k] = finalitems[i - 1];
    }

    final response = await http.post(
      Uri.parse(
          'http://8.213.23.26:8081/apicore/api/TandCDynamic/DefaultTandCGet'),
      headers: headers,
      body: jsonEncode(data),
    );
    print(data);
    print(response.body);
    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.body);
      print("Successful");
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
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          height: 1600,
          width: 600,
          child: Column(
            children: [
              Container(
                height: 160,
                child: Scaffold(
                  drawer: SideBar(),
                  drawerEnableOpenDragGesture: true,
                  body: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 52, top: 17),
                              child: Image.asset(
                                'images/English-Logo.jpg',
                                width: 196.0,
                                height: 80.0,
                              ),
                            ),
                            // SizedBox(
                            //   width: 400,
                            // ),

                            Container(
                              //width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 42),
                                    child: SizedBox(
                                      width: 232,
                                      height: 34,
                                      child: TextField(
                                        // cursorColor: Colors.black,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 20.0),
                                            hintText: S.of(context).search,
                                            hintStyle: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Frutiger',
                                                color: Color(0xFFB8B1B1)),
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            prefixIconColor: Color(0xFFD9D9D9),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              borderSide: const BorderSide(
                                                  color: Color(0xFFCACACA)),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 46, left: 10, right: 10),
                                    child: Image.asset(
                                      'images/Notification_icon.png',
                                      width: 26,
                                      height: 26,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Container(
                                      width: 105,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(26),
                                          border: Border.all(
                                              color: Color(0xFFDDDDDD))),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Image.asset(
                                              'images/Logout_icon.png',
                                              width: 26,
                                              height: 26,
                                              color: Color(0xFF316A8C),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            S.of(context).Logout,
                                            style: TextStyle(
                                              fontFamily: 'Gotham',
                                              fontSize: 12.0,
                                              color: Color(0xFF565252),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 35),
                                    child: TextButton(
                                      onPressed: () {
                                        chagetoenglish();
                                      },
                                      child: Container(
                                        width: 125,
                                        height: 42,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xFFD7CFCF))),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'images/En_Flag.png',
                                              width: 46,
                                              height: 32,
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "En",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Frutiger',
                                                fontSize: 16.0,
                                                color: Color(0xFF000000),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 35),
                                    child: TextButton(
                                      onPressed: () {
                                        changetoarabic();
                                      },
                                      child: Container(
                                        width: 125,
                                        height: 42,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xFFD7CFCF))),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8),
                                              child: Image.asset(
                                                'images/Ar_Flag.png',
                                                width: 43,
                                                height: 29,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              "Ar",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Frutiger',
                                                fontSize: 16.0,
                                                color: Color(0xFF000000),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      //Controllers

                      Container(
                        width: double.infinity,
                        height: 40,
                        color: ColorSelect.east_blue,
                        child: Stack(
                          children: [
                            Builder(builder: (context) {
                              return InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Container(
                                    width: 90,
                                    height: 44,
                                    child: Center(
                                        child: Icon(
                                      Icons.menu,
                                      size: 20,
                                      color: Colors.white,
                                    ))),
                              );
                            }),

                            //new
                            Padding(
                              padding: const EdgeInsets.only(left: 90),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    width: 90,
                                    height: 44,
                                    //color: ColorSelect.east_blue,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.add_card_rounded,
                                              size: 15,
                                              color: Colors.white,
                                            )),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          S.of(context).New,
                                          style: TextController.ControllerText,
                                        ))
                                      ],
                                    ),
                                  )),
                            ),

                            //edit
                            Padding(
                              padding: const EdgeInsets.only(left: 180),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    width: 90,
                                    height: 44,
                                    //color: ColorSelect.east_blue,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.edit_calendar_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            )
                                            //child: Image.asset("images/Edit_icon.png",width: 10,height: 10,color: Colors.white,),
                                            ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          S.of(context).Edit,
                                          style: TextController.ControllerText,
                                        ))
                                      ],
                                    ),
                                  )),
                            ),

                            //view
                            Padding(
                              padding: const EdgeInsets.only(left: 270),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    width: 90,
                                    height: 44,
                                    //color: ColorSelect.east_blue,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Icon(
                                              Icons.content_paste_search,
                                              size: 15,
                                              color: Colors.white),
                                          //child: Image.asset("images/View_icon.png",width: 12,height: 12,color: Colors.white,),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          S.of(context).View,
                                          style: TextController.ControllerText,
                                        ))
                                      ],
                                    ),
                                  )),
                            ),

                            //cancel
                            Padding(
                              padding: const EdgeInsets.only(left: 360),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    width: 90,
                                    height: 44,
                                    //color: ColorSelect.east_blue,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.free_cancellation_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            )
                                            //child: Image.asset("images/Cancel_icon.png",width: 12,height: 12,color: Colors.white,),
                                            ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          S.of(context).Cancel,
                                          style: TextController.ControllerText,
                                        ))
                                      ],
                                    ),
                                  )),
                            ),

                            //print
                            Padding(
                              padding: const EdgeInsets.only(left: 450),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    width: 90,
                                    height: 44,
                                    //color: ColorSelect.east_blue,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.print,
                                              size: 15,
                                              color: Colors.white,
                                            )
                                            //child: Image.asset("images/Print_icon.png",width: 12,height: 12,color: Colors.white,),
                                            ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          S.of(context).Print,
                                          style: TextController.ControllerText,
                                        ))
                                      ],
                                    ),
                                  )),
                            ),

                            //download
                            Padding(
                              padding: const EdgeInsets.only(left: 540),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    width: 125,
                                    height: 44,
                                    //color: ColorSelect.east_blue,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.download,
                                              size: 15,
                                              color: Colors.white,
                                            )
                                            //child: Image.asset("images/Download_icon.png",width: 12,height: 12,color: Colors.white,),
                                            ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          S.of(context).Download,
                                          style: TextController.ControllerText,
                                        ))
                                      ],
                                    ),
                                  )),
                            ),

                            //saveDraft
                            Padding(
                              padding: const EdgeInsets.only(left: 665),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    width: 125,
                                    height: 44,
                                    //color: ColorSelect.east_blue,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.white)),
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.save_as_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            )
                                            //child: Image.asset("images/SaveDraft_icon.png",width: 12,height: 12,color: Colors.white,),
                                            ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                            child: Text(
                                          S.of(context).SaveDraft,
                                          style: TextController.ControllerText,
                                        ))
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  color: ColorSelect.east_grey,
                  child: Center(
                      child: Text(
                    "Investment",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "Legal Entity Client",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("Name"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("Type"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("Commercial Register"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("Address"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("P.O Box"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("Postal Code"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("Contact Information"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text("E-Mail"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
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
                                    startEdit(index);
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
                                            if (editIndex != null) {
                                              // Update existing item
                                              addTodoItem(newItem);
                                            } else {
                                              // Add new item
                                              addTodoItem(newItem);
                                            }
                                            clearEdit(); // Clear the edit state
                                            Navigator.pop(
                                                context); // Close the AlertDialog
                                          }
                                        },
                                        child: Text(editIndex != null
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
                        senddata();
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
