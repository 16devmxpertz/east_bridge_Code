import 'dart:convert';

import 'package:east_bridge/Fund%20Invoice/fundInvoiceSearch.dart';
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

import '../Global.dart';

class FundInvoiceMain extends StatefulWidget {
  const FundInvoiceMain({super.key});

  @override
  State<FundInvoiceMain> createState() => _FundInvoiceMainState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<String> fundname = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);

  static ValueNotifier<int> fundid = new ValueNotifier(0);
}

class _FundInvoiceMainState extends State<FundInvoiceMain> {
  TextEditingController fundName = new TextEditingController();
  TextEditingController clientName = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController FromDate = new TextEditingController();
  TextEditingController ToDate = new TextEditingController();

  String type = "";

  @override
  void initState() {
    super.initState();
    print(FundInvoiceMain.name.value);
    //_calculation();

    setState(() {
      clientName.text = FundInvoiceMain.name.value;
      fundName.text = FundInvoiceMain.fundname.value;
      // amnt=pershare * noofshare;
    });
    getFundList();
    // a(); // Setting the initial value for the field.
  }

  var fundMap = {};
  var f1 = ["Please Search Client First"];
  var f2 = ["Please Search Client First"];
  var fundlist = [];

  var psv = {};
  List fundListkey = [];
  String? numberShare;
  var key = {};

  void getFundList() async {
    print("clientid-------------");
    print(
        'https://localhost:44323/api/GetFundsByClientID/FundsByClientID?id=${FundInvoiceMain.clientid.value}');
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GetFundsByClientID/FundsByClientID?id=${FundInvoiceMain.clientid.value}');

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
        print(responseData);
        setState(() {
          fundMap = responseData;
          // for (String i in fundMap.values.toList()) {
          //   fundlist.add(i as DropdownMenuItem<String>);
          // }
          f1.clear();
          fundlist = fundMap.values.toList();
          print(fundlist);
          for (String i in fundlist) {
            f1.add(i.split("~")[0]);
            psv[i.split("~")[0]] = i.split("~")[2];
            numberShare = i.split("~")[1];
          }

          fundListkey = fundMap.keys.toList();
        });
        print("------f--");
        print(fundMap);
        print(psv);

        print("-------fl---done");
        print(fundlist);

        print("------kyy----done");
        print(fundListkey);
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

  _launchURLApp() async {
    for (var i in fundMap.keys.toList()) {
      print("IIIIIIIIIIIIIII");

      if (ClientTypeDropdownvalue == fundMap[i].split("~")[0]) {
        setState(() {
          FundInvoiceMain.fundid.value = int.parse(i);
        });
      }
    }
    try {
      var url = Uri.parse(
          "${GlobalPermission.urlLink}/api/generateInvoicereport/getInvoiceReport?fundId=${FundInvoiceMain.fundid.value}&clientId=${FundInvoiceMain.clientid.value}&type=${type}&StartDate=${FromDate.text}&EndDate=${ToDate.text}");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => new FundInvoiceMain()));

        setState(() {
          FundInvoiceMain.fundid.value = 0;
          FundInvoiceMain.clientid.value = 0;
          FundInvoiceMain.name.value = "";
          FundInvoiceMain.fundname.value = "";
          // amnt=pershare * noofshare;
        });
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
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
  }

  double yOffset = 0;
  double xOffset = 0;
  bool sidBarOpen = false;
  bool _sidebarVisible = false;
  String? ClientTypeDropdownvalue;

  bool get sidebarVisible => _sidebarVisible;

  void toggleSidebar() {
    _sidebarVisible = !_sidebarVisible;
  }

  void setSideBarState() {
    setState(() {
      xOffset = sidBarOpen ? 250 : 0;
    });
  }

  var typeList = [
    "Subscribe",
    "Redeem",
  ];

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
                      // Header start
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
                      // Header end

