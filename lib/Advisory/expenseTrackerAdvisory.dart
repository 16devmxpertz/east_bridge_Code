import 'package:east_bridge/Advisory/Advisory%20Subscribe/AdvisorySubscribe.dart';
import 'package:east_bridge/Advisory/AdvisoryManagerforExpenseTracker.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:east_bridge/utility/decimalConverterGlobal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ExpenseTrackerAdvisory extends StatefulWidget {
  const ExpenseTrackerAdvisory({super.key, TabController? controller});

  @override
  State<ExpenseTrackerAdvisory> createState() => _ExpenseTrackerAdvisorysStat();
  static ValueNotifier<int> advisoryId = new ValueNotifier(0);
  static ValueNotifier<String> clientName = new ValueNotifier("");
  static ValueNotifier<int> id = new ValueNotifier(0);
}

class _ExpenseTrackerAdvisorysStat extends State<ExpenseTrackerAdvisory> {
  bool isCustomerSearch = true;

  List li = [];
  List key = [];
  List<bool> isChecked = [];

  Map customers = {};

  @override
  void initState() {
    super.initState();
    setState(() {
      clientName.text = ExpenseTrackerAdvisory.clientName.value;
    });
    FetchServiceList();
    //fetchData();
  }

  List<dynamic> list = [];
  var list1 = ["Please select client first"];

  var keys = [];

