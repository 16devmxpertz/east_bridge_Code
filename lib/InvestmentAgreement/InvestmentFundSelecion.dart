import 'package:east_bridge/Agreement%20Masters/ClientSelectionhavetoremove.dart';
import 'package:east_bridge/InvestmentAgreement/Investment.dart';
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

class InvestmentFundSelecion extends StatefulWidget {
  @override
  State<InvestmentFundSelecion> createState() => InvestmentFundSelecionState();
}

class InvestmentFundSelecionState extends State<InvestmentFundSelecion> {
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

  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // --------------------- Dashboard ---------------------
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
                                    // width: double.infinity,
                                    // width: 1440,
                                    margin: EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            color: Color.fromRGBO(0, 0, 0, 0.25)),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Please Select',
                                          style: DashFormTextController.Select,
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .tabBorderColor,
                                                      width: 1),
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                width: 250,
                                                child: DropdownButton(
                                                  value: dropdownvalue,
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor:
                                                      ColorSelect.east_dark_blue,
                                                  items: items.map(
                                                    (String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(
                                                          'User',
                                                          style:
                                                              DashFormTextController
                                                                  .SubHeading,
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(
                                                      () {
                                                        dropdownvalue = newValue!;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: SizedBox(
                                                width: 35,
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .tabBorderColor,
                                                      width: 1),
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                width: 250,
                                                child: DropdownButton(
                                                  value: dropdownvalue,
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor:
                                                      ColorSelect.east_dark_blue,
                                                  items: items.map(
                                                    (String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(
                                                          'Client Type',
                                                          style:
                                                              DashFormTextController
                                                                  .SubHeading,
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(
                                                      () {
                                                        dropdownvalue = newValue!;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Flexible(child: SizedBox(
                                              width: 35,
                                            )),
                                            Flexible(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .tabBorderColor,
                                                      width: 1),
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                width: 250,
                                                child: DropdownButton(
                                                  value: dropdownvalue,
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor:
                                                      ColorSelect.east_dark_blue,
                                                  items: items.map(
                                                    (String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(
                                                          'Template',
                                                          style:
                                                              DashFormTextController
                                                                  .SubHeading,
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                  onChanged: (String? newValue) {
                                                    setState(
                                                      () {
                                                        dropdownvalue = newValue!;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: 144,
                                                height: 41,
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 36, 36),
                                                color: ColorSelect.east_blue,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    side: BorderSide(
                                                      width: 1.0,
                                                      color: ColorSelect
                                                          .tabBorderColor,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(0),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Investment()));
                                                  },
                                                  child: Text(
                                                    'Next',
                                                    style: TextStyle(
                                                      color: Color(0xFFFFFFFF),
                                                      fontSize: 18,
                                                      fontFamily: "Gotham",
                                                      fontWeight: FontWeight.w400,
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
                              ],
                            ),
                          ),
                          if (sidebarVisible) SideBar() else Container(),
                        ],
                      ),
                    ),

                    // Row(
                    //   children: [
                    //     Stack(
                    //       children: [
                    //         GestureDetector(
                    //           onTap: _toggleContainerVisibility,
                    //           child: Container(
                    //             color: Colors.transparent,
                    //           ),
                    //         ),
                    //         SlideTransition(
                    //           position: _animation,
                    //           child: Container(
                    //             width: 335,
                    //             height: 500,
                    //             color: Colors.blue,
                    //             child: ListView.builder(
                    //               itemCount: 10,
                    //               itemBuilder: (context, index) {
                    //                 return ListTile(
                    //                   title: Text('Item $index'),
                    //                 );
                    //               },
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ],
                    // ),

                    // Container(
                    //   child: Scaffold(
                    //     key: _globalKey,
                    //     drawer: Drawer(
                    //       child: Container(
                    //         height: 200,
                    //         width: 300,
                    //         color: ColorSelect.east_dark_blue,
                    //         child: Text('helo'),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
