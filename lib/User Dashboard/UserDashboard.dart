import 'package:east_bridge/User%20Dashboard/Charts/InvestmentDetails.dart';
import 'package:east_bridge/User%20Dashboard/Charts/MonthlySales.dart';
import 'package:east_bridge/User%20Dashboard/Charts/SectorDetails.dart';
import 'package:east_bridge/User%20Dashboard/Charts/TotalInvestmentCap.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/NewHeader2.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class UserDashboard extends StatefulWidget {
  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
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

  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    // ---------------- HEADER SECTION ----------------- //

                    // -------------OLD HEADER-----------//
                    // HeaderWeb(),
                    // -------------OLD HEADER END-----------//

                    // -------------NEW HEADER-----------//
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
                                            style: TextController.ControllerText,
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
                                            style: TextController.ControllerText,
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
                                            style: TextController.ControllerText,
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
                                            style: TextController.ControllerText,
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
                                            style: TextController.ControllerText,
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
                                            style: TextController.ControllerText,
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
                                            style: TextController.ControllerText,
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
                    // -------------NEW HEADER END-----------//

                    // ---------------- HEADER SECTION END ----------------- //

                    SingleChildScrollView(
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            transform:
                                Matrix4.translationValues(xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            child: Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                margin: EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ColorSelect.tabBorderColor,
                                    width: 0.5,
                                  ),
                                  color: Color(0xFFF6F7FB),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10),
                                        // color: Color(0xFFF8F8F8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: Center(
                                                child: Text(
                                                  S.of(context).Dashboard,
                                                  style: TextController
                                                      .MainHeadingText,
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                    children: [
                                                      Flexible(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.fromLTRB(
                                                                  0, 0, 30, 0),
                                                          width: 200,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(50),
                                                          ),
                                                          child: TextField(
                                                            // cursorColor: Colors.black,
                                                            textAlign:
                                                                TextAlign.center,
                                                            decoration:
                                                                InputDecoration(
                                                                    fillColor:
                                                                        Colors
                                                                            .white,
                                                                    contentPadding:
                                                                        EdgeInsets.symmetric(
                                                                            vertical:
                                                                                10.0,
                                                                            horizontal:
                                                                                20.0),
                                                                    hintText: S
                                                                        .of(context)
                                                                        .search,
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontFamily:
                                                                            'Frutiger',
                                                                        color: Color(
                                                                            0xFFB8B1B1)),
                                                                    prefixIcon:
                                                                        const Icon(Icons
                                                                            .search),
                                                                    prefixIconColor:
                                                                        Color(
                                                                            0xFFD9D9D9),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  50),
                                                                      borderSide: const BorderSide(
                                                                          width:
                                                                              0.5,
                                                                          color: Color(
                                                                              0xFFCACACA)),
                                                                    )),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          width: 100,
                                                          // height: 40,
                                                          color:
                                                              ColorSelect.east_blue,
                                                          child: TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              side: BorderSide(
                                                                width: 0.5,
                                                                color: ColorSelect
                                                                    .tabBorderColor,
                                                              ),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0),
                                                              ),
                                                            ),
                                                            onPressed: () {},
                                                            child: Text(
                                                              'Add New',
                                                              style:
                                                                  UserDashFormTextController
                                                                      .Primarybtn,
                                                            ),
                                                          ),
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
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // -----Weekly profit--------//
                                            Flexible(
                                              // flex: 1,
                                              child: Container(
                                                width: 410,
                                                // height: 160,
                                                padding: EdgeInsets.all(25),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF116B90),
                                                      Color(0xFF5CC1FD)
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          '+7%',
                                                          style:
                                                              UserDashFormTextController
                                                                  .GraphPR,
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.only(top: 20),
                                                      child: Row(
                                                        children: [
                                                          Flexible(
                                                            flex: 1,
                                                            child: Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      'Weekly profit',
                                                                      style: UserDashFormTextController
                                                                          .GraphTxt,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                15),
                                                                    child: Text(
                                                                      '\$10,484',
                                                                      style: UserDashFormTextController
                                                                          .GraphAmt,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          // Profit Graph------------------------
                                                          Flexible(
                                                            flex: 1,
                                                            child: Container(),
                                                          ),
                                                          // Profit Graph------------------------
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            // -----Monthly profit--------//
                                            Flexible(
                                              // flex: 1,
                                              child: Container(
                                                width: 410,

                                                // height: 160,
                                                padding: EdgeInsets.all(25),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF116B90),
                                                      Color(0xFF5CC1FD)
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          '+14%',
                                                          style:
                                                              UserDashFormTextController
                                                                  .GraphPR,
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.only(top: 20),
                                                      child: Row(
                                                        children: [
                                                          Flexible(
                                                            flex: 1,
                                                            child: Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      'Month profit',
                                                                      style: UserDashFormTextController
                                                                          .GraphTxt,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                15),
                                                                    child: Text(
                                                                      '\$30,484',
                                                                      style: UserDashFormTextController
                                                                          .GraphAmt,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          // Profit Graph------------------------
                                                          Flexible(
                                                            flex: 1,
                                                            child: Container(),
                                                          ),
                                                          // Profit Graph------------------------
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // -----Yearly profit--------//
                                            SizedBox(
                                              width: 15,
                                            ),

                                            Flexible(
                                              // flex: 1,
                                              child: Container(
                                                width: 410,
                                                // height: 160,
                                                padding: EdgeInsets.all(25),
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color(0xFF116B90),
                                                      Color(0xFF5CC1FD)
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          '+23%',
                                                          style:
                                                              UserDashFormTextController
                                                                  .GraphPR,
                                                        )
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.only(top: 20),
                                                      child: Row(
                                                        children: [
                                                          Flexible(
                                                            flex: 1,
                                                            child: Container(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      'Yearly profit',
                                                                      style: UserDashFormTextController
                                                                          .GraphTxt,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                15),
                                                                    child: Text(
                                                                      '\$80,233',
                                                                      style: UserDashFormTextController
                                                                          .GraphAmt,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          // Profit Graph------------------------
                                                          Flexible(
                                                            flex: 1,
                                                            child: Container(),
                                                          ),
                                                          // Profit Graph------------------------
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                width: 410,
                                                child: SectorDetails(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Flexible(
                                              flex: 4,
                                              child: Container(
                                                width: 845,
                                                child: MonthlySales(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Container(
                                                width: 410,
                                                child: InvestmentDetails(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Flexible(
                                              flex: 4,
                                              child: Container(
                                                width: 845,
                                                child: TotalInvestmentCap(),
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
                    ),
                  ],
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
