import 'dart:convert';

//import 'dart:developer';
import 'package:east_bridge/Advisory/Advisory%20PDF%20UploadDownload/AgreementPdfDownloadUpload.dart';
import 'package:east_bridge/Advisory/Advisory%20Redeem/AdvisoryRedeemMainSearchComponent.dart';
import 'package:east_bridge/Advisory/AdvisoryGlobal.dart';
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
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FinanceExpenseBooking extends StatefulWidget {
  const FinanceExpenseBooking({super.key});

  @override
  State<FinanceExpenseBooking> createState() => _FinanceExpenseBookingState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<String> fundname = new ValueNotifier("");
  static ValueNotifier<String> persharevalue = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);
  static ValueNotifier<int> mId = new ValueNotifier(0);

  static ValueNotifier<int> advisoryId = new ValueNotifier(0);
}

class _FinanceExpenseBookingState extends State<FinanceExpenseBooking> {
  TextEditingController fundName = new TextEditingController();
  TextEditingController clientName = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController Amount = new TextEditingController();

  int amnt = 0;
  int currentValue = 0;
  String? advisoryname;

  List<dynamic> list = [];
  var list1 = ["seleect client first"];
  List<bool> check = [];

  var keys = [];
  int advisoryId = 0;

  var MileStones;
  var MileStonestatus;

  // String value = "";
  //int pershare = int.parse(AdvisorySubscribe.persharevalue.value);
  // int noofshare = int.parse(NoOfShares.text);
  // int amnt = int.parse(Amount.text);