  void FetchServiceList() async {
    print("clientid-------------");
    print(ExpenseTrackerAdvisory.id.value);
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ClientAdvisoiryAgreementLink/GetAdvisoryServicesOfClientByClientId?ClientId=${ExpenseTrackerAdvisory.id.value}');

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
      print(responseData);
      fundMap = responseData;

      list = responseData.values.toList();
      keys = responseData.keys.toList();
      list1.clear();
      print(list);
      setState(() {
        for (String i in list) {
          list1.add(i + "");
        }
      });
    } else {
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print("error");
      print(errorMessage);
    }
  }

  // customer search
  TextEditingController expenseName = new TextEditingController();
  TextEditingController expenseAmt = new TextEditingController();
  TextEditingController ExpenseDate = new TextEditingController();
  TextEditingController expenseDescription = new TextEditingController();
  TextEditingController CategoryOther = new TextEditingController();
  TextEditingController clientName = new TextEditingController();
  String? servicesValue;

  List<String> range = [];

  String? ExpenseCatagDropdownvalue;

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

  var ExpenseCatag = [
    "Travel Expenses",
    "Transportation",
    "Meals and Entertainment",
    "Office Supplies",
    "Communication Expenses",
    "Training and Professional Development",
    "Business Meals and Hospitality",
    "Conferences and Events",
    "Subscriptions and Memberships",
    "Business-related Accommodation",
    "Miscellaneous Expenses",
    "Other",
  ];

  var advisoryid;
  var fundMap = {};

  void ExpenseTracker() async {
    try {
    final url = Uri.parse('${GlobalPermission.urlLink}/api/AdvosiryExpenseTracker/AdvosiryExpenseTracker');
    final headers = {
      'Content-Type': 'application/json',
    };

    final selectedService = servicesValue!;
    final advisoryIds = fundMap.entries.where((entry) => entry.value == selectedService).map((entry) => entry.key);

    if (advisoryIds.isNotEmpty) {
      final advisoryId = int.parse(advisoryIds.first);

      final body = {
        "clientId": ExpenseTrackerAdvisory.id.value,
        "advisoryId": advisoryId,
        "expenseName": expenseName.text,
        "expenseCategory": ExpenseCatagDropdownvalue,
        "expenseAmount": int.parse(expenseAmt.text.replaceAll(",", "")),
        "date": ExpenseDate.text,
        "expenseDescription": expenseDescription.text,
      };

      final response = await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Expense Tracker Working");
        Fluttertoast.showToast(
          msg: "Expense has been added.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Please Fill All Details.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "No matching advisory ID found.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (error) {
    Fluttertoast.showToast(
        msg: "Please Fill All Details. \n All Details Are Required.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    // Handle the error as needed.
  }
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
                      Column(
                        children: [
                          // Header Start
                          // Navigation(),
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
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 40,
                                    ),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3,
                                          color: Color.fromRGBO(0, 0, 0, 0.363),
                                        ),
                                      ],
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(
                                                S.of(context).ExpenseTracker,
                                                style: TextController
                                                    .MainHeadingText,
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          AdvisoryManagerSearchforExpenseTracker(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                        width: 1,
                                                        color: ColorSelect
                                                            .tabBorderColor))),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              S
                                                                  .of(context)
                                                                  .ClientName,
                                                              style:
                                                                  TextController
                                                                      .BodyText,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              width: 280,
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
                                                                controller:
                                                                    clientName,
                                                                // readOnly: true,
                                                                textAlignVertical:
                                                                    TextAlignVertical
                                                                        .center,
                                                                onChanged:
                                                                    (value) {
                                                                  print(
                                                                      "ClientNameChangedddd");
                                                                  FetchServiceList();
                                                                },
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
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Flexible(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              S
                                                                  .of(context)
                                                                  .ServiceName,
                                                              style:
                                                                  TextController
                                                                      .BodyText,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Flexible(
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                width: 280,
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
                                                                    DropdownButton(
                                                                  hint: Text(
                                                                      "Select Here",
                                                                      style: TextController
                                                                          .labelText),
                                                                  value:
                                                                      servicesValue,
                                                                  isExpanded:
                                                                      true,
                                                                  underline:
                                                                      Container(),
                                                                  iconEnabledColor:
                                                                      ColorSelect
                                                                          .east_dark_blue,
                                                                  items:
                                                                      list1.map(
                                                                    (String
                                                                        items) {
                                                                      return DropdownMenuItem(
                                                                        value:
                                                                            items,
                                                                        child:
                                                                            Text(
                                                                          items,
                                                                          style:
                                                                              TextController.BodyText,
                                                                        ),
                                                                      );
                                                                    },
                                                                  ).toList(),
                                                                  onChanged:
                                                                      (newValue) {
                                                                    setState(
                                                                      () {
                                                                        // print(
                                                                        //     fundMap);
                                                                        // print(psv[
                                                                        //     ClientTypeDropdownvalue]);

                                                                        servicesValue =
                                                                            newValue;
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Flexible(
                                                          child: Container())
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          // color: ColorSelect.east_blue,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .expenseName,
                                                                style: TextController
                                                                    .BodyHeadingText,
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                width: double
                                                                    .infinity,
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
                                                                  controller:
                                                                      expenseName,
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
                                                                      border: InputBorder
                                                                          .none),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          // color: ColorSelect.east_blue,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .expensecategory,
                                                                style: TextController
                                                                    .BodyHeadingText,
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    width: double
                                                                        .infinity,
                                                                    height: 35,
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color:
                                                                                ColorSelect.textField)),
                                                                    child:
                                                                        DropdownButton(
                                                                      hint: Text(
                                                                          "Select Here",
                                                                          style:
                                                                              TextController.labelText),
                                                                      value:
                                                                          ExpenseCatagDropdownvalue,
                                                                      isExpanded:
                                                                          true,
                                                                      underline:
                                                                          Container(),
                                                                      iconEnabledColor:
                                                                          ColorSelect
                                                                              .east_dark_blue,
                                                                      items: ExpenseCatag
                                                                          .map(
                                                                        (String
                                                                            items) {
                                                                          return DropdownMenuItem(
                                                                            value:
                                                                                items,
                                                                            child:
                                                                                Text(
                                                                              items,
                                                                              style: TextController.BodyText,
                                                                            ),
                                                                          );
                                                                        },
                                                                      ).toList(),
                                                                      onChanged:
                                                                          (newValue) {
                                                                        setState(
                                                                          () {
                                                                            ExpenseCatagDropdownvalue =
                                                                                newValue;
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  if (ExpenseCatagDropdownvalue ==
                                                                      "Other")
                                                                    Container(
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              10),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10),
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          35,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          border:
                                                                              Border.all(color: ColorSelect.textField)),
                                                                      child:
                                                                          TextFormField(
                                                                        controller:
                                                                            CategoryOther,
                                                                        textAlignVertical:
                                                                            TextAlignVertical.center,
                                                                        style: TextController
                                                                            .BodyHeadingText,
                                                                        decoration: InputDecoration(
                                                                            isDense:
                                                                                true,
                                                                            hintText:
                                                                                S.of(context).TypeHere,
                                                                            hintStyle: TextController.labelText,
                                                                            border: InputBorder.none),
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          // color: ColorSelect.east_blue,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .expenseAmt,
                                                                style: TextController
                                                                    .BodyHeadingText,
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                width: double
                                                                    .infinity,
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
                                                                  controller:
                                                                      expenseAmt,
                                                                  textAlignVertical:
                                                                      TextAlignVertical
                                                                          .center,
                                                                  style: TextController
                                                                      .BodyHeadingText,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  inputFormatters: <
                                                                      TextInputFormatter>[
                                                                    ThousandsSeparatorInputFormatter()
                                                                  ],
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
                                                                      border: InputBorder
                                                                          .none),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          // color: ColorSelect.east_blue,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .Date,
                                                                style: TextController
                                                                    .BodyHeadingText,
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                width: double
                                                                    .infinity,
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
                                                                  textAlignVertical:
                                                                      TextAlignVertical
                                                                          .center,
                                                                  style: TextController
                                                                      .BodyHeadingText,
                                                                  controller:
                                                                      ExpenseDate,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          suffixIcon:
                                                                              Icon(
                                                                            Icons.calendar_month_outlined,
                                                                            size:
                                                                                15,
                                                                          ),
                                                                          isDense:
                                                                              true,
                                                                          hintText: S
                                                                              .of(
                                                                                  context)
                                                                              .DateFormat,
                                                                          hintStyle: TextController
                                                                              .labelText,
                                                                          border:
                                                                              InputBorder.none),
                                                                  //readOnly: true,
                                                                  onTap:
                                                                      () async {
                                                                    DateTime? datepicked = await showDatePicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            DateTime
                                                                                .now(),
                                                                        firstDate:
                                                                            DateTime
                                                                                .now(),
                                                                        lastDate:
                                                                            DateTime.now());
                                                                    if (datepicked !=
                                                                        null) {
                                                                      print(
                                                                          datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                                      String
                                                                          formattedDate =
                                                                          DateFormat('yyyy-MM-dd')
                                                                              .format(datepicked!);
                                                                      WidgetsBinding
                                                                          .instance
                                                                          .addPostFrameCallback((_) =>
                                                                              setState((ExpenseDate.text = formattedDate) as VoidCallback));
                                                                      // format date in required form here we use yyyy-MM-dd that means time is remove
                                                                    } else {
                                                                      print(
                                                                          "Date is not selected");
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          // color: ColorSelect.east_blue,
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                S
                                                                    .of(context)
                                                                    .expenseDescription,
                                                                style: TextController
                                                                    .BodyHeadingText,
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            5),
                                                                width: double
                                                                    .infinity,
                                                                height: 100,
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
                                                                  maxLines:
                                                                      null,
                                                                  controller:
                                                                      expenseDescription,
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
                                                                          .descibeHere,
                                                                      hintStyle:
                                                                          TextController
                                                                              .labelText,
                                                                      border: InputBorder
                                                                          .none),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                        height: 35,
                                                        width: 140,
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                10, 0, 20, 0),
                                                        color: ColorSelect
                                                            .east_blue,
                                                        child: TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            side: BorderSide(
                                                              width: 1.0,
                                                              color: Color(
                                                                  0xFFC9BBBB),
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            ),
                                                          ),
                                                          onPressed: () {

                                                            //"clientId": ExpenseTrackerAdvisory.id.value,
      // "advisoryId": int.parse(advisoryid),
      // "expenseName": expenseName.text,
      // "expenseCategory": ExpenseCatagDropdownvalue,
      // "expenseAmount": int.parse(expenseAmt.text.replaceAll(",", "")),
      // "date": ExpenseDate.text,
      // "expenseDescription": expenseDescription.text
      //                                                       if (advisoryid.isBlank || expenseName.text.isEmpty|| ExpenseCatagDropdownvalue.isEmpty |)
                                                            ExpenseTracker();
                                                          },
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .Submit,
                                                            style:
                                                                TextController
                                                                    .btnText,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
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

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final String cleanedText = newValue.text.replaceAll(',', '');
    final parts = cleanedText.split('.');
    String formattedValue = _formatWithCommas(parts[0]);

    if (parts.length > 1) {
      formattedValue += '.' + parts[1];
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String _formatWithCommas(String text) {
    final int length = text.length;
    if (length <= 3) {
      return text;
    }
    String temp = "";
    int count = 3;
    int j = 0;
    for (int i = length - 1; i >= 0; i--) {
      j++;
      temp += text[i];
      if (j == count) {
        j = 0;
        temp += ",";
      }
    }

    temp = temp.split('').reversed.join('');
    if (temp[0] == ",") {
      temp = temp.substring(1);
    }
    return temp;
  }
}