                      Stack(
                        children: [
                          AnimatedContainer(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            transform: Matrix4.translationValues(
                                xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            color: Colors.white,
                            child: SingleChildScrollView(
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
                                      color: Color.fromRGBO(0, 0, 0, 0.363),
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFFFFF),
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ColorSelect.east_grey,
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
                                                S.of(context).FundInvoice,
                                                style: TextController
                                                    .MainHeadingText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      FundInvoiceSearch(),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
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
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    S.of(context).FundName,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 280,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorSelect
                                                                  .textField)),
                                                      child: DropdownButton(
                                                        hint: Text(
                                                            "Select Here",
                                                            style:
                                                                TextController
                                                                    .labelText),
                                                        value:
                                                            ClientTypeDropdownvalue,
                                                        isExpanded: true,
                                                        underline: Container(),
                                                        iconEnabledColor:
                                                            ColorSelect
                                                                .east_dark_blue,
                                                        items: f1.map(
                                                          (String items) {
                                                            return DropdownMenuItem(
                                                              value: items,
                                                              child: Text(
                                                                items,
                                                                style:
                                                                    TextController
                                                                        .BodyText,
                                                              ),
                                                            );
                                                          },
                                                        ).toList(),
                                                        onChanged: (newValue) {
                                                          setState(
                                                            () {
                                                              print(fundMap);

                                                              ClientTypeDropdownvalue =
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    S.of(context).ClientName,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 280,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorSelect
                                                                  .textField)),
                                                      child: TextFormField(
                                                        //   initialValue: FundSubscribe.name.value,
                                                        controller: clientName,
                                                        readOnly: false,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        style: TextController
                                                            .BodyHeadingText,
                                                        decoration: InputDecoration(
                                                            isDense: true,
                                                            hintText: S
                                                                .of(context)
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
                                              width: 15,
                                            ),
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    S.of(context).Type,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 280,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorSelect
                                                                  .textField)),
                                                      child: DropdownButton<
                                                          String>(
                                                        hint: Text(
                                                            "Select Here",
                                                            style:
                                                                TextController
                                                                    .labelText),
                                                        value: type.isNotEmpty
                                                            ? type
                                                            : null,
                                                        isExpanded: true,
                                                        underline: Container(),
                                                        iconEnabledColor:
                                                            ColorSelect
                                                                .east_dark_blue,
                                                        items: typeList.map(
                                                          (String items) {
                                                            return DropdownMenuItem(
                                                              value: items,
                                                              child: Text(
                                                                items,
                                                                style:
                                                                    TextController
                                                                        .BodyText,
                                                              ),
                                                            );
                                                          },
                                                        ).toList(),
                                                        onChanged: (NewValue) {
                                                          setState(
                                                            () {
                                                              type = NewValue!;
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
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
                                            Flexible(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    S.of(context).FromDate,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 280,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .textField),
                                                      ),
                                                      child: TextFormField(
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        style: TextController
                                                            .BodyHeadingText,
                                                        controller: FromDate,
                                                        decoration:
                                                            InputDecoration(
                                                                suffixIcon:
                                                                    Icon(
                                                                  Icons
                                                                      .calendar_month_outlined,
                                                                  size: 15,
                                                                ),
                                                                isDense: true,
                                                                hintText: S
                                                                    .of(context)
                                                                    .DateFormat,
                                                                hintStyle:
                                                                    TextController
                                                                        .labelText,
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        //readOnly: true,
                                                        onTap: () async {
                                                          DateTime? datepicked =
                                                              await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2023),
                                                                  lastDate:
                                                                      DateTime(
                                                                          3000));
                                                          if (datepicked !=
                                                              null) {
                                                            print(
                                                                datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                            String
                                                                formattedDate =
                                                                DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        datepicked!);
                                                            WidgetsBinding
                                                                .instance
                                                                .addPostFrameCallback((_) => setState(
                                                                    (FromDate.text =
                                                                            formattedDate)
                                                                        as VoidCallback));
                                                            // format date in required form here we use yyyy-MM-dd that means time is remove
                                                          } else {
                                                            print(
                                                                "Date is not selected");
                                                          }
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    S.of(context).ToDate,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 280,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .textField),
                                                      ),
                                                      child: TextFormField(
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        style: TextController
                                                            .BodyHeadingText,
                                                        controller: ToDate,
                                                        decoration:
                                                            InputDecoration(
                                                                suffixIcon:
                                                                    Icon(
                                                                  Icons
                                                                      .calendar_month_outlined,
                                                                  size: 15,
                                                                ),
                                                                isDense: true,
                                                                hintText: S
                                                                    .of(context)
                                                                    .DateFormat,
                                                                hintStyle:
                                                                    TextController
                                                                        .labelText,
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        //readOnly: true,
                                                        onTap: () async {
                                                          DateTime? datepicked =
                                                              await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      DateTime
                                                                          .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2023),
                                                                  lastDate:
                                                                      DateTime(
                                                                          3000));
                                                          if (datepicked !=
                                                              null) {
                                                            print(
                                                                datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                            String
                                                                formattedDate =
                                                                DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        datepicked!);
                                                            WidgetsBinding
                                                                .instance
                                                                .addPostFrameCallback((_) =>
                                                                    setState((ToDate
                                                                                .text =
                                                                            formattedDate)
                                                                        as VoidCallback));
                                                            // format date in required form here we use yyyy-MM-dd that means time is remove
                                                          } else {
                                                            print(
                                                                "Date is not selected");
                                                          }
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
                                              child: Container(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                height: 35,
                                                color: ColorSelect.east_blue,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    side: BorderSide(
                                                      width: 1.0,
                                                      color: Color(0xFFC9BBBB),
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // sendData();
                                                    if (clientName.text == "" ||
                                                        ClientTypeDropdownvalue ==
                                                            null ||
                                                        type == "" ||
                                                        FromDate.text == "" ||
                                                        ToDate.text == "") {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Please enter all fields",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 3,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    } else {
                                                      _launchURLApp();
                                                    }
                                                    //  this.search();
                                                  },
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .GenerateInvoice,
                                                    style:
                                                        TextController.btnText,
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
