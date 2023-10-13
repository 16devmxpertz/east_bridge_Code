import 'dart:convert';
//import 'dart:developer';
import 'package:east_bridge/DPM/Buy.dart';
import 'package:east_bridge/DPM/DPMBuyMainSearchComponent.dart';
import 'package:east_bridge/DPM/PortfolioManagerSearch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignPortfolioManager extends StatefulWidget {
  const AssignPortfolioManager({super.key});

  @override
  State<AssignPortfolioManager> createState() => _AssignPortfolioManagerState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<String> portname = new ValueNotifier("");
  static ValueNotifier<String> persharevalue = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);

  static ValueNotifier<int> pmid = new ValueNotifier(0);
}

class _AssignPortfolioManagerState extends State<AssignPortfolioManager> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _PortfolioManagerNameError = false;
  bool clientNameError = false;

  TextEditingController _PortfolioManagerName = new TextEditingController();
  TextEditingController clientName = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController Amount = new TextEditingController();
  int amnt = 0;
  int currentValue = 0;
  // String value = "";
  //int pershare = int.parse(AssignPortfolioManager.persharevalue.value);
  // int noofshare = int.parse(NoOfShares.text);
  // int amnt = int.parse(Amount.text);

  @override
  void initState() {
    super.initState();
    NoOfShares.text = "0";
    print(AssignPortfolioManager.name.value);
    //_calculation();

    setState(() {
      clientName.text = AssignPortfolioManager.name.value;
      _PortfolioManagerName.text = AssignPortfolioManager.portname.value;
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

  List list = [];
  void sendData() async {
    var url = Uri.parse(
        'https://eastbridge.online/apicore/api/PortFolioManagerClientRelation/PortFolioManagerClientRelation/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "pmId": AssignPortfolioManager.pmid.value,
        "clientId": AssignPortfolioManager.clientid.value
      };
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Portfolio manager assigned successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // print(jsonDecode(response.body));
        AssignPortfolioManager.pmid.value = 0;
        AssignPortfolioManager.clientid.value = 0;

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => new DPMBuy()));
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

  // void search() async {
  //   // var url = Uri.parse(
  //   //     'https://localhost:44323/api/Search?searchValue=${fundName.text}');
  //   // final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     // If server returns an OK response, parse the JSON.
  //     print(json.decode(response.body));
  //     list = json.decode(response.body);
  //   } else {
  //     // If that response was not OK, throw an error.
  //     throw Exception('Failed to load post');
  //   }
  // }
  // //  return response.

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
                                                        S
                                                            .of(context)
                                                            .AssignPortfolioManager,
                                                        style: TextController
                                                            .MainHeadingText,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              PortfolioManagerSearch(),
                                              SizedBox(
                                                height: 20,
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
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 100),
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
                                                                    padding: EdgeInsets.symmetric(
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
                                                                          true,
                                                                      controller:
                                                                          clientName,
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
                                                                          hintStyle: TextController
                                                                              .labelText,
                                                                          border:
                                                                              InputBorder.none),
                                                                    ),
                                                                  ),
                                                                  if (clientNameError)
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                      child:
                                                                          Text(
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
                                                        width: 35,
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
                                                                  .PortfolioManagerName,
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
                                                                    padding: EdgeInsets.symmetric(
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
                                                                      //   initialValue: AssignPortfolioManager.name.value,
                                                                      controller:
                                                                          _PortfolioManagerName,
                                                                      readOnly:
                                                                          true,
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
                                                                            _PortfolioManagerNameError =
                                                                                true;
                                                                          });
                                                                          return "";
                                                                        }

                                                                        setState(
                                                                            () {
                                                                          _PortfolioManagerNameError =
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
                                                                          hintStyle: TextController
                                                                              .labelText,
                                                                          border:
                                                                              InputBorder.none),
                                                                    ),
                                                                  ),
                                                                  if (_PortfolioManagerNameError)
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                      child:
                                                                          Text(
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
                                                      // SizedBox(
                                                      //   width: 15,
                                                      // ),
                                                      // Flexible(
                                                      //   child: Row(
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       Text(
                                                      //         S.of(context).Date,
                                                      //         style: TextController
                                                      //             .BodyText,
                                                      //       ),
                                                      //       SizedBox(
                                                      //         width: 10,
                                                      //       ),
                                                      //       Flexible(
                                                      //         child: Container(
                                                      //           padding: EdgeInsets
                                                      //               .symmetric(
                                                      //                   horizontal:
                                                      //                       10),
                                                      //           width: 280,
                                                      //           height: 35,
                                                      //           alignment: Alignment
                                                      //               .centerLeft,
                                                      //           decoration: BoxDecoration(
                                                      //               color: Colors
                                                      //                   .white,
                                                      //               border: Border.all(
                                                      //                   color: ColorSelect
                                                      //                       .textField)),
                                                      //           child:
                                                      //               TextFormField(
                                                      //             textAlignVertical:
                                                      //                 TextAlignVertical
                                                      //                     .center,
                                                      //             style: TextController
                                                      //                 .BodyHeadingText,
                                                      //             controller: date,
                                                      //             decoration:
                                                      //                 InputDecoration(
                                                      //                     suffixIcon:
                                                      //                         Icon(
                                                      //                       Icons
                                                      //                           .calendar_month_outlined,
                                                      //                       size:
                                                      //                           15,
                                                      //                     ),
                                                      //                     isDense:
                                                      //                         true,
                                                      //                     hintText: S
                                                      //                         .of(
                                                      //                             context)
                                                      //                         .DateFormat,
                                                      //                     hintStyle:
                                                      //                         TextController
                                                      //                             .labelText,
                                                      //                     border: InputBorder
                                                      //                         .none),
                                                      //             //readOnly: true,
                                                      //             onTap: () async {
                                                      //               DateTime? datepicked = await showDatePicker(
                                                      //                   context:
                                                      //                       context,
                                                      //                   initialDate:
                                                      //                       DateTime
                                                      //                           .now(),
                                                      //                   firstDate:
                                                      //                       DateTime(
                                                      //                           2023),
                                                      //                   lastDate:
                                                      //                       DateTime(
                                                      //                           3000));
                                                      //               if (datepicked !=
                                                      //                   null) {
                                                      //                 print(
                                                      //                     datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                      //                 String
                                                      //                     formattedDate =
                                                      //                     DateFormat(
                                                      //                             'yyyy-MM-dd')
                                                      //                         .format(
                                                      //                             datepicked!);
                                                      //                 WidgetsBinding
                                                      //                     .instance
                                                      //                     .addPostFrameCallback((_) => setState((date.text =
                                                      //                             formattedDate)
                                                      //                         as VoidCallback));
                                                      //                 // format date in required form here we use yyyy-MM-dd that means time is remove
                                                      //               } else {
                                                      //                 print(
                                                      //                     "Date is not selected");
                                                      //               }
                                                      //             },
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
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
                                              //                   .spaceBetween,
                                              //           children: [
                                              //             Text(
                                              //               S
                                              //                   .of(context)
                                              //                   .PerShareValue,
                                              //               style: TextController
                                              //                   .BodyText,
                                              //             ),
                                              //             SizedBox(
                                              //               width: 10,
                                              //             ),
                                              //             Flexible(
                                              //               child: Container(
                                              //                 padding: EdgeInsets
                                              //                     .symmetric(
                                              //                         horizontal:
                                              //                             10),
                                              //                 width: 280,
                                              //                 height: 35,
                                              //                 alignment: Alignment
                                              //                     .centerLeft,
                                              //                 decoration: BoxDecoration(
                                              //                     color: Colors
                                              //                         .white,
                                              //                     border: Border.all(
                                              //                         color: ColorSelect
                                              //                             .textField)),
                                              //                 child:
                                              //                     TextFormField(
                                              //                   readOnly: true,
                                              //                   controller:
                                              //                       PerShareValue,
                                              //                   inputFormatters: <
                                              //                       TextInputFormatter>[
                                              //                     FilteringTextInputFormatter
                                              //                         .digitsOnly
                                              //                   ],
                                              //                   textAlignVertical:
                                              //                       TextAlignVertical
                                              //                           .center,
                                              //                   style: TextController
                                              //                       .BodyHeadingText,
                                              //                   decoration: InputDecoration(
                                              //                       isDense: true,
                                              //                       hintText: S
                                              //                           .of(
                                              //                               context)
                                              //                           .TypeHere,
                                              //                       hintStyle:
                                              //                           TextController
                                              //                               .labelText,
                                              //                       border:
                                              //                           InputBorder
                                              //                               .none),
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           ],
                                              //         ),
                                              //       ),
                                              //       SizedBox(
                                              //         width: 15,
                                              //       ),
                                              //       Flexible(
                                              //         child: Row(
                                              //           mainAxisAlignment:
                                              //               MainAxisAlignment
                                              //                   .spaceBetween,
                                              //           children: [
                                              //             Text(
                                              //               S
                                              //                   .of(context)
                                              //                   .NoOfShares,
                                              //               style: TextController
                                              //                   .BodyText,
                                              //             ),
                                              //             SizedBox(
                                              //               width: 10,
                                              //             ),
                                              //             Flexible(
                                              //               child: Container(
                                              //                 padding: EdgeInsets
                                              //                     .symmetric(
                                              //                         horizontal:
                                              //                             10),
                                              //                 width: 280,
                                              //                 height: 35,
                                              //                 alignment: Alignment
                                              //                     .centerLeft,
                                              //                 decoration: BoxDecoration(
                                              //                     color: Colors
                                              //                         .white,
                                              //                     border: Border.all(
                                              //                         color: ColorSelect
                                              //                             .textField)),
                                              //                 child: Row(
                                              //                   mainAxisAlignment:
                                              //                       MainAxisAlignment
                                              //                           .spaceBetween,
                                              //                   children: [
                                              //                     Flexible(
                                              //                       child:
                                              //                           TextFormField(
                                              //                         readOnly:
                                              //                             true,
                                              //                         onChanged:
                                              //                             (value) {
                                              //                           value = NoOfShares
                                              //                               .text;
                                              //                           setState(
                                              //                               () {
                                              //                             currentValue =
                                              //                                 int.parse(value);
                                              //                             Amount
                                              //                                 .text = (currentValue *
                                              //                                     int.parse(PerShareValue.text))
                                              //                                 .toString();
                                              //                           });
                                              //                         },
                                              //                         controller:
                                              //                             NoOfShares,
                                              //                         inputFormatters: <
                                              //                             TextInputFormatter>[
                                              //                           FilteringTextInputFormatter
                                              //                               .digitsOnly
                                              //                         ],
                                              //                         textAlignVertical:
                                              //                             TextAlignVertical
                                              //                                 .center,
                                              //                         style: TextController
                                              //                             .BodyHeadingText,
                                              //                         decoration: InputDecoration(
                                              //                             isDense:
                                              //                                 true,
                                              //                             hintText:
                                              //                                 '0',
                                              //                             hintStyle:
                                              //                                 TextController
                                              //                                     .labelText,
                                              //                             border:
                                              //                                 InputBorder.none),
                                              //                       ),
                                              //                     ),
                                              //                     Flexible(
                                              //                       child:
                                              //                           Container(
                                              //                         height:
                                              //                             35.0,
                                              //                         child:
                                              //                             Column(
                                              //                           crossAxisAlignment:
                                              //                               CrossAxisAlignment
                                              //                                   .center,
                                              //                           mainAxisAlignment:
                                              //                               MainAxisAlignment
                                              //                                   .center,
                                              //                           children: <
                                              //                               Widget>[
                                              //                             Container(
                                              //                               decoration:
                                              //                                   BoxDecoration(
                                              //                                 border:
                                              //                                     Border(
                                              //                                   bottom: BorderSide(
                                              //                                     width: 0.5,
                                              //                                   ),
                                              //                                 ),
                                              //                               ),
                                              //                               child:
                                              //                                   InkWell(
                                              //                                 child:
                                              //                                     Icon(
                                              //                                   Icons.arrow_drop_up,
                                              //                                   size: 15.0,
                                              //                                 ),
                                              //                                 onTap:
                                              //                                     () {
                                              //                                   setState(() {
                                              //                                     currentValue++;
                                              //                                     NoOfShares.text = currentValue.toString();
                                              //                                     Amount.text = (currentValue * int.parse(PerShareValue.text)).toString();
                                              //                                   });
                                              //                                 },
                                              //                               ),
                                              //                             ),
                                              //                             InkWell(
                                              //                               child:
                                              //                                   Icon(
                                              //                                 Icons.arrow_drop_down,
                                              //                                 size:
                                              //                                     15.0,
                                              //                               ),
                                              //                               onTap:
                                              //                                   () {
                                              //                                 setState(() {
                                              //                                   if (!(currentValue - 1 < 0)) {
                                              //                                     currentValue--;
                                              //                                   }
                                              //                                   NoOfShares.text = currentValue.toString();
                                              //                                   Amount.text = (currentValue * int.parse(PerShareValue.text)).toString();
                                              //                                 });
                                              //                               },
                                              //                             ),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //                     ),
                                              //                   ],
                                              //                 ),
                                              //               ),
                                              //             ),
                                              //           ],
                                              //         ),
                                              //       ),
                                              //       SizedBox(
                                              //         width: 15,
                                              //       ),
                                              //       Flexible(
                                              //         child: Row(
                                              //           mainAxisAlignment:
                                              //               MainAxisAlignment
                                              //                   .spaceBetween,
                                              //           children: [
                                              //             Text(
                                              //               S.of(context).Amount,
                                              //               style: TextController
                                              //                   .BodyText,
                                              //             ),
                                              //             SizedBox(
                                              //               width: 10,
                                              //             ),
                                              //             Flexible(
                                              //               child: Container(
                                              //                 padding: EdgeInsets
                                              //                     .symmetric(
                                              //                         horizontal:
                                              //                             10),
                                              //                 width: 280,
                                              //                 height: 35,
                                              //                 alignment: Alignment
                                              //                     .centerLeft,
                                              //                 decoration: BoxDecoration(
                                              //                     color: Colors
                                              //                         .white,
                                              //                     border: Border.all(
                                              //                         color: ColorSelect
                                              //                             .textField)),
                                              //                 child:
                                              //                     TextFormField(
                                              //                   controller:
                                              //                       Amount,
                                              //                   inputFormatters: <
                                              //                       TextInputFormatter>[
                                              //                     FilteringTextInputFormatter
                                              //                         .digitsOnly
                                              //                   ],
                                              //                   textAlignVertical:
                                              //                       TextAlignVertical
                                              //                           .center,
                                              //                   style: TextController
                                              //                       .BodyHeadingText,
                                              //                   decoration: InputDecoration(
                                              //                       isDense: true,
                                              //                       hintText: S
                                              //                           .of(
                                              //                               context)
                                              //                           .TypeHere,
                                              //                       hintStyle:
                                              //                           TextController
                                              //                               .labelText,
                                              //                       border:
                                              //                           InputBorder
                                              //                               .none),
                                              //                 ),
                                              //               ),
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
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              sendData();
                                                            }
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
