import 'dart:convert';

//import 'dart:developer';
import 'package:east_bridge/Fund%20Creation/FundReports/ReportsSearch.dart';
import 'package:east_bridge/Fund%20Reedem/FundReedem.dart';
import 'package:east_bridge/Fund%20Subscribe/FundSubscribeMainSearchComponent.dart';
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

class ReportsDownload extends StatefulWidget {
  @override
  State<ReportsDownload> createState() => _FundSubscribeState();
  ReportsDownload({
    @required String? type,
  }) {
    Type = type;
    // _formKey = formKey;
  }
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<String> fundname = new ValueNotifier("");

  static ValueNotifier<int> clientid = new ValueNotifier(0);

  static ValueNotifier<int> fundid = new ValueNotifier(0);
}

String? Type;

class _FundSubscribeState extends State<ReportsDownload> {
  TextEditingController fundName = new TextEditingController();
  TextEditingController clientName = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController Amount = new TextEditingController();
  TextEditingController year = new TextEditingController();

  int amnt = 0;
  int currentValue = 0;
  // String value = "";
  //int pershare = int.parse(ReportsDownload.persharevalue.value);
  // int noofshare = int.parse(NoOfShares.text);
  // int amnt = int.parse(Amount.text);
  late Map<String, dynamic> permission = {};

  void a() async {
    var data = await GlobalPermission.formPermission("Fund Subscription");
    setState(() {
      permission = data;
    });
  }

  @override
  void initState() {
    super.initState();
    NoOfShares.text = "0";
    print(ReportsDownload.name.value);
    //_calculation();

    setState(() {
      // amnt=pershare * noofshare;
    });
    a(); // Setting the initial value for the field.
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

  _launchURLApp() async {
    var url = Uri.parse(
        "${GlobalPermission.urlLink}/api/generateInvoicereport/getInvoiceReport?fundId=${ReportsDownload.fundid.value}&clientId=${ReportsDownload.clientid.value}&type=Subscribe");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List list = [];

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
                                        //   builder: (context) => FundSubscribe(),
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
                                        //   builder: (context) => KYCPdfUploadIND(),
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
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SingleChildScrollView(
                                    child: Container(
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
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.363),
                                          ),
                                        ],
                                      ),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              margin: EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFFFFF),
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color:
                                                        ColorSelect.east_grey,
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
                                                      '${Type} Reports',
                                                      style: TextController
                                                          .MainHeadingText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ReportsSearch(),

                                            if (Type != "DPM")
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color:
                                                          ColorSelect.east_grey,
                                                      width: 1,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    if (Type ==
                                                            "Trading Movements" ||
                                                        Type == "Fund" ||
                                                        Type == "Fund Annual")
                                                      Flexible(
                                                        child: Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment
                                                          //         .spaceBetween,
                                                          children: [
                                                            Text(
                                                              S
                                                                  .of(context)
                                                                  .FundName,
                                                              style: TextController
                                                                  .BodyHeadingText,
                                                            ),
                                                            SizedBox(
                                                              width: 50,
                                                            ),
                                                            Flexible(
                                                              child: Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  width: 280,
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
                                                                  child: Text(
                                                                    ReportsDownload
                                                                        .fundname
                                                                        .value,
                                                                    style: TextController
                                                                        .BodyText,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    if (Type == "Fund" ||
                                                        Type == "Fund Annual")
                                                      Flexible(
                                                        child: Row(
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment
                                                          //         .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Year",
                                                              style: TextController
                                                                  .BodyHeadingText,
                                                            ),
                                                            SizedBox(
                                                              width: 50,
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
                                                                    TextFormField(
                                                                  controller:
                                                                      year,
                                                                  style: TextController
                                                                      .BodyText,
                                                                  textAlignVertical:
                                                                      TextAlignVertical
                                                                          .center,
                                                                  decoration: InputDecoration(
                                                                      errorStyle:
                                                                          TextController
                                                                              .inputErrorText,
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
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    SizedBox(
                                                      width: 50,
                                                    ),
                                                    (!(Type == "Fund" ||
                                                            Type ==
                                                                "Fund Annual"))
                                                        ? Flexible(
                                                            child: Container(
                                                              child: Row(
                                                                // mainAxisAlignment:
                                                                //     MainAxisAlignment
                                                                //         .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    S
                                                                        .of(context)
                                                                        .ClientName,
                                                                    style: TextController
                                                                        .BodyHeadingText,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 50,
                                                                  ),
                                                                  Flexible(
                                                                    child: Container(
                                                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                                                        width: 280,
                                                                        height: 35,
                                                                        alignment: Alignment.centerLeft,
                                                                        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: ColorSelect.textField)),
                                                                        child: Text(
                                                                          ReportsDownload
                                                                              .name
                                                                              .value,
                                                                          style:
                                                                              TextController.BodyText,
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Flexible(
                                                            child: Container()),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color:
                                                        ColorSelect.east_grey,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      height: 35,
                                                      width: 150,
                                                      color:
                                                          ColorSelect.east_blue,
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
                                                          print(ReportsDownload
                                                              .clientid.value);
                                                          print(ReportsDownload
                                                              .fundid.value);
                                                          print(Type);

                                                          if (Type == "DPM") {
                                                            GlobalPermission
                                                                .reportsDownloadFund2(
                                                                    ReportsDownload
                                                                        .clientid
                                                                        .value,
                                                                    Type!);
                                                          } else if (Type ==
                                                                  "Fund" ||
                                                              Type ==
                                                                  "Fund Annual") {
                                                            GlobalPermission
                                                                .reportsDownloadFund(
                                                                    ReportsDownload
                                                                        .clientid
                                                                        .value,
                                                                    ReportsDownload
                                                                        .fundid
                                                                        .value,
                                                                    Type!,
                                                                    year.text);
                                                          } else if (ReportsDownload
                                                                  .clientid
                                                                  .value !=
                                                              0) {
                                                            if (Type ==
                                                                "Trading Movements") {
                                                              GlobalPermission.reportsDownloadFund(
                                                                  ReportsDownload
                                                                      .clientid
                                                                      .value,
                                                                  ReportsDownload
                                                                      .fundid
                                                                      .value,
                                                                  Type!,
                                                                  year.text);
                                                            } else if (Type ==
                                                                    "Realized P/L" ||
                                                                Type ==
                                                                    "Order History" ||
                                                                Type ==
                                                                    "Transfer Inquiry" ||
                                                                Type ==
                                                                    "Cash Statement" ||
                                                                Type ==
                                                                    "Client") {
                                                              GlobalPermission
                                                                  .reportsDownloadFund2(
                                                                      ReportsDownload
                                                                          .clientid
                                                                          .value,
                                                                      Type!);
                                                            }
                                                          } else {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Please select client first",
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

                                                          //  this.search();
                                                        },
                                                        child: Text(
                                                          "Download Reports",
                                                          style: TextController
                                                              .btnText,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Text(list.toString())
                                          ],
                                        ),
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
