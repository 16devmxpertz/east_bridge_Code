import 'dart:convert';

import 'package:east_bridge/Fund%20Reedem/FundReedemMainSearchComponent.dart';
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

class FundReedem extends StatefulWidget {
  const FundReedem({super.key});

  @override
  State<FundReedem> createState() => _FundReedemState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);

  static ValueNotifier<int> fundid = new ValueNotifier(0);
}

class _FundReedemState extends State<FundReedem> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //
  bool clientNameError = false;
  bool ClientTypeDropdownvalueError = false;
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

  String? ClientTypeDropdownvalue;

  var ClientTypeItem = [
    'Individual',
    'Corporate',
  ];

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

  int fid = 0;
  _launchURLApp() async {
    var url = Uri.parse(
        "${GlobalPermission.urlLink}/api/generateInvoicereport/getInvoiceReport?fundId=${fid}&clientId=${FundReedem.clientid.value}&type=Redeem");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  var fundMap = {};
  String? fundname;

  void sendData() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundSubscribeRedeem/FundSubscribeRedeem/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      print(fundMap);
      String m = ClientTypeDropdownvalue! + "~" + psv[ClientTypeDropdownvalue];

      var li = fundMap.keys.toList();
      print(m);
      li.forEach((i) {
        print(i);
        bool x = (fundMap[i].split("~")[0] + "~" + fundMap[i].split("~")[2])
                .toString() ==
            m;
        print(x);
        if (x == true) {
          setState(() {
            fid = int.parse(i);
          });
          print(fid);
          print("yessssssss");
        }
        // fid = int.parse(li[i]);
      });

      print("________________");
      var body = {
        "clientId": FundReedem.clientid.value,
        "fundId": fid,
        "fundName": ClientTypeDropdownvalue!.split("~")[0],
        "type": "Redemption",
        "date": date.text,
        "perShareValue": double.parse(PerShareValue.text.replaceAll(",", "")),
        "noOfShare": int.parse(NoOfShares.text.replaceAll(",", "")),
      };

      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // _launchURLApp();
        // print(jsonDecode(response.body));
        Fluttertoast.showToast(
          msg: "Fund Redeemed Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          clientName.text = "";
          FundReedem.name.value = "";
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => new FundReedem()));
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
        'https://localhost:44323/api/GetFundsByClientID/FundsByClientID?id=${FundReedem.clientid.value}');
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GetFundsByClientID/FundsByClientID?id=${FundReedem.clientid.value}');

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

  late Map<String, dynamic> permission = {};

  void a() async {
    var data = await GlobalPermission.formPermission("Fund Redemption");
    setState(() {
      permission = data;
    });
  }

  int amnt = 0;
  int currentValue = 0;
  @override
  void initState() {
    super.initState();
    NoOfShares.text = "0";
    // Setting the initial value for the field.
    print(FundReedem.name.value);

    setState(() {
      clientName.text = FundReedem.name.value;
    });
    getFundList();
    a();
  }

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
                                            builder: (context) => FundReedem(),
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
                                                      "Fund Redemption",
                                                      style: TextController
                                                          .MainHeadingText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FundReedemMainSearchComponent(),
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
                                                              .ClientName,
                                                          style: TextController
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
                                                                  readOnly:
                                                                      false,
                                                                  textAlignVertical:
                                                                      TextAlignVertical
                                                                          .center,
                                                                  onChanged:
                                                                      (value) {
                                                                    getFundList();
                                                                  },
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
                                                                          .none,
                                                                      errorStyle:
                                                                          TextStyle(
                                                                              height: 0)),
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
                                                              .FundName,
                                                          style: TextController
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
                                                                      ClientTypeDropdownvalue,
                                                                  isExpanded:
                                                                      true,
                                                                  underline:
                                                                      Container(),
                                                                  iconEnabledColor:
                                                                      ColorSelect
                                                                          .east_dark_blue,
                                                                  items: f1.map(
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
                                                                        print(
                                                                            fundMap);

                                                                        ClientTypeDropdownvalue =
                                                                            newValue;

                                                                        double
                                                                            p =
                                                                            double.parse(psv[ClientTypeDropdownvalue]);

                                                                        String formattedAmount = ThousandsSeparatorInputFormatter()
                                                                            .formatEditUpdate(
                                                                              TextEditingValue(),
                                                                              TextEditingValue(text: p.toStringAsFixed(2)), // Format with two decimal places
                                                                            )
                                                                            .text;

                                                                        PerShareValue.text =
                                                                            formattedAmount;
                                                                        print(
                                                                            psv);
                                                                        print(PerShareValue
                                                                            .text);
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              if (ClientTypeDropdownvalueError)
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
                                                          S.of(context).Date,
                                                          style: TextController
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
                                                                      isDense: true,
                                                                      hintText: S.of(context).DateFormat,
                                                                      hintStyle: TextController.labelText,
                                                                      errorStyle: TextStyle(height: 0),
                                                                      border: InputBorder.none),
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
                                                                            DateTime(3000));
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
                                                                )
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
                                                          "Per Unit Value",
                                                          style: TextController
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
                                                                      PerShareValue,
                                                                  readOnly:
                                                                      false,
                                                                  onChanged:
                                                                      (value) {
                                                                    value =
                                                                        PerShareValue
                                                                            .text;
                                                                    setState(
                                                                        () {
                                                                      currentValue =
                                                                          int.parse(value.replaceAll(
                                                                              ",",
                                                                              ""));
                                                                      double
                                                                          amount =
                                                                          (currentValue *
                                                                              double.parse(NoOfShares.text.replaceAll(",", "")));
                                                                      String
                                                                          formattedAmount =
                                                                          ThousandsSeparatorInputFormatter()
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
                                                                  decoration: InputDecoration(
                                                                      errorStyle: TextStyle(
                                                                          height:
                                                                              0),
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
                                                          "No Of Units",
                                                          style: TextController
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
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: ColorSelect
                                                                            .textField)),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Flexible(
                                                                        child:
                                                                            TextFormField(
                                                                      controller:
                                                                          NoOfShares,
                                                                      inputFormatters: <
                                                                          TextInputFormatter>[
                                                                        FilteringTextInputFormatter
                                                                            .digitsOnly,
                                                                        ThousandsSeparatorInputFormatter(),
                                                                      ],
                                                                      textAlignVertical:
                                                                          TextAlignVertical
                                                                              .center,
                                                                      onChanged:
                                                                          (value) {
                                                                        value =
                                                                            NoOfShares.text;
                                                                        setState(
                                                                            () {
                                                                          currentValue = int.parse(value.replaceAll(
                                                                              ",",
                                                                              ""));
                                                                          double
                                                                              amount =
                                                                              (currentValue * double.parse(PerShareValue.text.replaceAll(",", "")));

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
                                                                      style: TextController
                                                                          .BodyHeadingText,
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          setState(
                                                                              () {
                                                                            NoOfSharesError =
                                                                                true;
                                                                          });
                                                                          return "";
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          NoOfSharesError =
                                                                              false;
                                                                        });
                                                                        return null;
                                                                      },
                                                                      decoration:
                                                                          InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        errorStyle:
                                                                            TextStyle(height: 0),
                                                                        hintText:
                                                                            '0',
                                                                        hintStyle:
                                                                            TextController.labelText,
                                                                        border:
                                                                            InputBorder.none,
                                                                      ),
                                                                    )),
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
                                                                          children: <
                                                                              Widget>[
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
                                                                                  currentValue--;
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
                                                          S.of(context).Amount,
                                                          style: TextController
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
                                                                      errorStyle: TextStyle(
                                                                          height:
                                                                              0),
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
                                                      color: ColorSelect.sell,
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
                                                                  .currentState !=
                                                              null) {
                                                            setState(() {
                                                              ClientTypeDropdownvalueError =
                                                                  ClientTypeDropdownvalue ==
                                                                      null;
                                                            });
                                                          }
                                                          if (_formKey
                                                                  .currentState!
                                                                  .validate() &&
                                                              !ClientTypeDropdownvalueError) {
                                                            if ((int.parse(NoOfShares
                                                                    .text
                                                                    .replaceAll(
                                                                        ",",
                                                                        "")) >
                                                                (int.parse(numberShare!
                                                                    .replaceAll(
                                                                        ",",
                                                                        ""))))) {
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "Client doesn't have ${NoOfShares.text} shares",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .CENTER,
                                                                  timeInSecForIosWeb:
                                                                      3,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                            } else {
                                                              sendData();
                                                            }
                                                          }
                                                          //_launchURLApp();
                                                        },
                                                        child: Text(
                                                          S.of(context).Reedem,
                                                          style: TextController
                                                              .btnText,
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

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final nonDigitChars = RegExp(r'[^\d.]');
    final cleanText = newValue.text.replaceAll(nonDigitChars, '');
    final parts = cleanText.split('.');

    // Handle integer part
    String integerPart = parts[0];
    if (integerPart.isNotEmpty) {
      integerPart = int.parse(integerPart).toString();
    }

    // Handle decimal part
    String decimalPart = parts.length > 1 ? '.' + parts[1] : '';
    if (decimalPart.length > 3) {
      decimalPart = decimalPart.substring(0, 3); // Limit to two decimal places
    }

    final formattedValue = '$integerPart$decimalPart';

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
