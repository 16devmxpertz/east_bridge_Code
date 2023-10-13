import 'dart:convert';

import 'package:east_bridge/Arranging/Arranging%20Subscribe/ArrangingSubscribeMainSearchComponent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ArrangingSubscribes extends StatefulWidget {
  const ArrangingSubscribes({super.key});

  @override
  State<ArrangingSubscribes> createState() => _ArrangingSubscribesState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<String> fundname = new ValueNotifier("");
  static ValueNotifier<int> totalValue = new ValueNotifier(0);
  static ValueNotifier<int> duration = new ValueNotifier(0);

  static ValueNotifier<String> persharevalue = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);
  static ValueNotifier<int> id = new ValueNotifier(0);

  static ValueNotifier<int> fundid = new ValueNotifier(0);
}

class _ArrangingSubscribesState extends State<ArrangingSubscribes> {
  TextEditingController fundName = new TextEditingController();

  TextEditingController clientName = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController Amount = new TextEditingController();
  TextEditingController DurationofArranging = new TextEditingController();
  TextEditingController _TotalValue = new TextEditingController();
  TextEditingController _valueOfService = new TextEditingController();

  TextEditingController _duration = new TextEditingController();

  int amnt = 0;
  int currentValue = 0;
  // String value = "";
  //int pershare = int.parse(ArrangingSubscribes.persharevalue.value);
  // int noofshare = int.parse(NoOfShares.text);
  // int amnt = int.parse(Amount.text);

  @override
  void initState() {
    super.initState();
    NoOfShares.text = "0";

    //_calculation();

    setState(() {
      clientName.text = ArrangingSubscribes.name.value;
      fundName.text = ArrangingSubscribes.fundname.value;
      PerShareValue.text = ArrangingSubscribes.persharevalue.value;
      _duration.text = ArrangingSubscribes.duration.value.toString();
      _TotalValue.text = ArrangingSubscribes.totalValue.value.toString();
      print("=======++============");
      print(_duration.text);
      print("=======++============");
      Amount.text = amnt.toString();
      // amnt=pershare * noofshare;
    }); // Setting the initial value for the field.
  }

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
        "http://localhost/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2finvoice&rs:Command=Render&rs:ClearSession=True&rs:Format=PDF&rs:FileExtension=Subscribe.PDF&FID=${ArrangingSubscribes.fundid.value}&CID=${ArrangingSubscribes.clientid.value}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  downloadpdf() async {
    var url = Uri.parse(
        "ttps://eastbridge.online/apicore/api/ArrangingFetchAgreementPDf/FetchArrangingPDF?ClientId=${ArrangingSubscribes.clientid.value}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  List list = [];
  void sendData() async {
    var url = Uri.parse(
        'https://eastbridge.online/apicore/api/ClientArrangingAgreementLink/ClientArrangingAgreementLinking');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "ClientId": ArrangingSubscribes.clientid.value,
        "agreementId": ArrangingSubscribes.id.value,
        //"fundName": fundName.text,
        "duration": _duration.text,
        "date": date.text,
        "valueOfService": int.parse(_valueOfService.text),
        "totalValue": _TotalValue.text
        // "perShareValue": int.parse(ArrangingSubscribes.persharevalue.value),
        // "noOfShare": int.parse(NoOfShares.text),
      };
      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        // _launchURLApp();
        downloadpdf();
        print(jsonDecode(response.body));
        print("Sucess");
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
        'https://eastbridge.online/apicore/api/Search?searchValue=${fundName.text}');
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
                                                      "Arranging Service Initiation",
                                                      style: TextController
                                                          .MainHeadingText,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ArrangingSubscribeMainSearchComponent(),
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
                                                                TextFormField(
                                                              readOnly: true,
                                                              controller:
                                                                  fundName,
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
                                                              //   initialValue: ArrangingSubscribes.name.value,
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
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .ValueOfService,
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                        SizedBox(
                                                          width: 32,
                                                        ),
                                                        Flexible(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            width: 350,
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
                                                              readOnly: true,
                                                              controller:
                                                                  _TotalValue,
                                                              inputFormatters: <
                                                                  TextInputFormatter>[
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
                                                              ],
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
                                                        SizedBox(
                                                          width: 35,
                                                        ),
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .DurationofArranging,
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                        SizedBox(
                                                          width: 66,
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
                                                              onChanged:
                                                                  (value) {
                                                                multiple(
                                                                    int.parse(
                                                                        value));
                                                              },
                                                              initialValue:
                                                                  0.toString(),
                                                              inputFormatters: <
                                                                  TextInputFormatter>[
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
                                                              ],
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
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .TotalValue,
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                        SizedBox(
                                                          width: 66,
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
                                                                  _valueOfService,
                                                              readOnly: true,
                                                              inputFormatters: <
                                                                  TextInputFormatter>[
                                                                FilteringTextInputFormatter
                                                                    .digitsOnly
                                                              ],
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
                                                        SizedBox(
                                                          width: 10,
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
                                                          sendData();
                                                          //_launchURLApp();
                                                          //  this.search();
                                                        },
                                                        child: Text(
                                                          "Service Start",
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
