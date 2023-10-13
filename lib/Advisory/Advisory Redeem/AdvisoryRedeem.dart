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

class AdvisoryRedeems extends StatefulWidget {
  const AdvisoryRedeems({super.key});

  @override
  State<AdvisoryRedeems> createState() => _AdvisoryRedeemsState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<String> fundname = new ValueNotifier("");
  static ValueNotifier<String> persharevalue = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);

  static ValueNotifier<int> fundid = new ValueNotifier(0);
}

class _AdvisoryRedeemsState extends State<AdvisoryRedeems> {
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

  var keys = [];
  int advisoryId = 0;

  var MileStones = [];
  var MileStonestatus = [];

  // String value = "";
  //int pershare = int.parse(AdvisorySubscribe.persharevalue.value);
  // int noofshare = int.parse(NoOfShares.text);
  // int amnt = int.parse(Amount.text);

  @override
  void initState() {
    super.initState();
    NoOfShares.text = "0";
    //fetchData();
    fetchDataClientId(GlobalPermissionAdvisory.clientIdglobalRedeem);
    print(GlobalPermissionAdvisory.clientIdglobalRedeem);
    print(AdvisoryRedeems.name.value);
    //_calculation();

    setState(() {
      clientName.text = AdvisoryRedeems.name.value;
      fundName.text = AdvisoryRedeems.fundname.value;
      PerShareValue.text = AdvisoryRedeems.persharevalue.value;

      Amount.text = amnt.toString();
      // amnt=pershare * noofshare;
    }); // Setting the initial value for the field.
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
        "http://localhost/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2finvoice&rs:Command=Render&rs:ClearSession=True&rs:Format=PDF&rs:FileExtension=Subscribe.PDF&FID=${AdvisoryRedeems.fundid.value}&CID=${AdvisoryRedeems.clientid.value}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // void sendData() async {
  //   var url = Uri.parse(
  //       '${GlobalPermission.urlLink}/api/AdvisoryRedeemsRedeem/AdvisoryRedeemsRedeem/');

  //   try {
  //     var headers = {
  //       'Content-Type': 'application/json',
  //     };

  //     var body = {
  //       "clientId": AdvisoryRedeems.clientid.value,
  //       "fundId": AdvisoryRedeems.fundid.value,
  //       "fundName": fundName.text,
  //       "type": "Subscribe",
  //       "date": date.text,
  //       "perShareValue": int.parse(AdvisoryRedeems.persharevalue.value),
  //       "noOfShare": int.parse(NoOfShares.text),
  //     };
  //     var response =
  //         await http.post(url, headers: headers, body: jsonEncode(body));

  //     if (response.statusCode == 200) {
  //       _launchURLApp();
  //       Fluttertoast.showToast(
  //           msg: "Send For Approval.",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 3,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       print(jsonDecode(response.body));
  //     } else {
  //       Fluttertoast.showToast(
  //           msg: "Failed To Send.",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 3,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //   } catch (e) {
  //    Fluttertoast.showToast(
  //           msg: "Failed To Send.",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 3,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //   }
  // }

  void milestoneachived(int cid, int aid, int mid) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryMileStone/ClientMileStonAchived?ClientId=$cid&AdvisoryId=$aid&MileStoneNumber=$mid');

    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.put(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "MileStone Achieved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      fetchData(GlobalPermissionAdvisory.clientIdglobalRedeem, advisoryId);
    } else {
      Fluttertoast.showToast(
          msg: "MileStone Failed To Achieve.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void fetchDataClientId(int Id) async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ClientAdvisoiryAgreementLink/GetAdvisoryServicesOfClientByClientId?ClientId=${GlobalPermissionAdvisory.clientIdglobalRedeem}');

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

  String getFormattedDateOrDelayed(String inputDate) {
    try {
      // Split the input date
      List<String> dateParts = inputDate.split("~");

      // Extract the date part
      String dateStr = dateParts[3].split(" ")[0];
      print(dateStr);
      // Parse the date
      DateFormat format = DateFormat("dd/MM/yyyy");
      DateTime parsedDate = format.parse(dateStr);
      print(parsedDate);
      // Compare with current date
      DateTime currentDate = DateTime.now();

      if (currentDate.isBefore(parsedDate)) {
        return DateFormat('dd-MM-yyyy').format(parsedDate);
      } else {
        return DateFormat('dd-MM-yyyy').format(parsedDate) + " (Delayed)";
      }
    } catch (e) {
      // Handle any parsing or formatting errors here
      print(e);
      return "Invalid Date"; // Return a default value for invalid input
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
                                                      S
                                                          .of(context)
                                                          .AdvisoryActivityUpdate,
                                                      style: TextController
                                                          .MainHeadingText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            AdvisoryRedeemMainSearchComponent(),
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
                                                              .ServiceName,
                                                          style: TextController
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
                                                                  advisoryname,
                                                              isExpanded: true,
                                                              underline:
                                                                  Container(),
                                                              iconEnabledColor:
                                                                  ColorSelect
                                                                      .east_dark_blue,
                                                              items: list1.map(
                                                                (String items) {
                                                                  return DropdownMenuItem(
                                                                    value:
                                                                        items,
                                                                    child: Text(
                                                                      items,
                                                                      style: TextController
                                                                          .BodyText,
                                                                    ),
                                                                  );
                                                                },
                                                              ).toList(),
                                                              onChanged:
                                                                  (newValue) {
                                                                setState(
                                                                  () {
                                                                    advisoryname =
                                                                        newValue;
                                                                    int x = list
                                                                        .indexOf(
                                                                            advisoryname);
                                                                    advisoryId =
                                                                        int.parse(
                                                                            keys[x]);
                                                                    print(
                                                                        "Id Chahiye");
                                                                    print(
                                                                        advisoryId);
                                                                    print(
                                                                        "Id Chahiye");
                                                                    fetchData(
                                                                        GlobalPermissionAdvisory
                                                                            .clientIdglobalRedeem,
                                                                        advisoryId);
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
                                                              //   initialValue: AdvisorySubscribe.name.value,
                                                              controller:
                                                                  clientName,
                                                              readOnly: true,
                                                              textAlignVertical:
                                                                  TextAlignVertical
                                                                      .center,
                                                              style: TextController
                                                                  .BodyHeadingText,
                                                              decoration: InputDecoration(
                                                                  isDense: true,
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
                                                              textAlignVertical:
                                                                  TextAlignVertical
                                                                      .center,
                                                              style: TextController
                                                                  .BodyHeadingText,
                                                              controller: date,
                                                              decoration:
                                                                  InputDecoration(
                                                                      suffixIcon:
                                                                          Icon(
                                                                        Icons
                                                                            .calendar_month_outlined,
                                                                        size:
                                                                            15,
                                                                      ),
                                                                      isDense:
                                                                          true,
                                                                      hintText: S
                                                                          .of(
                                                                              context)
                                                                          .DateFormat,
                                                                      hintStyle:
                                                                          TextController
                                                                              .labelText,
                                                                      border: InputBorder
                                                                          .none),
                                                              //readOnly: true,
                                                              onTap: () async {
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
                                                                        DateTime
                                                                            .now());
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
                                                                      .addPostFrameCallback((_) => setState((date.text =
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
                                                              .start,
                                                      children: [
                                                        // Text(
                                                        //   S
                                                        //       .of(context)
                                                        //       .TotalValue,
                                                        //   style: TextController
                                                        //       .BodyText,
                                                        // ),
                                                        SizedBox(
                                                          width: 66,
                                                        ),
                                                        // Flexible(
                                                        //   child: Container(
                                                        //     padding: EdgeInsets
                                                        //         .symmetric(
                                                        //             horizontal:
                                                        //                 10),
                                                        //     width: 280,
                                                        //     height: 35,
                                                        //     alignment: Alignment
                                                        //         .centerLeft,
                                                        //     decoration: BoxDecoration(
                                                        //         color: Colors
                                                        //             .white,
                                                        //         border: Border.all(
                                                        //             color: ColorSelect
                                                        //                 .textField)),
                                                        //     child:
                                                        //         TextFormField(
                                                        //       readOnly: true,
                                                        //       controller:
                                                        //           PerShareValue,
                                                        //       inputFormatters: <
                                                        //           TextInputFormatter>[
                                                        //         FilteringTextInputFormatter
                                                        //             .digitsOnly
                                                        //       ],
                                                        //       textAlignVertical:
                                                        //           TextAlignVertical
                                                        //               .center,
                                                        //       style: TextController
                                                        //           .BodyHeadingText,
                                                        //       decoration: InputDecoration(
                                                        //           isDense: true,
                                                        //           hintText: S
                                                        //               .of(
                                                        //                   context)
                                                        //               .TypeHere,
                                                        //           hintStyle:
                                                        //               TextController
                                                        //                   .labelText,
                                                        //           border:
                                                        //               InputBorder
                                                        //                   .none),
                                                        //     ),
                                                        //   ),
                                                        // ),
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
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color:
                                                        ColorSelect.east_grey,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              // child: Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.end,
                                              //   children: [
                                              //     Flexible(
                                              //       child: Container(
                                              //         height: 35,
                                              //         // width: 220,
                                              //         color:
                                              //             ColorSelect.east_blue,
                                              //         child: TextButton(
                                              //           style: TextButton
                                              //               .styleFrom(
                                              //             side: BorderSide(
                                              //               width: 1.0,
                                              //               color: Color(
                                              //                   0xFFE7C7C7),
                                              //             ),
                                              //             shape:
                                              //                 RoundedRectangleBorder(
                                              //               borderRadius:
                                              //                   BorderRadius
                                              //                       .circular(
                                              //                           0),
                                              //             ),
                                              //           ),
                                              //           onPressed: () {

                                              //              //sendData();

                                              //             //_launchURLApp();
                                              //             //  this.search();
                                              //           },
                                              //           child: Text(
                                              //             S
                                              //                 .of(context)
                                              //                 .SendRequest,
                                              //             style: TextController
                                              //                 .btnTextred,
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            Container(
                                              width: 1000,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: Table(
                                                border: TableBorder.all(
                                                    color: ColorSelect
                                                        .tabBorderColor),
                                                defaultVerticalAlignment:
                                                    TableCellVerticalAlignment
                                                        .middle,
                                                columnWidths: {
                                                  0: FlexColumnWidth(0.5),
                                                  1: FlexColumnWidth(1.5),
                                                  2: FlexColumnWidth(1.5),
                                                  3: FlexColumnWidth(1.5)
                                                },
                                                children: [
                                                  TableRow(children: [
                                                    Container(
                                                        height: 50,
                                                        child: Center(
                                                            child: Text(
                                                          "Milestone Number",
                                                          style: TextController
                                                              .BodyHeadingText,
                                                        ))),
                                                    Container(
                                                        height: 50,
                                                        child: Center(
                                                            child: Text(
                                                          "Milestone Description",
                                                          style: TextController
                                                              .BodyHeadingText,
                                                        ))),
                                                    Container(
                                                        height: 50,
                                                        child: Center(
                                                            child: Text(
                                                          "Expected End Date",
                                                          style: TextController
                                                              .BodyHeadingText,
                                                        ))),
                                                    Container(
                                                        height: 50,
                                                        child: Center(
                                                            child: Text(
                                                          "Status",
                                                          style: TextController
                                                              .BodyHeadingText,
                                                        ))),
                                                  ]),
                                                ],
                                              ),
                                            ),

                                            SingleChildScrollView(
                                              child: Container(
                                                // height: 800,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: MileStones.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return GestureDetector(
                                                        onTap: () {},
                                                        child: table(
                                                            context, index));
                                                  },
                                                ),
                                              ),
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  height: 35,
                                                  // width: 220,
                                                  // color: ColorSelect.east_blue,
                                                  // child: TextButton(
                                                  //   style: TextButton.styleFrom(
                                                  //     side: BorderSide(
                                                  //       width: 1.0,
                                                  //       color:
                                                  //           Color(0xFFE7C7C7),
                                                  //     ),
                                                  //     shape:
                                                  //         RoundedRectangleBorder(
                                                  //       borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(0),
                                                  //     ),
                                                  //   ),
                                                  //   onPressed: () {
                                                  //     // sendData();
                                                  //     //_launchURLApp();
                                                  //     //  this.search();
                                                  //   },
                                                  //   child: Text(
                                                  //     S.of(context).Submit,
                                                  //     style: TextController
                                                  //         .btnTextred,
                                                  //   ),
                                                  // ),
                                                ),
                                              ],
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

  Widget table(BuildContext context, int index) {
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
                columnWidths: {
                  0: FlexColumnWidth(0.5),
                  1: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(1.5),
                  3: FlexColumnWidth(1.5)
                },
                children: [
                  TableRow(children: [
                    Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          "${MileStonestatus[index].split("~")[1]}",
                          style: TextController.BodyText,
                        ))),
                    Container(
                        height: 50,
                        child: Center(
                            child: Text(
                          "${MileStones[index]}",
                          style: TextController.BodyText,
                        ))),
                    Container(
                      height: 50,
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            print("MileStonestatus[index]");
                            print(MileStonestatus[index]);
                          },
                          child: Text(
                            getFormattedDateOrDelayed(MileStonestatus[index]),
                            style: TextController.BodyText,
                          ),
                        ),
                      ),
                    ),
                    if (MileStonestatus[index].split("~")[0] == "False")
                      Container(
                        child: Center(
                          child: Checkbox(
                            value: false,
                            onChanged: (bool? value) async {
                              await GlobalPermission.formApproval(
                                  "MileStone Achived",
                                  GlobalPermissionAdvisory.clientIdglobalRedeem,
                                  AdvisoryRedeems.name.value,
                                  int.parse(
                                      MileStonestatus[index].split("~")[1]));

                              milestoneachived(
                                  GlobalPermissionAdvisory.clientIdglobalRedeem,
                                  advisoryId,
                                  int.parse(
                                      MileStonestatus[index].split("~")[1]));
                            },
                          ),
                        ),
                      )
                    else
                      Container(
                        child: Center(
                          child: Text(
                            "Achieved",
                            style: TextController.BodyText,
                          ),
                        ),
                      ),
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
