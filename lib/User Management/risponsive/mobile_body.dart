import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';

class MobileDashboard extends StatefulWidget {
  const MobileDashboard({super.key});

  @override
  State<MobileDashboard> createState() => _MobileDashboardState();
}

class _MobileDashboardState extends State<MobileDashboard> {
  int _value = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                // HeaderWeb(),

                // NewHeader2(),

                SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --------------------- Slide bar ---------------------

                      // Sidebar(),

                      // --------------------- Dashboard ---------------------

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(
                                child: Flexible(
                                  child: Container(
                                    width: double.infinity,
                                    height: 78,
                                    // color: Color(0xFFF8F8F8),
                                    child: Center(
                                      child: Text(
                                        'Dashboard',
                                        style:
                                            DashFormTextController.MainHeading,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  width: double.infinity,
                                  height: 78,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F8F8),
                                    border: Border(
                                      top: BorderSide(
                                        color: Color(0xFFBCB7B7),
                                        width: 0.5,
                                      ),
                                      bottom: BorderSide(
                                        color: Color(0xFFBCB7B7),
                                        width: 0.5,
                                      ),
                                    ),
                                  ),

                                  // Add user
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(31, 0, 31, 0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 154,
                                          height: 41,
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 25, 0),
                                          color: ColorSelect.east_blue,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              side: BorderSide(
                                                width: 1.0,
                                                color: Color(0xFFC9BBBB),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              'Add User',
                                              style: DashFormTextController
                                                  .Primarybtn,
                                            ),
                                          ),
                                        ),

                                        // Permission
                                        Container(
                                          width: 154,
                                          height: 41,
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          color: Colors.white,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              side: BorderSide(
                                                width: 1.0,
                                                color: Color(0xFFC9BBBB),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: Text(
                                              'Permission',
                                              style: DashFormTextController
                                                  .Secondrybtn,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(27, 38, 27, 38),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Container(
                                          width: 100,
                                          child: Text(
                                            'User Detail',
                                            style: DashFormTextController
                                                .SubHeading,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // height: 800,
                                        width: double.infinity,
                                        margin:
                                            EdgeInsets.fromLTRB(0, 24, 0, 24),
                                        padding:
                                            EdgeInsets.fromLTRB(32, 26, 32, 26),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 2,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.2)),
                                          ],
                                          color: Color(0xFFFFFFFF),
                                        ),

                                        child: Column(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(1),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 44,
                                                              child: Center(
                                                                child: Text(
                                                                  'First Name',
                                                                  style:
                                                                      DashFormTextController
                                                                          .Lable,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 44,
                                                              margin: EdgeInsets
                                                                  .fromLTRB(0,
                                                                      15, 0, 0),
                                                              child: Center(
                                                                child: Text(
                                                                  'Email',
                                                                  style:
                                                                      DashFormTextController
                                                                          .Lable,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 44,
                                                              margin: EdgeInsets
                                                                  .fromLTRB(0,
                                                                      15, 0, 0),
                                                              child: Center(
                                                                child: Text(
                                                                  'Address',
                                                                  style:
                                                                      DashFormTextController
                                                                          .Lable,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Flexible(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 44,
                                                                width: 250,
                                                                child:
                                                                    TextFormField(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFFD7D6D6),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFF8A8A8A),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 44,
                                                                width: 250,
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        15,
                                                                        0,
                                                                        0),
                                                                child:
                                                                    TextFormField(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFFD7D6D6),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFF8A8A8A),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 44,
                                                                width: 250,
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        15,
                                                                        0,
                                                                        0),
                                                                child:
                                                                    TextFormField(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFFD7D6D6),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFF8A8A8A),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(1),
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 15, 0, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 44,
                                                              child: Center(
                                                                child: Text(
                                                                  'Last Name',
                                                                  style:
                                                                      DashFormTextController
                                                                          .Lable,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 44,
                                                              margin: EdgeInsets
                                                                  .fromLTRB(0,
                                                                      15, 0, 0),
                                                              child: Center(
                                                                child: Text(
                                                                  'Phone Number',
                                                                  style:
                                                                      DashFormTextController
                                                                          .Lable,
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 44,
                                                              margin: EdgeInsets
                                                                  .fromLTRB(0,
                                                                      15, 0, 0),
                                                              child: Center(
                                                                child: Text(
                                                                  'User Role',
                                                                  style:
                                                                      DashFormTextController
                                                                          .Lable,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Flexible(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 44,
                                                                width: 250,
                                                                child:
                                                                    TextFormField(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFFD7D6D6),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFF8A8A8A),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 44,
                                                                width: 250,
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        15,
                                                                        0,
                                                                        0),
                                                                child:
                                                                    TextFormField(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFFD7D6D6),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFF8A8A8A),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 44,
                                                                width: 250,
                                                                margin: EdgeInsets
                                                                    .fromLTRB(
                                                                        0,
                                                                        15,
                                                                        0,
                                                                        0),
                                                                child:
                                                                    TextFormField(
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFFD7D6D6),
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Color(
                                                                            0xFF8A8A8A),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Radios
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 15, 0, 0),
                                              width: double.infinity,
                                              height: 44,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: 44,
                                                          child: Center(
                                                            child: Text(
                                                              'Gender',
                                                              style:
                                                                  DashFormTextController
                                                                      .Lable,
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Container(
                                                            width: 250,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Male',
                                                                  style:
                                                                      DashFormTextController
                                                                          .Lable,
                                                                ),
                                                                // male radio
                                                                Radio(
                                                                  value: 1,
                                                                  groupValue:
                                                                      _value,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _value =
                                                                          value!;
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  'Female',
                                                                  style:
                                                                      DashFormTextController
                                                                          .Lable,
                                                                ),
                                                                // female radio
                                                                Radio(
                                                                  value: 2,
                                                                  groupValue:
                                                                      _value,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      _value =
                                                                          value!;
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
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 144,
                                            height: 41,
                                            margin: EdgeInsets.fromLTRB(
                                                0, 50, 0, 0),
                                            color: ColorSelect.east_blue,
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                side: BorderSide(
                                                  width: 1.0,
                                                  color: Color(0xFFC9BBBB),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                              ),
                                              onPressed: () {},
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
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                //         width: 250,
                //         color: ColorSelect.east_dark_blue,
                //         child: Text('helo'),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