  @override
  void initState() {
    super.initState();
    print("Initttt Runningg");
    fetchExpenses();

    // amnt=pershare * noofshare;
    // Setting the initial value for the field.
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

  _launchURLApp(int id) async {
    var username = 'Administrator';
    var password = 'hX9b7aBd\$2Z';
    var url = Uri.parse(
        "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2fAdvisoryMileStoneInvoice&rs:Command=Render&InvoiceId=${id}&CID=${FinanceExpenseBooking.clientid.value}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<Map<String, dynamic>> exp = [];
  void sendData() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryMilestoneInvoiceCreation/SetInvoiceForMileStone');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": FinanceExpenseBooking.clientid.value,
        "advisoryId": FinanceExpenseBooking.advisoryId.value,
        "mileStoneId": FinanceExpenseBooking.mId.value,
        "date": DateTime.now().toString(),
        "data": exp
      };
      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        int id = jsonDecode(response.body);
        _launchURLApp(id);
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

  List<Map<String, dynamic>> data = [];
  List<int> expenseIds = [];
  List<int> expensefinal = [];
  void fetchExpenses() async {
    print("clientid-------------");
    print(
        'ClientId=${FinanceExpenseBooking.clientid.value}&AdvisoryId=${FinanceExpenseBooking.advisoryId.value}');
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvosiryExpenseTracker/GetExpensesForClient?ClientId=${FinanceExpenseBooking.clientid.value}&AdvisoryId=${FinanceExpenseBooking.advisoryId.value}');

    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      print("expensessssss");
      if (jsonResponse is List<dynamic>) {
        var x = List<Map<String, dynamic>>.from(jsonResponse);
        for (var i in x) {
          if (i["isPaid"] == false) {
            setState(() {
              data.add(i);
              check.add(false);
            });
          }
        }
        setState(() {
          exp.clear();
        });
        // Now you can work with the 'data' list
      }

      print("Data expenseeeeee");
      print(data);

      for (var x in data) {
        print(x["expenseId"]);
        setState(() {
          expenseIds.add(x["expenseId"]);
        });
      }
      print(data[0]["expensename"]);
      print("Lengthhhh");
      print(data.length);
      // Map x = jsonDecode(response.body);
      // setState(() {
      //   MileStones.clear();
      //   MileStonestatus.clear();
      //   MileStones = x.keys.toList();
      //   MileStonestatus = x.values.toList();
      // });
    } else {
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print("error");
      print(errorMessage);
    }
  }

  Future Updatesttus() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvosiryExpenseTracker/SetExpensePaid');
    print(url);

    var headers = {
      'Content-Type': 'application/json',
    };
    var body = {"expenseId": expensefinal};
    print(body);
    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Updated");
      sendData();
    } else {
      print(response.body);
      print("error");
    }
  }

  Future fetchData(int cid, int aid) async {
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
      setState(() {
        MileStones.clear();
        MileStonestatus.clear();
        MileStones = x.keys.toList();
        MileStonestatus = x.values.toList();
      });
    } else {
      print("error");
    }
  }

  void search() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/Search?searchValue=${fundName.text}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print(json.decode(response.body));
      list = json.decode(response.body);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  //  return response.

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
                                  Text(
                                    S.of(context).ExpenseBooking,
                                    style: TextController.MainHeadingText,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ColorSelect.east_grey,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        //Flexible(
                                        // child: Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     Text(
                                        //       S.of(context).TemplateName,
                                        //       style: TextController.BodyText,
                                        //     ),
                                        //     SizedBox(
                                        //       width: 10,
                                        //     ),
                                        //     Flexible(
                                        //       child: Container(
                                        //         padding: EdgeInsets.symmetric(
                                        //             horizontal: 10),
                                        //         width: 280,
                                        //         height: 35,
                                        //         alignment:
                                        //             Alignment.centerLeft,
                                        //         decoration: BoxDecoration(
                                        //             color: Colors.white,
                                        //             border: Border.all(
                                        //                 color: ColorSelect
                                        //                     .textField)),
                                        //         child: TextFormField(
                                        //           textAlignVertical:
                                        //               TextAlignVertical
                                        //                   .center,
                                        //           style: TextController
                                        //               .BodyHeadingText,
                                        //           decoration: InputDecoration(
                                        //               isDense: true,
                                        //               hintText: S
                                        //                   .of(context)
                                        //                   .TypeHere,
                                        //               hintStyle:
                                        //                   TextController
                                        //                       .labelText,
                                        //               border:
                                        //                   InputBorder.none),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        //  ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 1000,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Table(
                                      border: TableBorder.all(
                                          color: ColorSelect.tabBorderColor),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(1),
                                        2: FlexColumnWidth(1)
                                        // 0: FixedColumnWidth(500),
                                        // 1: FixedColumnWidth(500)
                                      },
                                      children: [
                                        TableRow(children: [
                                          Container(
                                              height: 50,
                                              color: ColorSelect.east_grey,
                                              child: Center(
                                                  child: Text(
                                                S.of(context).expenseName,
                                                style:
                                                    TextController.tableHeading,
                                              ))),
                                          Container(
                                              height: 50,
                                              color: ColorSelect.east_grey,
                                              child: Center(
                                                  child: Text(
                                                S.of(context).expenseAmt,
                                                style:
                                                    TextController.tableHeading,
                                              ))),
                                          Container(
                                              height: 50,
                                              color: ColorSelect.east_grey,
                                              child: Center(
                                                  child: Text(
                                                S.of(context).Status,
                                                style:
                                                    TextController.tableHeading,
                                              ))),
                                        ]),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // height: 800,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemCount: data.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return table(
                                            data[index]["expensename"],
                                            data[index]["expenseamaount"]
                                                .toString(),
                                            index,
                                            context);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ColorSelect.east_grey,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Container(
                                            height: 35,
                                            width: 150,
                                            color: ColorSelect.east_blue,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                side: BorderSide(
                                                  width: 1.0,
                                                  color: ColorSelect.east_blue,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                              ),
                                              onPressed: () {
                                                Updatesttus();

                                                //  this.search();
                                              },
                                              child: Text(
                                                "View Invoice",
                                                style: TextController.btnText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
              ),
              Navigation(),
            ],
          ),
        ),
      ),
    );
  }

  Widget table(String templateName, String templateKeys, int index,
      BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Container(
              width: 1000,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Table(
                border: TableBorder.all(color: ColorSelect.tabBorderColor),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
                children: [
                  TableRow(children: [
                    Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          templateName,
                          style: TextController.BodyText,
                        ))),
                    Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          templateKeys,
                          style: TextController.BodyText,
                        ))),
                    Container(
                      child: Center(
                        child: Checkbox(
                          value: check[index],
                          onChanged: (bool? value) async {
                            setState(() {
                              check[index] = value!;
                              var x = {
                                "name": templateName,
                                "tax": 0,
                                "qty": 0,
                                "rate": 0,
                                "amount": templateKeys
                              };

                              exp.add(x);
                              print(expenseIds);
                              expensefinal.add(expenseIds[index]);
                            });
                          },
                        ),
                      ),
                    )
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
