import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MasterMain extends StatefulWidget {
  const MasterMain({super.key});

  @override
  State<MasterMain> createState() => _MasterMainState();
}

class _MasterMainState extends State<MasterMain> {
  bool ifAddnew = false;
  String master = "";
  String masterCatogory = "";
  String masterArabic = "";
  String masterArabicCatogory = "";

  String item = "";
  late Map<String, dynamic> permission = {};
  TextEditingController newItem = new TextEditingController();
  TextEditingController newItemArabic = new TextEditingController();

  TextEditingController masterNewnameEnglish = new TextEditingController();
  TextEditingController masterNewnameArabic = new TextEditingController();
  TextEditingController masterNewnameEnglishCatogory =
      new TextEditingController();
  TextEditingController masterNewnameArabicCatogory =
      new TextEditingController();

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
  void initState() {
    super.initState();
    getDropdownListCatogory('English');
    // getDropdownListCatogory('Arabic');
  }

  void deleteItem(int index) {
    setState(() {
      itemList.removeAt(index);
      itemListArabic.removeAt(index);
    });
  }

  void updateItem(int index, String newText, String newTextArabic) {
    setState(() {
      itemList[index] = newText;
      itemListArabic[index] =
          newTextArabic; // Update the list with the new text
      // Update the list with the new text
    });
  }

  List<dynamic> masterList = [];
  List<dynamic> masterListCatogory = [];
  List<dynamic> masterListArabic = [];
  List<dynamic> masterListCatogoryArabic = [];

  List<dynamic> itemList = [];
  List<dynamic> itemListArabic = [];

  List keys = [];
  List keysCatogory = [];

  List values = [];
  List valuesCatogory = [];
  Map valuesMap = {};
  Map valuesMapCatogory = {};
  Map dropdownvaluesMap = {};
  List keys2 = [];

  List values2 = [];
  String categoryEnglish = "FUND";

  String getCorrespondingArabicValue(String englishValue,
      List<dynamic> englishList, List<dynamic> arabicList) {
    // Find the index of the selected English value in the English list
    int index = englishList.indexOf(englishValue);

    if (index != -1 && index < arabicList.length) {
      // If the index is valid and within the bounds of the Arabic list
      return arabicList[index];
    } else {
      return ''; // Return an empty string if not found or out of bounds
    }
  }

  String getCorrespondingEnglishValue(
      String arabicValue, List<dynamic> englishList, List<dynamic> arabicList) {
    // Find the index of the selected Arabic value in the Arabic list
    int index = arabicList.indexOf(arabicValue);

    if (index != -1 && index < englishList.length) {
      // If the index is valid and within the bounds of the English list
      return englishList[index];
    } else {
      return ''; // Return an empty string if not found or out of bounds
    }
  }

  // List dropdownEnglish = [];

  void getDropdownListCatogory(String type) async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/DropDownItems1/getDropdownMap?type=${type}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("Catogory printing");
        getDropdownList(categoryEnglish);
        var responseData = jsonDecode(response.body);
        setState(() {
          valuesMapCatogory = jsonDecode(response.body);
          valuesCatogory = valuesMapCatogory.keys.toList();
        });

        print(responseData);
        print(masterList);
        print(valuesMapCatogory.keys.toList());
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getDropdownList(String catogory) async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/DropDownItems1/getDropdownlist?CategoryEnglish=${catogory}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("----------done");
        var responseData = jsonDecode(response.body);
        valuesMap = jsonDecode(response.body);
        print(valuesMap);
        setState(() {
          keys = valuesMap.keys.toList();
          print(keys);

          values = valuesMap.values.toList();
          masterList.clear();
          masterListArabic.clear();

          print(values);
          if (values.length > 2) {
            List<dynamic> newlist = values[4];
            List<dynamic> newlist2 = values[5];

            masterList.addAll(newlist);
            masterListArabic.addAll(newlist2);
          }
        });
        print(responseData);
        print(masterList);

        print(responseData);
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getDropdownValues(String name, String categoryEnglish) async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/DropDownItems1/getDropdownvalues?name=${name}&CategoryEnglish=${categoryEnglish}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("----------done");
        var responseData = jsonDecode(response.body);
        dropdownvaluesMap = jsonDecode(response.body);
        print(valuesMap);
        setState(() {
          keys2 = dropdownvaluesMap.keys.toList();

          values2 = dropdownvaluesMap.values.toList();
          itemList.clear();
          itemListArabic.clear();

          if (values2.length > 2) {
            List<dynamic> newlist = values2[4];
            List<dynamic> newlistArabic = values2[5];

            itemList.addAll(newlist);
            itemListArabic.addAll(newlistArabic);
          }
        });
        print(responseData);
        print(masterList);

