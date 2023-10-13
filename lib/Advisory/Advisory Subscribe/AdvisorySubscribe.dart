import 'dart:convert';

import 'package:east_bridge/Advisory/Advisory%20Subscribe/AdvisorySubscribeMainSearchComponent.dart';
import 'package:east_bridge/Advisory/AdvisoryGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AdvisorySubscribes extends StatefulWidget {
  const AdvisorySubscribes({super.key});

  @override
  State<AdvisorySubscribes> createState() => _AdvisorySubscribesState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<String> fundname = new ValueNotifier("");
  static ValueNotifier<String> serviceName = new ValueNotifier("");
  static ValueNotifier<String> date = new ValueNotifier("");
  static ValueNotifier<int> totalValue = new ValueNotifier(0);
  static ValueNotifier<int> duration = new ValueNotifier(0);

  static ValueNotifier<String> persharevalue = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);
  static ValueNotifier<int> id = new ValueNotifier(0);

  static ValueNotifier<int> fundid = new ValueNotifier(0);
}

class _AdvisorySubscribesState extends State<AdvisorySubscribes> {
  TextEditingController fundName = new TextEditingController();

  TextEditingController clientName = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController Amount = new TextEditingController();
  TextEditingController DurationofAdvisory = new TextEditingController();
  TextEditingController _TotalValue = new TextEditingController();
  TextEditingController _valueOfService = new TextEditingController();

  TextEditingController _duration = new TextEditingController();
  TextEditingController StartDate = new TextEditingController();
  TextEditingController EndDate = new TextEditingController();
  TextEditingController milestoneDuration = new TextEditingController();

  int amnt = 0;
  int currentValue = 0;

  List itemList = [
    "Item 1",
    "Item 2",
    "Item 3",
  ];
  // String value = "";
  //int pershare = int.parse(AdvisorySubscribes.persharevalue.value);
  // int noofshare = int.parse(NoOfShares.text);
  // int amnt = int.parse(Amount.text);

