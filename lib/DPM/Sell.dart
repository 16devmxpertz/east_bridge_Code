import 'dart:convert';
import 'package:east_bridge/DPM/Buy.dart';
import 'package:east_bridge/DPM/DPMSellMainSearchComponent.dart';
import 'package:east_bridge/Global.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class DPMSell extends StatefulWidget {
  const DPMSell({super.key});

  @override
  State<DPMSell> createState() => _DPMSellState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);

  static ValueNotifier<int> fundid = new ValueNotifier(0);
}

class _DPMSellState extends State<DPMSell> {
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
  String perNewvalue = "";
  String perNewvalue2 = "";

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

  var fid;
  _launchURLApp() async {
    var url = Uri.parse(
        "${GlobalPermission.urlLink}/api/getinvoiceForDPM/getInvoiceReportDPM?shareId=${int.parse(fid)}&clientId=${DPMSell.clientid.value}&type=Redeem");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  var fundMap = {};
  String? fundname;
  int id = 0;

  void sendData() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ShareSubscriberedeemHistory/ShareSubscribeRedeem/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };
      print("FinalMappp");
      print(fundMap);
      String m = ClientTypeDropdownvalue! +
          "~" +
          psv[ClientTypeDropdownvalue] +
          "~" +
          psv2[ClientTypeDropdownvalue];

      print(ClientTypeDropdownvalue! + " " + psv[ClientTypeDropdownvalue]);

      var li = fundMap.keys.toList();

      li.forEach((i) {
        if (fundMap[i] == m) {
          fid = i;
        }
      });
      print(fid);
      print("222222222");

      var body = {
        "clientId": DPMSell.clientid.value,
        "shareId": int.parse(fid),
        "shareName": ClientTypeDropdownvalue!.split(" ")[0],
        "type": "Sell",
        "date": date.text,
        "perShareValue": double.parse(PerShareValue.text.replaceAll(",", "")),
        "noOfShare": double.parse(NoOfShares.text.replaceAll(",", "")),
      };

      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        setState(() {
          id = jsonDecode(response.body);
        });

        GlobalPermission.formApproval(
            "Product Invoice", DPMSell.clientid.value, DPMSell.name.value, id);
        Fluttertoast.showToast(
            msg: "Request successfully sent",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // _launchURLApp();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DPMSell()));
        setState(() {
          DPMSell.clientid.value = 0;
          DPMSell.name.value = "";

          fid = 0;
          f1.clear();
          Amount.text = "";
          NoOfShares.text = "";
          fundName.text = "";
          date.text = "";
          clientName.text = "";
        });

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

  var f1 = ["Please Search Client First"];
  var f2 = ["Please Search Client First"];
  var fundlist = [];

  var psv = {};
  var psv2 = {};

  List fundListkey = [];
  var key = {};
  void getFundList() async {
    print("clientid-------------");
    print(
        'https://eastbridge.online/apicore/api/GetDPMSharesOfClientByClientId/GetShareListByClientId?id=${DPMSell.clientid.value}');
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GetDPMSharesOfClientByClientId/GetShareListByClientId?id=${DPMSell.clientid.value}');

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
          for (String i in fundlist) {
            f1.add(i.split("~")[0]);
            psv[i.split("~")[0]] = i.split("~")[1];
            psv2[i.split("~")[0]] = i.split("~")[2];
          }

          fundListkey = fundMap.keys.toList();
        });
        print("------f--");
        print(fundMap);
        print(psv);
        print("____f1_");
        print(f1);
        print("-------fl---done");
        print(fundlist);

        print("------kyy----done");
        print(fundListkey);
        print(responseData);
        print("------dropdownvalue____");

        print(psv[ClientTypeDropdownvalue]);
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

  int amnt = 0;
  double currentValue = 0;
  @override
  void initState() {
    super.initState();
    NoOfShares.text = "0";
    // Setting the initial value for the field.
    print(DPMSell.name.value);

    setState(() {
      clientName.text = DPMSell.name.value;
    });
    getFundList();
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
                                                      S.of(context).DPMSell,
                                                      style: TextController
                                                          .MainHeadingText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            DPMSellMainSearchComponent(),
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
                                                                  // readOnly: true,
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
                                                              .ProductName,
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
                                                                        // print(
                                                                        //     fundMap);
                                                                        // print(psv[
                                                                        //     ClientTypeDropdownvalue]);
                                                                        print(
                                                                            "MAPPPPPPPP");
                                                                        print(
                                                                            psv);
                                                                        ClientTypeDropdownvalue =
                                                                            newValue;
                                                                        print(
                                                                            ClientTypeDropdownvalue);
                                                                        perNewvalue =
                                                                            psv[ClientTypeDropdownvalue];
                                                                        // PerShareValue
                                                                        //         .text =
                                                                        //     perNewvalue
                                                                        //         .split(
                                                                        //             "~")[0];
                                                                        // perNewvalue2 =
                                                                        //     perNewvalue
                                                                        //         .split(
                                                                        //             "~")[1];

                                                                        double
                                                                            p =
                                                                            double.parse(perNewvalue.split("~")[0]);

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
                                                                      errorStyle: TextStyle(height: 0),
                                                                      suffixIcon: Icon(
                                                                        Icons
                                                                            .calendar_month_outlined,
                                                                        size:
                                                                            15,
                                                                      ),
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
                                                          // S
                                                          //     .of(context)
                                                          //     .PerShareValue,
                                                          "Price",
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
                                                                  onChanged:
                                                                      (value) {
                                                                    value =
                                                                        PerShareValue
                                                                            .text;
                                                                    setState(
                                                                        () {
                                                                      currentValue =
                                                                          double.parse(value.replaceAll(
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
                                                                  // readOnly: true,
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
                                                          "Quantity",
                                                          // S
                                                          //     .of(context)
                                                          //     .NoOfShares,
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
                                                                            TextAlignVertical.center,
                                                                        onChanged:
                                                                            (value) {
                                                                          value =
                                                                              NoOfShares.text;
                                                                          setState(
                                                                              () {
                                                                            currentValue =
                                                                                double.parse(value.replaceAll(",", ""));
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
                                                                            setState(() {
                                                                              NoOfSharesError = true;
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
                                                                        decoration: InputDecoration(
                                                                            errorStyle:
                                                                                TextStyle(height: 0),
                                                                            isDense: true,
                                                                            hintText: '0',
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
                                                                (int.parse(psv2[
                                                                    ClientTypeDropdownvalue])))) {
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
                                                          S.of(context).Sell,
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