        print(responseData);
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List newitemList = [];
  void putdata() async {
    for (int i = 0; i < itemList.length; i++) {
      setState(() {
        itemList[i] = itemList[i];
      });
    }
    print(itemList);
    var url =
        Uri.parse('${GlobalPermission.urlLink}/api/DropDownItems1/SetDropdown');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "categoryEnglish": masterNewnameEnglishCatogory.text,
        "categoryArabic": "string",
        "oldKey": master,
        "oldKeyArabic": masterArabic,
        "newKey": masterNewnameEnglish.text,
        "newKeyArabic": masterNewnameArabic.text,
        "listEnglish": itemList,
        "listArabic": itemListArabic
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));
      print(body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Successfully Added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MasterMain(),
          ),
        );
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
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void postdata() async {
    print(itemList);
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/DropDownItems1/InsertNewDropdown');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "categoryEnglish": "new category",
        "categoryArabic": "string",
        "newKey": "new master",
        "newKeyArabic": "جديد",
        "listEnglish": ["item1"],
        "listArabic": ["item1"]
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      print(body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Added into master list by name new",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MasterMain(),
          ),
        );
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
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void addNewItem() {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          child: AlertDialog(
            title: Text(
              S.of(context).AddNew,
              style: TextController.BodyHeadingText,
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 450,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorSelect.textField),
                        ),
                        child: TextFormField(
                          controller: newItem,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextController.BodyHeadingText,
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: S.of(context).TypeHere + "(in English)",
                              hintStyle: TextController.labelText,
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: 450,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorSelect.textField),
                        ),
                        child: TextFormField(
                          controller: newItemArabic,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextController.BodyHeadingText,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[\u0600-\u06FF\s]')),
                          ],
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: S.of(context).TypeHere + "(in Arabic)",
                              hintStyle: TextController.labelText,
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 30,
                    color: ColorSelect.east_blue,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0xFFC9BBBB),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.of(context).Cancel,
                        style: TextController.btnText,
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    color: ColorSelect.east_blue,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0xFFC9BBBB),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          itemList.add(newItem.text);
                          itemListArabic.add(newItemArabic.text);
                          newItem.text = "";
                          newItemArabic.text = "";
                        });
                        print(itemList);
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.of(context).Save,
                        style: TextController.btnText,
                      ),
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
          constraints: const BoxConstraints(),
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
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (context) =>
                                        //       CorporateKYC(""),
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
                                        //   builder: (context) =>
                                        //       KYCPdfUploadIND(),
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
                                // download
                                if (permission['Download'] == true)
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
                                        //   builder: (context) =>
                                        //       KYCPdfUploadIND(),
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
                                    onPressed: () {
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) =>
                                      //       CorporateDraftList(),
                                      // ));
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
                      ), // HEADER END

                      Stack(
                        children: [
                          AnimatedContainer(
                            transform: Matrix4.translationValues(
                                xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorSelect.tabBorderColor,
                                        width: 0.5,
                                      ),
                                      color: Color(0xFFF6F7FB),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            S.of(context).Master,
                                            style:
                                                TextController.MainHeadingText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    // margin: EdgeInsets.symmetric(vertical: 20),
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorSelect.tabBorderColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Master Catogory",
                                          style: TextController.BodyText,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              width: 300,
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .textField)),
                                              child: DropdownButton<String>(
                                                hint: Text("Select Here",
                                                    style: TextController
                                                        .labelText),
                                                value: masterCatogory.isNotEmpty
                                                    ? masterCatogory
                                                    : null,
                                                isExpanded: true,
                                                underline: Container(),
                                                iconEnabledColor:
                                                    ColorSelect.east_dark_blue,
                                                items: valuesCatogory.map<
                                                    DropdownMenuItem<String>>(
                                                  (dynamic item) {
                                                    return DropdownMenuItem(
                                                      value: item.toString(),
                                                      child: Text(
                                                        item.toString(),
                                                        style: TextController
                                                            .BodyText,
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                                onChanged: (NewValue) {
                                                  setState(
                                                    () {
                                                      masterCatogory =
                                                          NewValue!;
                                                      masterNewnameEnglishCatogory
                                                              .text =
                                                          masterCatogory;
                                                      getDropdownList(
                                                          masterCatogory);
                                                      print(masterCatogory);
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            if (masterCatogory != "")
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                width: 300,
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField)),
                                                child: TextFormField(
                                                  controller:
                                                      masterNewnameEnglishCatogory,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        S.of(context).TypeHere,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    errorStyle: TextController
                                                        .errorText,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        // Column(
                                        //   children: [
                                        //     // Container(
                                        //     //   padding: EdgeInsets.symmetric(
                                        //     //       horizontal: 10),
                                        //     //   width: 300,
                                        //     //   height: 35,
                                        //     //   alignment: Alignment.centerLeft,
                                        //     //   decoration: BoxDecoration(
                                        //     //       color: Colors.white,
                                        //     //       border: Border.all(
                                        //     //           color: ColorSelect
                                        //     //               .textField)),
                                        //     //   child: DropdownButton<String>(
                                        //     //     hint: Text("Select Here",
                                        //     //         style: TextController
                                        //     //             .labelText),
                                        //     //     value: masterArabicCatogory
                                        //     //             .isNotEmpty
                                        //     //         ? masterArabicCatogory
                                        //     //         : null,
                                        //     //     isExpanded: true,
                                        //     //     underline: Container(),
                                        //     //     iconEnabledColor:
                                        //     //         ColorSelect.east_dark_blue,
                                        //     //     items: masterListCatogoryArabic
                                        //     //         .map<
                                        //     //             DropdownMenuItem<
                                        //     //                 String>>(
                                        //     //       (dynamic item) {
                                        //     //         return DropdownMenuItem(
                                        //     //           value: item.toString(),
                                        //     //           child: Text(
                                        //     //             item.toString(),
                                        //     //             style: TextController
                                        //     //                 .BodyText,
                                        //     //           ),
                                        //     //         );
                                        //     //       },
                                        //     //     ).toList(),
                                        //     //     onChanged: (NewValue) {
                                        //     //       setState(
                                        //     //         () {
                                        //     //           masterArabicCatogory =
                                        //     //               NewValue!;
                                        //     //           masterCatogory =
                                        //     //               getCorrespondingEnglishValue(
                                        //     //                   masterArabicCatogory,
                                        //     //                   masterListCatogory,
                                        //     //                   masterListCatogoryArabic);
                                        //     //           masterNewnameArabicCatogory
                                        //     //                   .text =
                                        //     //               masterArabicCatogory;
                                        //     //           masterNewnameEnglishCatogory
                                        //     //                   .text =
                                        //     //               masterCatogory;
                                        //     //           getDropdownList(
                                        //     //               masterCatogory);
                                        //     //         },
                                        //     //       );
                                        //     //     },
                                        //     //   ),
                                        //     // ),
                                        //     SizedBox(
                                        //       height: 20,
                                        //     ),
                                        //     if (masterArabic != "")
                                        //       Container(
                                        //         padding: EdgeInsets.symmetric(
                                        //             horizontal: 10),
                                        //         width: 300,
                                        //         height: 35,
                                        //         alignment: Alignment.centerLeft,
                                        //         decoration: BoxDecoration(
                                        //             color: Colors.white,
                                        //             border: Border.all(
                                        //                 color: ColorSelect
                                        //                     .textField)),
                                        //         child: TextFormField(
                                        //           controller:
                                        //               masterNewnameArabic,
                                        //           textAlignVertical:
                                        //               TextAlignVertical.center,
                                        //           style:
                                        //               TextController.BodyText,
                                        //           decoration: InputDecoration(
                                        //             isDense: true,
                                        //             hintText:
                                        //                 S.of(context).TypeHere,
                                        //             hintStyle: TextController
                                        //                 .labelText,
                                        //             border: InputBorder.none,
                                        //             errorStyle: TextController
                                        //                 .errorText,
                                        //           ),
                                        //         ),
                                        //       ),
                                        //   ],
                                        // ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          height: 35,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: ColorSelect.east_blue,
                                              border: Border.all(
                                                  color: ColorSelect
                                                      .tabBorderColor)),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      ColorSelect.east_blue),
                                            ),
                                            onPressed: () {
                                              if (!(masterList.contains(
                                                      "new master")) &&
                                                  !(masterListArabic
                                                      .contains("جديد"))) {
                                                postdata();
                                              } else if (!(masterListCatogory
                                                  .contains("new category"))) {
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "New Already Added",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 3,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                            }, // Switch tabs
                                            child: Text(
                                              "Add New Master",
                                              style: TextController.btnText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    // margin: EdgeInsets.symmetric(vertical: 20),
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorSelect.tabBorderColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Master List",
                                          style: TextController.BodyText,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                width: 300,
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField)),
                                                child: DropdownButton<String>(
                                                  hint: Text("Select Here",
                                                      style: TextController
                                                          .labelText),
                                                  value: masterList
                                                          .contains(master)
                                                      ? master
                                                      : null, // Check if master is in masterList
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor: ColorSelect
                                                      .east_dark_blue,
                                                  items: masterList.map<
                                                      DropdownMenuItem<String>>(
                                                    (dynamic item) {
                                                      return DropdownMenuItem(
                                                        value: item.toString(),
                                                        child: Text(
                                                          item.toString(),
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (NewValue) {
                                                    setState(
                                                      () {
                                                        master = NewValue!;
                                                        masterArabic =
                                                            getCorrespondingArabicValue(
                                                                master,
                                                                masterList,
                                                                masterListArabic);
                                                        masterNewnameEnglish
                                                            .text = master;
                                                        masterNewnameArabic
                                                                .text =
                                                            masterArabic;
                                                        getDropdownValues(
                                                            master,
                                                            masterCatogory);
                                                      },
                                                    );
                                                  },
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            if (master != "")
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                width: 300,
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField)),
                                                child: TextFormField(
                                                  controller:
                                                      masterNewnameEnglish,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        S.of(context).TypeHere,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    errorStyle: TextController
                                                        .errorText,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                width: 300,
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField)),
                                                child: DropdownButton<String>(
                                                  hint: Text("Select Here",
                                                      style: TextController
                                                          .labelText),
                                                  value: masterListArabic
                                                          .contains(
                                                              masterArabic)
                                                      ? masterArabic
                                                      : null, // Check if masterArabic is in masterListArabic
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor: ColorSelect
                                                      .east_dark_blue,
                                                  items: masterListArabic.map<
                                                      DropdownMenuItem<String>>(
                                                    (dynamic item) {
                                                      return DropdownMenuItem(
                                                        value: item.toString(),
                                                        child: Text(
                                                          item.toString(),
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (NewValue) {
                                                    setState(
                                                      () {
                                                        masterArabic =
                                                            NewValue!;
                                                        master =
                                                            getCorrespondingEnglishValue(
                                                                masterArabic,
                                                                masterList,
                                                                masterListArabic);
                                                        masterNewnameArabic
                                                                .text =
                                                            masterArabic;
                                                        masterNewnameEnglish
                                                            .text = master;
                                                        getDropdownValues(
                                                            master,
                                                            masterCatogory);
                                                      },
                                                    );
                                                  },
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            if (masterArabic != "")
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                width: 300,
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField)),
                                                child: TextFormField(
                                                  controller:
                                                      masterNewnameArabic,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        S.of(context).TypeHere,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    errorStyle: TextController
                                                        .errorText,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        // Container(
                                        //   height: 35,
                                        //   width: 150,
                                        //   decoration: BoxDecoration(
                                        //       color: ColorSelect.east_blue,
                                        //       border: Border.all(
                                        //           color: ColorSelect
                                        //               .tabBorderColor)),
                                        //   child: ElevatedButton(
                                        //     style: ButtonStyle(
                                        //       backgroundColor:
                                        //           MaterialStatePropertyAll(
                                        //               ColorSelect.east_blue),
                                        //     ),
                                        //     onPressed: () {
                                        //       if (!(masterList
                                        //               .contains("new")) &&
                                        //           !(masterListArabic
                                        //               .contains("جديد"))) {
                                        //         postdata();
                                        //       } else {
                                        //         Fluttertoast.showToast(
                                        //             msg: "New Already Added",
                                        //             toastLength:
                                        //                 Toast.LENGTH_SHORT,
                                        //             gravity:
                                        //                 ToastGravity.CENTER,
                                        //             timeInSecForIosWeb: 3,
                                        //             backgroundColor: Colors.red,
                                        //             textColor: Colors.white,
                                        //             fontSize: 16.0);
                                        //       }
                                        //     }, // Switch tabs
                                        //     child: Text(
                                        //       "Add New Master",
                                        //       style: TextController.btnText,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 1,
                                          color: ColorSelect.tabBorderColor),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 30),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 20),
                                                        child: Text(
                                                          "Dropdown List",
                                                          style: TextController
                                                              .BodyHeadingText,
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        width: 600,
                                                        child: Table(
                                                          border: TableBorder.all(
                                                              color: ColorSelect
                                                                  .tabBorderColor),
                                                          defaultVerticalAlignment:
                                                              TableCellVerticalAlignment
                                                                  .middle,
                                                          columnWidths: {
                                                            0: FlexColumnWidth(
                                                                3),
                                                            1: FlexColumnWidth(
                                                                3),
                                                            2: FlexColumnWidth(
                                                                1),
                                                          },
                                                          children: [
                                                            TableRow(
                                                              decoration: BoxDecoration(
                                                                  color: ColorSelect
                                                                      .east_grey),
                                                              children: [
                                                                Container(
                                                                  height: 50,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              10),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "Items (in English)",
                                                                    style:
                                                                        TextController
                                                                            .InvA,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 50,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              10),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "Items (in Arabic)",
                                                                    style:
                                                                        TextController
                                                                            .InvA,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 50,
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              10),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    "Delete",
                                                                    style:
                                                                        TextController
                                                                            .InvA,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SingleChildScrollView(
                                                        child: Container(
                                                          // height: 300,
                                                          child:
                                                              ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                itemList.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return table(
                                                                  TextEditingController(
                                                                      text: itemList[
                                                                          index]),
                                                                  TextEditingController(
                                                                      text: itemListArabic[
                                                                          index]),
                                                                  index,
                                                                  context);
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (ifAddnew)
                                                Flexible(
                                                  // flex: 2,
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    width: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                S.of(context).Edit +
                                                                    " Item",
                                                                style: TextController
                                                                    .SubHeadingText,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Flexible(
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            "Add New",
                                                                            style:
                                                                                TextController.BodyText,
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15,
                                                                          ),
                                                                          Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 10),
                                                                            width:
                                                                                280,
                                                                            height:
                                                                                35,
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Colors.white,
                                                                              border: Border.all(color: ColorSelect.textField),
                                                                            ),
                                                                            child:
                                                                                TextFormField(
                                                                              // controller: newItem,
                                                                              style: TextController.BodyText,
                                                                              decoration: InputDecoration(isDense: true, hintText: S.of(context).TypeHere, hintStyle: TextController.labelText, border: InputBorder.none),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            // margin: EdgeInsets.symmetric(
                                            //     vertical: 20),
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 35,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                  color: ColorSelect.east_blue,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .tabBorderColor)),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          ColorSelect
                                                              .east_blue),
                                                ),
                                                onPressed: () {
                                                  addNewItem();
                                                }, // Switch tabs
                                                child: Text(
                                                  S.of(context).AddNew,
                                                  style: TextController.btnText,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Container(
                                              height: 35,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                  color: ColorSelect.east_blue,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .tabBorderColor)),
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          ColorSelect
                                                              .east_blue),
                                                ),
                                                onPressed: () {
                                                  putdata();
                                                }, // Switch tabs
                                                child: Text(
                                                  S.of(context).Save,
                                                  style: TextController.btnText,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                      ],
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

  Widget table(TextEditingController item, TextEditingController itemArabic,
      int index, BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              width: 600,
              // margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Table(
                border: TableBorder.all(color: ColorSelect.tabBorderColor),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FlexColumnWidth(3),
                  1: FlexColumnWidth(3),
                  2: FlexColumnWidth(1),
                  // 0: FixedColumnWidth(500),
                  // 1: FixedColumnWidth(500)
                },
                children: [
                  TableRow(
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Center(
                          child: TextFormField(
                            controller: item,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: TextController.BodyText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: S.of(context).TypeHere,
                              hintStyle: TextController.labelText,
                              border: InputBorder.none,
                              errorStyle: TextController.errorText,
                            ),
                            onChanged: (value) {
                              itemList[index] = value;
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Center(
                          child: TextFormField(
                            controller: itemArabic,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.center,
                            style: TextController.BodyText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: S.of(context).TypeHere,
                              hintStyle: TextController.labelText,
                              border: InputBorder.none,
                              errorStyle: TextController.errorText,
                            ),
                            onChanged: (value) {
                              itemListArabic[index] = value;
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            deleteItem(index);
                          },
                          icon: Icon(Icons.delete),
                          iconSize: 18,
                          color: ColorSelect.bodytext,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
