import 'dart:convert';

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

class FundSubscribe extends StatefulWidget {
  const FundSubscribe({super.key});

  @override
  State<FundSubscribe> createState() => _FundSubscribeState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<String> fundname = new ValueNotifier("");
  static ValueNotifier<String> persharevalue = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);

  static ValueNotifier<int> fundid = new ValueNotifier(0);
}

class _FundSubscribeState extends State<FundSubscribe> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//
  bool fundNameError = false;
  bool clientNameError = false;
  bool dateError = false;
  bool PerShareValueError = false;
  bool NoOfSharesError = false;
  bool AmountError = false;
//

  TextEditingController fundName = new TextEditingController();
  TextEditingController clientName = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController Amount = new TextEditingController();
  int amnt = 0;
  int currentValue = 0;
  // String value = "";
  //int pershare = int.parse(FundSubscribe.persharevalue.value);
  // int noofshare = int.parse(NoOfShares.text);
  // int amnt = int.parse(Amount.text);
  late Map<String, dynamic> permission = {};

  void a() async {
    var data = await GlobalPermission.formPermission("Fund Subscription");
    setState(() {
      permission = data;
    });
  }

  NumberFormat formatter = NumberFormat("#,###.##", "en_US");

  @override
  void initState() {
    super.initState();
    NoOfShares.text = "0";
    print(FundSubscribe.name.value);
    //_calculation();

    setState(() {
      clientName.text = FundSubscribe.name.value;
      fundName.text = FundSubscribe.fundname.value;
      PerShareValue.text = FundSubscribe.persharevalue.value;

      Amount.text = amnt.toString();
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
        "${GlobalPermission.urlLink}/api/generateInvoicereport/getInvoiceReport?fundId=${FundSubscribe.fundid.value}&clientId=${FundSubscribe.clientid.value}&type=Subscribe");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List list = [];
  void sendData() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundSubscribeRedeem/FundSubscribeRedeem/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": FundSubscribe.clientid.value,
        "fundId": FundSubscribe.fundid.value,
        "fundName": fundName.text,
        "type": "Subscription",
        "date": date.text,
        "perShareValue": double.parse(PerShareValue.text.replaceAll(",", "")),
        "noOfShare": int.parse(NoOfShares.text.replaceAll(",", "")),
      };
      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        setState(() {
          clientName.text = "";
          PerShareValue.text = "";
          fundName.text = "";
          FundSubscribe.fundname.value = "";
          FundSubscribe.name.value = "";
        });

        Fluttertoast.showToast(
          msg: "Fund Subscribed Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          clientName.text = "";
          FundSubscribe.name.value = "";
          FundSubscribe.persharevalue.value = "";
          PerShareValue.text = "";
        });
        // _launchURLApp();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => new FundSubscribe()));
        // print(jsonDecode(response.body));
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
              Form(
                key: _formKey,
                child: Container(
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
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                FundSubscribe(),
                                          ));
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                style: TextController
                                                    .ControllerText,
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
                                              color: Color.fromRGBO(
                                                  0, 0, 0, 0.363),
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
                                                        'Fund Subscription',
                                                        style: TextController
                                                            .MainHeadingText,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              FundSubscribeMainSearchComponent(),
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
                                                                .FundName,
                                                            style:
                                                                TextController
                                                                    .BodyText,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
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
                                                                  child:
                                                                      TextFormField(
                                                                    readOnly:
                                                                        false,
                                                                    controller:
                                                                        fundName,
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    style: TextController
                                                                        .BodyHeadingText,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        setState(
                                                                            () {
                                                                          fundNameError =
                                                                              true;
                                                                        });
                                                                        return "";
                                                                      }
                                                                      setState(
                                                                          () {
                                                                        fundNameError =
                                                                            false;
                                                                      });
                                                                      return null;
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      hintText: S
                                                                          .of(context)
                                                                          .TypeHere,
                                                                      hintStyle:
                                                                          TextController
                                                                              .labelText,
                                                                      border: InputBorder
                                                                          .none,
                                                                      errorStyle:
                                                                          TextStyle(
                                                                              height: 0),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (fundNameError)
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    child: Text(
                                                                      "This field is required",
                                                                      style: TextController
                                                                          .errorText,
                                                                    ),
                                                                  )
                                                              ],
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
                                                                .ClientName,
                                                            style:
                                                                TextController
                                                                    .BodyText,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
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
                                                                  child:
                                                                      TextFormField(
                                                                    //   initialValue: FundSubscribe.name.value,
                                                                    controller:
                                                                        clientName,
                                                                    readOnly:
                                                                        false,
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    style: TextController
                                                                        .BodyHeadingText,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        setState(
                                                                            () {
                                                                          clientNameError =
                                                                              true;
                                                                        });
                                                                        return "";
                                                                      }
                                                                      setState(
                                                                          () {
                                                                        clientNameError =
                                                                            false;
                                                                      });
                                                                      return null;
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      hintText: S
                                                                          .of(context)
                                                                          .TypeHere,
                                                                      hintStyle:
                                                                          TextController
                                                                              .labelText,
                                                                      border: InputBorder
                                                                          .none,
                                                                      errorStyle:
                                                                          TextStyle(
                                                                              height: 0),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (clientNameError)
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    child: Text(
                                                                      "This field is required",
                                                                      style: TextController
                                                                          .errorText,
                                                                    ),
                                                                  ),
                                                              ],
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
                                                            S.of(context).Date,
                                                            style:
                                                                TextController
                                                                    .BodyText,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
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
                                                                  child:
                                                                      TextFormField(
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    style: TextController
                                                                        .BodyHeadingText,
                                                                    controller:
                                                                        date,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        setState(
                                                                            () {
                                                                          dateError =
                                                                              true;
                                                                        });
                                                                        return "";
                                                                      }
                                                                      setState(
                                                                          () {
                                                                        dateError =
                                                                            false;
                                                                      });
                                                                      return null;
                                                                    },
                                                                    decoration: InputDecoration(
                                                                        suffixIcon: Icon(
                                                                          Icons
                                                                              .calendar_month_outlined,
                                                                          size:
                                                                              15,
                                                                        ),
                                                                        errorStyle: TextStyle(height: 0),
                                                                        isDense: true,
                                                                        hintText: S.of(context).DateFormat,
                                                                        hintStyle: TextController.labelText,
                                                                        border: InputBorder.none),
                                                                    //readOnly: true,
                                                                    onTap:
                                                                        () async {
                                                                      DateTime? datepicked = await showDatePicker(
                                                                          context:
                                                                              context,
                                                                          initialDate: DateTime
                                                                              .now(),
                                                                          firstDate: DateTime
                                                                              .now(),
                                                                          lastDate:
                                                                              DateTime(3000));
                                                                      if (datepicked !=
                                                                          null) {
                                                                        print(
                                                                            datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                                        String
                                                                            formattedDate =
                                                                            DateFormat('yyyy-MM-dd').format(datepicked!);
                                                                        WidgetsBinding
                                                                            .instance
                                                                            .addPostFrameCallback((_) =>
                                                                                setState((date.text = formattedDate) as VoidCallback));
                                                                        // format date in required form here we use yyyy-MM-dd that means time is remove
                                                                      } else {
                                                                        print(
                                                                            "Date is not selected");
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                if (dateError)
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    child: Text(
                                                                      "This field is required",
                                                                      style: TextController
                                                                          .errorText,
                                                                    ),
                                                                  ),
                                                              ],
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
                                                                .PerUnitValue,
                                                            style:
                                                                TextController
                                                                    .BodyText,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
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
                                                                  child:
                                                                      TextFormField(
                                                                    readOnly:
                                                                        false,
                                                                    controller:
                                                                        PerShareValue,
                                                                    onChanged:
                                                                        (value) {
                                                                      value = PerShareValue
                                                                          .text;
                                                                      setState(
                                                                          () {
                                                                        currentValue = int.parse(value.replaceAll(
                                                                            ",",
                                                                            ""));
                                                                        double
                                                                            amount =
                                                                            (currentValue *
                                                                                double.parse(NoOfShares.text.replaceAll(",", "")));
                                                                        String formattedAmount = ThousandsSeparatorInputFormatter()
                                                                            .formatEditUpdate(
                                                                              TextEditingValue(),
                                                                              TextEditingValue(text: amount.toStringAsFixed(2)), // Format with two decimal places
                                                                            )
                                                                            .text;
                                                                        Amount.text =
                                                                            formattedAmount;
                                                                      });
                                                                    },
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[
                                                                      ThousandsSeparatorInputFormatter(),
                                                                    ],
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    style: TextController
                                                                        .BodyHeadingText,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        setState(
                                                                            () {
                                                                          PerShareValueError =
                                                                              true;
                                                                        });
                                                                        return "";
                                                                      }
                                                                      setState(
                                                                          () {
                                                                        PerShareValueError =
                                                                            false;
                                                                      });
                                                                      return null;
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      isDense:
                                                                          true,
                                                                      hintText: S
                                                                          .of(context)
                                                                          .TypeHere,
                                                                      hintStyle:
                                                                          TextController
                                                                              .labelText,
                                                                      border: InputBorder
                                                                          .none,
                                                                      errorStyle:
                                                                          TextStyle(
                                                                              height: 0),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if (PerShareValueError)
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    child: Text(
                                                                      "This field is required",
                                                                      style: TextController
                                                                          .errorText,
                                                                    ),
                                                                  ),
                                                              ],
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
                                                                .NoOfUnit,
                                                            style:
                                                                TextController
                                                                    .BodyText,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
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
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            TextFormField(
                                                                          readOnly:
                                                                              false,
                                                                          onChanged:
                                                                              (value) {
                                                                            value =
                                                                                NoOfShares.text;
                                                                            setState(() {
                                                                              currentValue = int.parse(value.replaceAll(",", ""));
                                                                              double amount = (currentValue * double.parse(PerShareValue.text.replaceAll(",", "")));

                                                                              String formattedAmount = ThousandsSeparatorInputFormatter()
                                                                                  .formatEditUpdate(
                                                                                    TextEditingValue(),
                                                                                    TextEditingValue(text: amount.toStringAsFixed(2)), // Format with two decimal places
                                                                                  )
                                                                                  .text;
                                                                              Amount.text = formattedAmount;
                                                                            });
                                                                          },
                                                                          controller:
                                                                              NoOfShares,
                                                                          inputFormatters: <
                                                                              TextInputFormatter>[
                                                                            FilteringTextInputFormatter.digitsOnly,
                                                                            ThousandsSeparatorInputFormatter(),
                                                                          ],
                                                                          textAlignVertical:
                                                                              TextAlignVertical.center,
                                                                          style:
                                                                              TextController.BodyHeadingText,
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              setState(() {
                                                                                NoOfSharesError = true;
                                                                              });
                                                                              return "";
                                                                            }
                                                                            setState(() {
                                                                              NoOfSharesError = false;
                                                                            });
                                                                            return null;
                                                                          },
                                                                          decoration: InputDecoration(
                                                                              isDense: true,
                                                                              hintText: '0',
                                                                              errorStyle: TextStyle(height: 0),
                                                                              hintStyle: TextController.labelText,
                                                                              border: InputBorder.none),
                                                                        ),
                                                                      ),
                                                                      Flexible(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              35.0,
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                  border: Border(
                                                                                    bottom: BorderSide(
                                                                                      width: 0.5,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                child: InkWell(
                                                                                  child: Icon(
                                                                                    Icons.arrow_drop_up,
                                                                                    size: 15.0,
                                                                                  ),
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      currentValue++;
                                                                                      NoOfShares.text = currentValue.toString();
                                                                                      double amount = (currentValue * double.parse(PerShareValue.text.replaceAll(",", "")));

                                                                                      String formattedAmount = ThousandsSeparatorInputFormatter()
                                                                                          .formatEditUpdate(
                                                                                            TextEditingValue(),
                                                                                            TextEditingValue(text: amount.toStringAsFixed(2)), // Format with two decimal places
                                                                                          )
                                                                                          .text;
                                                                                      Amount.text = formattedAmount;
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                child: Icon(
                                                                                  Icons.arrow_drop_down,
                                                                                  size: 15.0,
                                                                                ),
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    if (!(currentValue - 1 < 0)) {
                                                                                      currentValue--;
                                                                                    }
                                                                                    NoOfShares.text = currentValue.toString();
                                                                                    Amount.text = (currentValue * int.parse(PerShareValue.text)).toString();
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                if (NoOfSharesError)
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    child: Text(
                                                                      "This field is required",
                                                                      style: TextController
                                                                          .errorText,
                                                                    ),
                                                                  ),
                                                              ],
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
                                                                .Amount,
                                                            style:
                                                                TextController
                                                                    .BodyText,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Flexible(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
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
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        Amount,
                                                                    inputFormatters: <
                                                                        TextInputFormatter>[
                                                                      FilteringTextInputFormatter
                                                                          .digitsOnly,
                                                                      ThousandsSeparatorInputFormatter(),
                                                                    ],
                                                                    textAlignVertical:
                                                                        TextAlignVertical
                                                                            .center,
                                                                    style: TextController
                                                                        .BodyHeadingText,
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        setState(
                                                                            () {
                                                                          AmountError =
                                                                              true;
                                                                        });
                                                                        return "";
                                                                      }
                                                                      setState(
                                                                          () {
                                                                        AmountError =
                                                                            false;
                                                                      });
                                                                      return null;
                                                                    },
                                                                    decoration: InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        hintText: S
                                                                            .of(
                                                                                context)
                                                                            .TypeHere,
                                                                        hintStyle: TextController
                                                                            .labelText,
                                                                        errorStyle: TextStyle(
                                                                            height:
                                                                                0),
                                                                        border:
                                                                            InputBorder.none),
                                                                  ),
                                                                ),
                                                                if (AmountError)
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                5),
                                                                    child: Text(
                                                                      "This field is required",
                                                                      style: TextController
                                                                          .errorText,
                                                                    ),
                                                                  ),
                                                              ],
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
                                                        width: 100,
                                                        color: ColorSelect.buy,
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
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              sendData();
                                                            }

                                                            //  this.search();
                                                          },
                                                          child: Text(
                                                            S
                                                                .of(context)
                                                                .Subscribe,
                                                            style:
                                                                TextController
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

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove any previous formatting characters
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Split the text into integer and decimal parts
    List<String> parts = newText.split('.');
    if (parts.length > 2) {
      // If there are more than one decimal point, remove extras
      newText = parts[0] + '.' + parts.sublist(1).join('');
    }

    // Add commas for thousands separator
    String formattedText = '';
    int counter = 0;
    for (int i = newText.length - 1; i >= 0; i--) {
      formattedText = newText[i] + formattedText;
      counter++;
      if (counter % 3 == 0 && i > 0) {
        formattedText = ',' + formattedText;
      }
    }

    // Add back the decimal part, if it exists
    if (parts.length == 2) {
      formattedText += '.' + parts[1];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
