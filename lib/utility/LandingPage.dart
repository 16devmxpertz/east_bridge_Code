import 'dart:convert';

//import 'dart:developer';
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
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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

                                // Container(
                                //   // width: 100,
                                //   height: 44,
                                //   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                //   decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white),
                                //   ),
                                //   child: TextButton(
                                //     onPressed: () {
                                //       Navigator.of(context)
                                //           .push(MaterialPageRoute(
                                //         builder: (context) => LandingPage(),
                                //       ));
                                //     },
                                //     child: Container(
                                //       //color: ColorSelect.east_blue,
                                //       child: Row(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(5.0),
                                //             child: Icon(
                                //               Icons.add_card_rounded,
                                //               size: 15,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             width: 10,
                                //           ),
                                //           Center(
                                //             child: Text(
                                //               S.of(context).New,
                                //               style:
                                //                   TextController.ControllerText,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // // EDIT

                                // Container(
                                //   // width: 100,
                                //   height: 44,
                                //   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                //   decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white),
                                //   ),
                                //   child: TextButton(
                                //     onPressed: () {},
                                //     child: Container(
                                //       //color: ColorSelect.east_blue,
                                //       child: Row(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(5.0),
                                //             child: Icon(
                                //               Icons.edit_calendar_outlined,
                                //               size: 15,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             width: 10,
                                //           ),
                                //           Center(
                                //             child: Text(
                                //               S.of(context).Edit,
                                //               style:
                                //                   TextController.ControllerText,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // // view

                                // Container(
                                //   // width: 100,
                                //   height: 44,
                                //   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                //   decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white),
                                //   ),
                                //   child: TextButton(
                                //     onPressed: () {},
                                //     child: Container(
                                //       //color: ColorSelect.east_blue,
                                //       child: Row(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(5.0),
                                //             child: Icon(
                                //               Icons.content_paste_search,
                                //               size: 15,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             width: 10,
                                //           ),
                                //           Center(
                                //             child: Text(
                                //               S.of(context).View,
                                //               style:
                                //                   TextController.ControllerText,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // // cancel

                                // Container(
                                //   // width: 100,
                                //   height: 44,
                                //   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                //   decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white),
                                //   ),
                                //   child: TextButton(
                                //     onPressed: () {},
                                //     child: Container(
                                //       //color: ColorSelect.east_blue,
                                //       child: Row(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(5.0),
                                //             child: Icon(
                                //               Icons.free_cancellation_outlined,
                                //               size: 15,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             width: 10,
                                //           ),
                                //           Center(
                                //             child: Text(
                                //               S.of(context).Cancel,
                                //               style:
                                //                   TextController.ControllerText,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // // print

                                // Container(
                                //   // width: 100,
                                //   height: 44,
                                //   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                //   decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white),
                                //   ),
                                //   child: TextButton(
                                //     onPressed: () {
                                //       // Navigator.of(context)
                                //       //     .push(MaterialPageRoute(
                                //       //   builder: (context) => KYCPdfUploadIND(),
                                //       // ));
                                //     },
                                //     child: Container(
                                //       //color: ColorSelect.east_blue,
                                //       child: Row(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(5.0),
                                //             child: Icon(
                                //               Icons.print,
                                //               size: 15,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             width: 10,
                                //           ),
                                //           Center(
                                //             child: Text(
                                //               S.of(context).Print,
                                //               style:
                                //                   TextController.ControllerText,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // //

                                // Container(
                                //   // width: 100,
                                //   height: 44,
                                //   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                //   decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white),
                                //   ),
                                //   child: TextButton(
                                //     onPressed: () {},
                                //     child: Container(
                                //       //color: ColorSelect.east_blue,
                                //       child: Row(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(5.0),
                                //             child: Icon(
                                //               Icons.download,
                                //               size: 15,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             width: 10,
                                //           ),
                                //           Center(
                                //             child: Text(
                                //               S.of(context).Download,
                                //               style:
                                //                   TextController.ControllerText,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // // saveDraft
                                // Container(
                                //   // width: 100,
                                //   height: 44,
                                //   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                //   decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.white),
                                //   ),
                                //   child: TextButton(
                                //     onPressed: () {},
                                //     child: Container(
                                //       //color: ColorSelect.east_blue,
                                //       child: Row(
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.all(5.0),
                                //             child: Icon(
                                //               Icons.save_as_outlined,
                                //               size: 15,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //           SizedBox(
                                //             width: 10,
                                //           ),
                                //           Center(
                                //             child: Text(
                                //               S.of(context).SaveDraft,
                                //               style:
                                //                   TextController.ControllerText,
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