  multiple(int d) {
    _valueOfService.text =
        ((int.parse(_TotalValue.text) / int.parse(_duration.text)) * d)
            .toString();

    print(_duration.text);
    print(_TotalValue.text);
    print(d);
    print(_valueOfService.text);
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
        "http://localhost/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2finvoice&rs:Command=Render&rs:ClearSession=True&rs:Format=PDF&rs:FileExtension=Subscribe.PDF&FID=${AdvisorySubscribes.fundid.value}&CID=${AdvisorySubscribes.clientid.value}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  downloadpdf() async {
    var url = Uri.parse(
        "${GlobalPermission.urlLink}/api/AdvisoryFetchAgreementPDf/FetchAdvisoryPDF?ClientId=${AdvisorySubscribes.clientid.value}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List<dynamic> list = [];
  var list1 = ["seleect client first"];
  var list2 = ["seleect client first"];
  List<dynamic> list3 = ["seleect Advisory Manager"];
  var list4 = ["seleect client first"];
  var keys = [];

  int advisoryId = 0;
  String? advisoryname;
  String? advisorymanager;
  void sendData(int ClientId, int AdvisoryId) async {
    if (advisoryId == 0) {
      Fluttertoast.showToast(
          msg: "Fail to Start",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return;
    }
    print("datasendinggg startttt");
    print(AdvisoryId);
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ClientAdvisoiryAgreementLink/ClientAdvisoryServiceStart?ClientId=$ClientId&AdvisoryId=$AdvisoryId');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var response = await http.get(url);
      if (response.statusCode == 200) {
        AssignAdvisoryManager();
        // _launchURLApp();
      } else {
        Fluttertoast.showToast(
            msg: "Fail to Start",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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

  int finalpmid = 0;
  void AssignAdvisoryManager() async {
    print('assigning manager');
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/PortFolioManagerClientRelation/PortFolioManagerClientRelation/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "pmId": finalpmid,
        "clientId": AdvisorySubscribes.clientid.value
      };
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Manager Assigned",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Fluttertoast.showToast(
            msg: "Service Started",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdvisorySubscribes(),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Fail to Start",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Fail to Start",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  List<int> milestoneIds = [];
  List<String> startdatefinal = [];
  List<String> enddatefinal = [];
  List<String> adviorymanagerkeys = [];
  void SetDate(int ClientId, int AdvisoryId) async {
    setState(() {
      print("dates updating");
      startdatefinal.clear();
      enddatefinal.clear();
      milestoneIds.clear();
      for (int i = 0; i < MileStones.length; i++) {
        print(i);
        startdatefinal.add(startDates[i].text);
        enddatefinal.add(endDate[i].text);
        milestoneIds.add(int.parse(MileStonestatus[i].split("~")[1]));
      }
    });

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryMileStone/SetDateForMileStone');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "ClientId": AdvisorySubscribes.clientid.value,
      "AdvisoryId": AdvisoryId,
      "mileStoneId": milestoneIds,
      "StartDate": startdatefinal,
      "endDate": enddatefinal
    };
    print(body);

    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Contact is Updating");

      sendData(AdvisorySubscribes.clientid.value, advisoryId);
      // Process the response data if needed
      // print(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  //${GlobalPermission.urlLink}/api/GetPortfolioManager/GetPortfolioManager'

  void GetAdvisoryManager() async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GetPortfolioManager/GetPortfolioManager');

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

      list3 = responseData.values.toList();
      adviorymanagerkeys = responseData.keys.toList();
      list4.clear();
      print(list3);
      setState(() {
        for (String i in list3) {
          list4.add(i + "");
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

  var f1 = ["Please Search Client First"];
  var f2 = ["Please Search Client First"];

  void fetchData(int Id) async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ClientAdvisoiryAgreementLink/GetAdvisoryServicesOfClientByClientId?ClientId=${AdvisorySubscribes.clientid.value}');

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

  var MileStones = [];
  var MileStonestatus = [];
  List<TextEditingController> startDates = [];
  List<TextEditingController> endDate = [];
  var duration = [];

  Future fetchDatamilestone(int cid, int aid) async {
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
        for (int i = 0; i < x.length; i++) {
          startDates.add(TextEditingController(text: ""));
          endDate.add(TextEditingController(text: ""));
        }
        MileStones.clear();
        MileStonestatus.clear();
        MileStones = x.keys.toList();
        MileStonestatus = x.values.toList();
      });
    } else {
      print("error");
    }
  }

  @override
  void initState() {
    super.initState();
    NoOfShares.text = "0";
    print(AdvisorySubscribes.clientid.value);
    print("fetch Working");
    print(AdvisorySubscribes.clientid.value);
    fetchData(AdvisorySubscribes.clientid.value);
    GetAdvisoryManager();

    print("fetch Working");

    //_calculation();

    setState(() {
      clientName.text = AdvisorySubscribes.name.value;
      fundName.text = AdvisorySubscribes.fundname.value;
      PerShareValue.text = AdvisorySubscribes.persharevalue.value;
      _duration.text = AdvisorySubscribes.duration.value.toString();
      _TotalValue.text = AdvisorySubscribes.totalValue.value.toString();
      print("=======++============");
      print(_duration.text);
      print("=======++============");
      Amount.text = amnt.toString();
      // amnt=pershare * noofshare;
    }); // Setting the initial value for the field.
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
                                                          .AdvisoryServiceInitiation,
                                                      style: TextController
                                                          .MainHeadingText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            AdvisorySubscribeMainSearchComponent(),
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
                                                                    advisoryId =
                                                                        int.parse(
                                                                            keys[x]);

                                                                    fetchDatamilestone(
                                                                        AdvisorySubscribes
                                                                            .clientid
                                                                            .value,
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
                                                              //   initialValue: AdvisorySubscribes.name.value,
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
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .AdvisoryManager,
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
                                                                  advisorymanager,
                                                              isExpanded: true,
                                                              underline:
                                                                  Container(),
                                                              iconEnabledColor:
                                                                  ColorSelect
                                                                      .east_dark_blue,
                                                              items: list4.map(
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
                                                                    advisorymanager =
                                                                        newValue;
                                                                    String x =
                                                                        "";
                                                                    if (advisorymanager !=
                                                                        null) {
                                                                      x = advisorymanager!;
                                                                    }
                                                                    int r = list4
                                                                        .indexOf(
                                                                            x);
                                                                    finalpmid =
                                                                        int.parse(
                                                                            adviorymanagerkeys[r]);
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
                                                        Container(),
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
                                                        Container(),
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
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 1000,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: Table(
                                                      border: TableBorder.all(
                                                          color: ColorSelect
                                                              .tabBorderColor),
                                                      defaultVerticalAlignment:
                                                          TableCellVerticalAlignment
                                                              .middle,
                                                      columnWidths: {
                                                        0: FlexColumnWidth(1.5),
                                                        1: FlexColumnWidth(1),
                                                        2: FlexColumnWidth(1),
                                                        3: FlexColumnWidth(1),
                                                      },
                                                      children: [
                                                        TableRow(
                                                          children: [
                                                            Container(
                                                              height: 50,
                                                              child: Center(
                                                                child: Text(
                                                                  "Milestone Name",
                                                                  style: TextController
                                                                      .BodyHeadingText,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              child: Center(
                                                                child: Text(
                                                                  "Start Date",
                                                                  style: TextController
                                                                      .BodyHeadingText,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              child: Center(
                                                                child: Text(
                                                                  "Duration",
                                                                  style: TextController
                                                                      .BodyHeadingText,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 50,
                                                              child: Center(
                                                                child: Text(
                                                                  "End Date",
                                                                  style: TextController
                                                                      .BodyHeadingText,
                                                                ),
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
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            MileStones.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          return table(
                                                              index, context);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Container(
                                            //   margin: EdgeInsets.symmetric(
                                            //     horizontal: 10,
                                            //   ),
                                            //   padding: EdgeInsets.symmetric(
                                            //       vertical: 10),
                                            //   width: double.infinity,
                                            //   decoration: BoxDecoration(
                                            //     border: Border(
                                            //       bottom: BorderSide(
                                            //         color:
                                            //             ColorSelect.east_grey,
                                            //         width: 1,
                                            //       ),
                                            //     ),
                                            //   ),
                                            //   child: Row(
                                            //     children: [
                                            //       Flexible(
                                            //         child: Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .start,
                                            //           children: [
                                            //             // Text(
                                            //             //   S
                                            //             //       .of(context)
                                            //             //       .ValueOfService,
                                            //             //   style: TextController
                                            //             //       .BodyText,
                                            //             // ),
                                            //             // SizedBox(
                                            //             //   width: 32,
                                            //             // ),
                                            //             // Flexible(
                                            //             //   child: Container(
                                            //             //     padding: EdgeInsets
                                            //             //         .symmetric(
                                            //             //             horizontal:
                                            //             //                 10),
                                            //             //     width: 350,
                                            //             //     height: 35,
                                            //             //     alignment: Alignment
                                            //             //         .centerLeft,
                                            //             //     decoration: BoxDecoration(
                                            //             //         color: Colors
                                            //             //             .white,
                                            //             //         border: Border.all(
                                            //             //             color: ColorSelect
                                            //             //                 .textField)),
                                            //             //     child:
                                            //             //         TextFormField(
                                            //             //       readOnly: true,
                                            //             //       controller:
                                            //             //           _TotalValue,
                                            //             //       inputFormatters: <
                                            //             //           TextInputFormatter>[
                                            //             //         FilteringTextInputFormatter
                                            //             //             .digitsOnly
                                            //             //       ],
                                            //             //       textAlignVertical:
                                            //             //           TextAlignVertical
                                            //             //               .center,
                                            //             //       style: TextController
                                            //             //           .BodyHeadingText,
                                            //             //       decoration: InputDecoration(
                                            //             //           isDense: true,
                                            //             //           hintText: S
                                            //             //               .of(
                                            //             //                   context)
                                            //             //               .TypeHere,
                                            //             //           hintStyle:
                                            //             //               TextController
                                            //             //                   .labelText,
                                            //             //           border:
                                            //             //               InputBorder
                                            //             //                   .none),
                                            //             //     ),
                                            //             //   ),
                                            //             // ),
                                            //             SizedBox(
                                            //               width: 35,
                                            //             ),
                                            //             // Text(
                                            //             //   S
                                            //             //       .of(context)
                                            //             //       .DurationofAdvisory,
                                            //             //   style: TextController
                                            //             //       .BodyText,
                                            //             // ),
                                            //             // SizedBox(
                                            //             //   width: 66,
                                            //             // ),
                                            //             // Flexible(
                                            //             //   child: Container(
                                            //             //     padding: EdgeInsets
                                            //             //         .symmetric(
                                            //             //             horizontal:
                                            //             //                 10),
                                            //             //     width: 280,
                                            //             //     height: 35,
                                            //             //     alignment: Alignment
                                            //             //         .centerLeft,
                                            //             //     decoration: BoxDecoration(
                                            //             //         color: Colors
                                            //             //             .white,
                                            //             //         border: Border.all(
                                            //             //             color: ColorSelect
                                            //             //                 .textField)),
                                            //             //     child:
                                            //             //         TextFormField(
                                            //             //       onChanged:
                                            //             //           (value) {
                                            //             //         multiple(
                                            //             //             int.parse(
                                            //             //                 value));
                                            //             //       },
                                            //             //       initialValue:
                                            //             //           0.toString(),
                                            //             //       inputFormatters: <
                                            //             //           TextInputFormatter>[
                                            //             //         FilteringTextInputFormatter
                                            //             //             .digitsOnly
                                            //             //       ],
                                            //             //       textAlignVertical:
                                            //             //           TextAlignVertical
                                            //             //               .center,
                                            //             //       style: TextController
                                            //             //           .BodyHeadingText,
                                            //             //       decoration: InputDecoration(
                                            //             //           isDense: true,
                                            //             //           hintText: S
                                            //             //               .of(
                                            //             //                   context)
                                            //             //               .TypeHere,
                                            //             //           hintStyle:
                                            //             //               TextController
                                            //             //                   .labelText,
                                            //             //           border:
                                            //             //               InputBorder
                                            //             //                   .none),
                                            //             //     ),
                                            //             //   ),
                                            //             // ),
                                            //             SizedBox(
                                            //               width: 15,
                                            //             ),
                                            //             Text(
                                            //               S
                                            //                   .of(context)
                                            //                   .TotalValue,
                                            //               style: TextController
                                            //                   .BodyText,
                                            //             ),
                                            //             SizedBox(
                                            //               width: 66,
                                            //             ),
                                            //             Flexible(
                                            //               child: Container(
                                            //                 width: 280,
                                            //                 height: 35,
                                            //                 // alignment: Alignment
                                            //                 //     .centerLeft,
                                            //                 // decoration: BoxDecoration(
                                            //                 //     color: Colors
                                            //                 //         .white,
                                            //                 //     border: Border.all(
                                            //                 //         color: ColorSelect
                                            //                 //             .textField)),
                                            //                 // child:
                                            //                 //     TextFormField(
                                            //                 //   controller:
                                            //                 //       _valueOfService,
                                            //                 //   readOnly: true,
                                            //                 //   inputFormatters: <
                                            //                 //       TextInputFormatter>[
                                            //                 //     FilteringTextInputFormatter
                                            //                 //         .digitsOnly
                                            //                 //   ],
                                            //                 //   textAlignVertical:
                                            //                 //       TextAlignVertical
                                            //                 //           .center,
                                            //                 //   style: TextController
                                            //                 //       .BodyHeadingText,
                                            //                 //   decoration: InputDecoration(
                                            //                 //       isDense: true,
                                            //                 //       hintText: S
                                            //                 //           .of(
                                            //                 //               context)
                                            //                 //           .TypeHere,
                                            //                 //       hintStyle:
                                            //                 //           TextController
                                            //                 //               .labelText,
                                            //                 //       border:
                                            //                 //           InputBorder
                                            //                 //               .none),
                                            //                 // ),
                                            //               ),
                                            //             ),
                                            //             SizedBox(
                                            //               width: 10,
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      height: 35,
                                                      width: 170,
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
                                                          SetDate(
                                                              AdvisorySubscribes
                                                                  .clientid
                                                                  .value,
                                                              advisoryId);
                                                          //_launchURLApp();
                                                          //  this.search();
                                                        },
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .ServiceStart,
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

  Widget table(int index, BuildContext context) {
    void calculateEndDate(String date, String y) {
      print("Calculatinggg");
      print(date);
      var x = date.split("-");

      print(x);
      setState(() {
        DateTime startDate =
            DateTime(int.parse(x[0]), int.parse(x[1]), int.parse(x[2]));
        print(startDate);
        // Get the duration as an integer and create a Duration object.
        int duration = int.parse(y);
        print(duration);
        // Calculate the end date by adding the duration to the start date.
        var d = Duration(days: duration);
        print(d);
        DateTime endDate1 = startDate.add(d);
        print(endDate1);
        // Format the end date as a string and set it in the end date controller.
        var endDateStr = endDate1.toString();
        endDate[index].text = endDateStr.split(' ')[0];
      });
    }

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
                  0: FlexColumnWidth(1.5),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
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
                        child: Text(
                          "${MileStones[index]}",
                          style: TextController.BodyText,
                        ),
                      ),
                      Container(
                        height: 50,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? datepicked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(3000),
                              );
                              if (datepicked != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(datepicked);
                                HijriCalendar? picked =
                                    HijriCalendar.fromDate(datepicked);
                                setState(() {
                                  startDates[index].text = formattedDate;
                                  calculateEndDate(formattedDate,
                                      MileStonestatus[index].split("~")[2]);
                                  print("EndDateee");
                                  print(endDate[index].text);
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              controller: startDates[index],
                              style: TextController.BodyText,
                              onChanged: (value) {},
                              // onChanged: (value) {
                              //   setState(() {
                              //     startDates[index].text = value;
                              //   });
                              // },
                              decoration: InputDecoration(
                                isDense: true,
                                suffixIcon: Icon(
                                  Icons.calendar_month_outlined,
                                  size: 15,
                                ),
                                hintText: S.of(context).DateFormat,
                                hintStyle: TextController.labelTextDate,
                                border: InputBorder.none,
                              ),
                              enabled: false, // Disable text editing
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        child: Text(
                          "${MileStonestatus[index].split("~")[2]}",
                          style: TextController.BodyText,
                        ),
                      ),
                      Container(
                        height: 50,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: endDate[index],
                            style: TextController.BodyText,
                            decoration: InputDecoration(
                              isDense: true,
                              suffixIcon: Icon(
                                Icons.calendar_month_outlined,
                                size: 15,
                              ),
                              hintText: S.of(context).DateFormat,
                              hintStyle: TextController.labelTextDate,
                              border: InputBorder.none,
                            ),
                            enabled: false, // Disable text editing
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
    );
  }
}
