// import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/ClientClassificationTabs/ClientClassificationTab.dart';
// import 'package:flutter/material.dart';
// import 'package:east_bridge/utility/Colors.dart';
// import 'package:east_bridge/generated/l10n.dart';
// import 'package:east_bridge/utility/TextController.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'RegisteredAddress.dart';
// import 'generated/l10n.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       localizationsDelegates: [
//         S.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: S.delegate.supportedLocales,
//     );
//   }
// }

// enum SingingCharacter { yes, no }

// class ClientClarification extends StatefulWidget {
//   ClientClarification({@required controller}) {
//     tabController = controller;
//   }

//   @override
//   State<ClientClarification> createState() => ClientClarificationState();
// }

// class ClientClarificationState extends State<ClientClarification> {
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController Type_here = new TextEditingController();
//     TextEditingController CountryOfRegistration = new TextEditingController();
//     TextEditingController MainBuissness = new TextEditingController();
//     TextEditingController CountryOfPracticingBuissness =
//         new TextEditingController();
//     TextEditingController DateOfIncorporation = new TextEditingController();
//     TextEditingController CommercialRegistraction = new TextEditingController();
//     TextEditingController FullName = new TextEditingController();
//     TextEditingController Citizenship = new TextEditingController();
//     TextEditingController dateController = new TextEditingController();

//     SingingCharacter? _character = SingingCharacter.yes;
//     int? selectedValue = 1;

//     String dropdownvalue;
//     bool? isChecked = null;

//     var items = [
//       'Item 1',
//       'Item 2',
//       'Item 3',
//       'Item 4',
//       'Item 5',
//     ];

//     @override
//     void initState() {
//       super.initState();
//       dateController.text = " ";
//     }

//     return Container(
//       height: 700,
//       child: TabBarApp(),
//     );
//     // return Padding(
//     //   padding: const EdgeInsets.only(left: 50, right: 50, bottom: 50, top: 30),
//     //   child: SingleChildScrollView(
//     //     child: Column(
//     //       children: [
//     //         Row(
//     //           children: [
//     //             Padding(
//     //               padding: const EdgeInsets.only(left: 60, right: 10),
//     //               child: Text(
//     //                 "Retail Client",
//     //                 style: TextController.SubHeadingText,
//     //               ),
//     //             ),
//     //             Padding(
//     //               padding: const EdgeInsets.only(right: 500, left: 10),
//     //               child: Checkbox(
//     //                 value: false,
//     //                 onChanged: (newValue) {
//     //                   // do something when checkbox value changes
//     //                 },
//     //               ),
//     //             ),
//     //             SizedBox(
//     //               width: 2,
//     //             ),
//     //             Text(
//     //               "Qualified Client",
//     //               style: TextController.SubHeadingText,
//     //             ),
//     //             Padding(
//     //               padding: const EdgeInsets.only(right: 500, left: 10),
//     //               child: Checkbox(
//     //                 value: false,
//     //                 onChanged: (newValue) {
//     //                   // do something when checkbox value changes
//     //                 },
//     //               ),
//     //             ),
//     //             SizedBox(
//     //               width: 2,
//     //             ),
//     //             Padding(
//     //               padding: const EdgeInsets.only(right: 10, left: 10),
//     //               child: Text(
//     //                 "Institutional Client",
//     //                 style: TextController.SubHeadingText,
//     //               ),
//     //             ),
//     //             Padding(
//     //               padding: const EdgeInsets.only(right: 10, left: 10),
//     //               child: Checkbox(
//     //                 value: false,
//     //                 onChanged: (newValue) {
//     //                   // do something when checkbox value changes
//     //                 },
//     //               ),
//     //             ),
//     //           ],
//     //         ),
//     //         Padding(
//     //           padding: const EdgeInsets.all(15),
//     //           child: Row(
//     //             children: [
//     //               Row(
//     //                 children: [
//     //                   Padding(
//     //                     padding: const EdgeInsets.only(left: 45),
//     //                     child: Text("Please click on the link to know about"),
//     //                   ),
//     //                   Text(
//     //                     "Retail Client & Qualified Client",
//     //                   )
//     //                 ],
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //         Padding(
//     //           padding: const EdgeInsets.only(
//     //             right: 1090,
//     //             bottom: 20,
//     //           ),
//     //           child: Text(
//     //             "Submit Relevant Documents If You Are Qualified Client :-",
//     //             style: TextController.SubHeadingText,
//     //           ),
//     //         ),
//     //         Table(
//     //           border: TableBorder.all(color: ColorSelect.tabBorderColor),
//     //           defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//     //           columnWidths: {
//     //             0: FixedColumnWidth(1200),
//     //             1: FixedColumnWidth(70),
//     //             2: FixedColumnWidth(200),
//     //           },
//     //           children: [
//     //             TableRow(children: [
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Text(
//     //                       "A) A natural person who meets at least one of the following criteria:",
//     //                       style: TextController.tableHeading,
//     //                     ),
//     //                   )),
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Text(
//     //                       "",
//     //                       style: TextController.BodyText,
//     //                       maxLines: 3,
//     //                     ),
//     //                   )),
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Center(
//     //                       child: Text(
//     //                         "Document Type",
//     //                         style: TextController.tableHeading,
//     //                         maxLines: 3,
//     //                       ),
//     //                     ),
//     //                   )),
//     //             ]),
//     //             TableRow(children: [
//     //               Container(
//     //                 height: 50,
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.only(top: 15, left: 10),
//     //                   child: Text(
//     //                     "1) Has carried out at least 10 transactions per quarter over the last 12 months of a minimum total amount of 40 million Saudi Riyals on securities markets;",
//     //                     style: TextController.BodyText,
//     //                   ),
//     //                 ),
//     //               ),
//     //               Container(
//     //                 height: 50,
//     //                 child: Checkbox(
//     //                   value: false,
//     //                   onChanged: (newValue) {
//     //                     // do something when checkbox value changes
//     //                   },
//     //                 ),
//     //               ),
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Center(
//     //                       child: Column(
//     //                         children: [
//     //                           Text(
//     //                             "Upload Statement",
//     //                             style: TextController.tableHeading,
//     //                             maxLines: 3,
//     //                           ),
//     //                           Text(
//     //                             "Browse",
//     //                             style: TextController.browseText,
//     //                             maxLines: 3,
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   )),
//     //             ]),
//     //             TableRow(children: [
//     //               Container(
//     //                 height: 50,
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.only(top: 15, left: 10),
//     //                   child: Text(
//     //                     "2) His net assets is not less than 5 million Saudi Riyals.",
//     //                     style: TextController.BodyText,
//     //                   ),
//     //                 ),
//     //               ),
//     //               Container(
//     //                 height: 50,
//     //                 child: Checkbox(
//     //                   value: false,
//     //                   onChanged: (newValue) {
//     //                     // do something when checkbox value changes
//     //                   },
//     //                 ),
//     //               ),
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Center(
//     //                       child: Column(
//     //                         children: [
//     //                           Text(
//     //                             "Upload Statement",
//     //                             style: TextController.tableHeading,
//     //                             maxLines: 3,
//     //                           ),
//     //                           Text(
//     //                             "Browse",
//     //                             style: TextController.browseText,
//     //                             maxLines: 3,
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   )),
//     //             ]),
//     //             TableRow(children: [
//     //               Container(
//     //                 height: 50,
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.only(top: 15, left: 10),
//     //                   child: Text(
//     //                     "3) Works or has worked for at least three years in the financial sector in a professional position related to investment in securities.",
//     //                     style: TextController.BodyText,
//     //                   ),
//     //                 ),
//     //               ),
//     //               Container(
//     //                 height: 50,
//     //                 child: Checkbox(
//     //                   value: false,
//     //                   onChanged: (newValue) {
//     //                     // do something when checkbox value changes
//     //                   },
//     //                 ),
//     //               ),
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Center(
//     //                       child: Column(
//     //                         children: [
//     //                           Text(
//     //                             "Upload Statement",
//     //                             style: TextController.tableHeading,
//     //                             maxLines: 3,
//     //                           ),
//     //                           Text(
//     //                             "Browse",
//     //                             style: TextController.browseText,
//     //                             maxLines: 3,
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   )),
//     //             ]),
//     //             TableRow(children: [
//     //               Container(
//     //                 height: 50,
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.only(top: 15, left: 10),
//     //                   child: Text(
//     //                     "4) Holds a professional certificate in securities business and accredited by an internationally recognised entity.",
//     //                     style: TextController.BodyText,
//     //                   ),
//     //                 ),
//     //               ),
//     //               Container(
//     //                 height: 50,
//     //                 child: Checkbox(
//     //                   value: false,
//     //                   onChanged: (newValue) {
//     //                     // do something when checkbox value changes
//     //                   },
//     //                 ),
//     //               ),
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Center(
//     //                       child: Column(
//     //                         children: [
//     //                           Text(
//     //                             "Upload Statement",
//     //                             style: TextController.tableHeading,
//     //                             maxLines: 3,
//     //                           ),
//     //                           Text(
//     //                             "Browse",
//     //                             style: TextController.browseText,
//     //                             maxLines: 3,
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   )),
//     //             ]),
//     //             TableRow(children: [
//     //               Container(
//     //                 height: 50,
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.only(top: 15, left: 10),
//     //                   child: Text(
//     //                     "5) Holds the General Securities Qualification Certificate that is recognized by the Authority, and has an annual income that is not less than 600,000 Saudi Riyals in the last two years.",
//     //                     style: TextController.BodyText,
//     //                   ),
//     //                 ),
//     //               ),
//     //               Container(
//     //                 height: 50,
//     //                 child: Checkbox(
//     //                   value: false,
//     //                   onChanged: (newValue) {
//     //                     // do something when checkbox value changes
//     //                   },
//     //                 ),
//     //               ),
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Center(
//     //                       child: Column(
//     //                         children: [
//     //                           Text(
//     //                             "Upload Statement",
//     //                             style: TextController.tableHeading,
//     //                             maxLines: 3,
//     //                           ),
//     //                           Text(
//     //                             "Browse",
//     //                             style: TextController.browseText,
//     //                             maxLines: 3,
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   )),
//     //             ]),
//     //             TableRow(children: [
//     //               Container(
//     //                 height: 55,
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.only(
//     //                       left: 10, top: 2, bottom: 2, right: 2),
//     //                   child: Text(
//     //                     "6) Being a client of a Capital Market Institution authorized by the Authority to conduct managing activities, provided that the following is fulfilled:  \n a. The offer shall be made to the Capital Market Institution, and that all related communications be made by it.  \nb. The Capital Market Institution has been appointed on terms which enable it to make investment decisions on the client’s behalf without obtaining prior approval from the client.",
//     //                     style: TextController.BodyText,
//     //                   ),
//     //                 ),
//     //               ),
//     //               Container(
//     //                 height: 50,
//     //                 child: Checkbox(
//     //                   value: false,
//     //                   onChanged: (newValue) {
//     //                     // do something when checkbox value changes
//     //                   },
//     //                 ),
//     //               ),
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Center(
//     //                       child: Column(
//     //                         children: [
//     //                           Text(
//     //                             "Upload Statement",
//     //                             style: TextController.tableHeading,
//     //                             maxLines: 3,
//     //                           ),
//     //                           Text(
//     //                             "Browse",
//     //                             style: TextController.browseText,
//     //                             maxLines: 3,
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   )),
//     //             ]),
//     //             TableRow(children: [
//     //               Container(
//     //                 height: 50,
//     //                 child: Padding(
//     //                   padding: const EdgeInsets.only(top: 15, left: 10),
//     //                   child: Text(
//     //                     "7) Registered persons of a Capital Market Institution if the offer is carried out by the Capital Market Institution itself.",
//     //                     style: TextController.BodyText,
//     //                   ),
//     //                 ),
//     //               ),
//     //               Container(
//     //                 height: 50,
//     //                 child: Checkbox(
//     //                   value: false,
//     //                   onChanged: (newValue) {
//     //                     // do something when checkbox value changes
//     //                   },
//     //                 ),
//     //               ),
//     //               Container(
//     //                   height: 50,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Center(
//     //                       child: Column(
//     //                         children: [
//     //                           Text(
//     //                             "Upload Statement",
//     //                             style: TextController.tableHeading,
//     //                             maxLines: 3,
//     //                           ),
//     //                           Text(
//     //                             "Browse",
//     //                             style: TextController.browseText,
//     //                             maxLines: 3,
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   )),
//     //             ]),
//     //           ],
//     //         ),
//     //         Padding(
//     //           padding: const EdgeInsets.only(top: 40),
//     //           child: Table(
//     //             border: TableBorder.all(color: ColorSelect.tabBorderColor),
//     //             defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//     //             columnWidths: {
//     //               0: FixedColumnWidth(1200),
//     //               1: FixedColumnWidth(70),
//     //               2: FixedColumnWidth(200),
//     //             },
//     //             children: [
//     //               TableRow(children: [
//     //                 Container(
//     //                     height: 50,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(top: 15, left: 10),
//     //                       child: Text(
//     //                         "B) A legal person, which meets at least one of the following criteria:",
//     //                         style: TextController.tableHeading,
//     //                       ),
//     //                     )),
//     //                 Container(
//     //                     height: 50,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(left: 10),
//     //                       child: Text(
//     //                         "",
//     //                         style: TextController.BodyText,
//     //                         maxLines: 3,
//     //                       ),
//     //                     )),
//     //                 Container(
//     //                     height: 50,
//     //                     child: Center(
//     //                       child: Padding(
//     //                         padding: const EdgeInsets.only(top: 15, left: 10),
//     //                         child: Text(
//     //                           "Document Type",
//     //                           style: TextController.tableHeading,
//     //                           maxLines: 3,
//     //                         ),
//     //                       ),
//     //                     )),
//     //               ]),
//     //               TableRow(children: [
//     //                 Container(
//     //                   height: 80,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Text(
//     //                       " 1) Any legal person acting for its own account and be any of the following:\n a. A company which owns, or which is a member of a group which owns, net assets of not less than 10 million Saudi Riyals and not more than 50 million Saudi Riyals.\n b. Any unincorporated body, partnership company or other organisation which has net assets of not less than 10 million Saudi Riyals and not more than 50 million Saudi riyals.",
//     //                       style: TextController.BodyText,
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                   height: 80,
//     //                   child: Checkbox(
//     //                     value: false,
//     //                     onChanged: (newValue) {
//     //                       // do something when checkbox value changes
//     //                     },
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                     height: 80,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(top: 15, left: 10),
//     //                       child: Center(
//     //                         child: Column(
//     //                           children: [
//     //                             Text(
//     //                               "Upload Statement",
//     //                               style: TextController.tableHeading,
//     //                               maxLines: 3,
//     //                             ),
//     //                             Text(
//     //                               "Browse",
//     //                               style: TextController.browseText,
//     //                               maxLines: 3,
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     )),
//     //               ]),
//     //               TableRow(children: [
//     //                 Container(
//     //                   height: 80,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Text(
//     //                       "2) A person acting in the capacity of director, officer or employee of a legal person and responsible for its securities activity, where that legal person falls within the definition of paragraph (1/a) or (1/b). 2) clients of a Capital Market Institution authorized by the Authority to conduct managing activities, provided that the following is fulfilled:\n a. The offer shall be made to the Capital Market Institution, and that all related communications be made by it; and\n b. The Capital Market Institution has been appointed on terms which enable it to make investment decisions on the client’s behalf without obtaining prior approval from the client. \n c. A company fully owned by a natural person who meets one of the criteria mentioned in paragraph (A) or a legal person who meets one of the criteria mentioned in paragraph (B).",
//     //                       style: TextController.BodyText,
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                   height: 80,
//     //                   child: Checkbox(
//     //                     value: false,
//     //                     onChanged: (newValue) {
//     //                       // do something when checkbox value changes
//     //                     },
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                     height: 80,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(top: 15, left: 10),
//     //                       child: Center(
//     //                         child: Column(
//     //                           children: [
//     //                             Text(
//     //                               "Upload Statement",
//     //                               style: TextController.tableHeading,
//     //                               maxLines: 3,
//     //                             ),
//     //                             Text(
//     //                               "Browse",
//     //                               style: TextController.browseText,
//     //                               maxLines: 3,
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     )),
//     //               ]),
//     //             ],
//     //           ),
//     //         ),
//     //         Padding(
//     //           padding: const EdgeInsets.only(top: 40),
//     //           child: Table(
//     //             border: TableBorder.all(color: ColorSelect.tabBorderColor),
//     //             defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//     //             columnWidths: {
//     //               0: FixedColumnWidth(1200),
//     //               1: FixedColumnWidth(70),
//     //               2: FixedColumnWidth(200),
//     //             },
//     //             children: [
//     //               TableRow(children: [
//     //                 Container(
//     //                     height: 50,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(top: 15, left: 10),
//     //                       child: Text(
//     //                         "C) A company fully owned by a natural person who meets one of the criteria mentioned in paragraph:",
//     //                         style: TextController.tableHeading,
//     //                       ),
//     //                     )),
//     //                 Container(
//     //                     height: 50,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(left: 10),
//     //                       child: Text(
//     //                         "",
//     //                         style: TextController.BodyText,
//     //                         maxLines: 3,
//     //                       ),
//     //                     )),
//     //                 Container(
//     //                     height: 50,
//     //                     child: Center(
//     //                       child: Padding(
//     //                         padding: const EdgeInsets.only(top: 15, left: 10),
//     //                         child: Text(
//     //                           "Document Type",
//     //                           style: TextController.tableHeading,
//     //                           maxLines: 3,
//     //                         ),
//     //                       ),
//     //                     )),
//     //               ]),
//     //               TableRow(children: [
//     //                 Container(
//     //                   height: 80,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Text(
//     //                       " 1)(A) or a legal person who meets one of the criteria mentioned in paragraph (B). \n  Institutional client: means any of the following: \n a. the Government of the Kingdom or any supranational authority recognized by the Authority. \n b. companies fully owned by the government or any government entity, either directly or through a portfolio managed by a Capital Market Institution authorized to carry on managing business.",
//     //                       style: TextController.BodyText,
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                   height: 80,
//     //                   child: Checkbox(
//     //                     value: false,
//     //                     onChanged: (newValue) {
//     //                       // do something when checkbox value changes
//     //                     },
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                     height: 80,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(top: 15, left: 10),
//     //                       child: Center(
//     //                         child: Column(
//     //                           children: [
//     //                             Text(
//     //                               "Upload Statement",
//     //                               style: TextController.tableHeading,
//     //                               maxLines: 3,
//     //                             ),
//     //                             Text(
//     //                               "Browse",
//     //                               style: TextController.browseText,
//     //                               maxLines: 3,
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     )),
//     //               ]),
//     //               TableRow(children: [
//     //                 Container(
//     //                   height: 80,
//     //                   child: Padding(
//     //                     padding: const EdgeInsets.only(top: 15, left: 10),
//     //                     child: Text(
//     //                       "2) Any legal person acting for its own account and be any of the following: \n a. A company which owns, or is a member of a group which owns, net assets of more than 50 million Saudi Riyals. \n b. An unincorporated body.",
//     //                       style: TextController.BodyText,
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                   height: 80,
//     //                   child: Checkbox(
//     //                     value: false,
//     //                     onChanged: (newValue) {
//     //                       // do something when checkbox value changes
//     //                     },
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                     height: 80,
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(top: 15, left: 10),
//     //                       child: Center(
//     //                         child: Column(
//     //                           children: [
//     //                             Text(
//     //                               "Upload Statement",
//     //                               style: TextController.tableHeading,
//     //                               maxLines: 3,
//     //                             ),
//     //                             Text(
//     //                               "Browse",
//     //                               style: TextController.browseText,
//     //                               maxLines: 3,
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ),
//     //                     )),
//     //               ]),
//     //             ],
//     //           ),
//     //         ),
//     //         Padding(
//     //           padding: const EdgeInsets.all(20),
//     //           child: Row(
//     //             mainAxisAlignment: MainAxisAlignment.end,
//     //             children: [
//     //               Container(
//     //                 height: 35,
//     //                 width: 140,
//     //                 decoration: BoxDecoration(
//     //                     color: Colors.white,
//     //                     border: Border.all(color: ColorSelect.tabBorderColor)),
//     //                 child: TextButton(
//     //                   onPressed: () {
//     //                     tabController?.animateTo(0);
//     //                   }, // Switch tabs
//     //                   child: Text(
//     //                     S.of(context).Back,
//     //                     style: TextController.SideMenuText,
//     //                   ),
//     //                 ),
//     //               ),
//     //               SizedBox(
//     //                 width: 20,
//     //               ),
//     //               Container(
//     //                 height: 35,
//     //                 width: 140,
//     //                 decoration: BoxDecoration(
//     //                     color: ColorSelect.east_blue,
//     //                     border: Border.all(color: ColorSelect.tabBorderColor)),
//     //                 child: TextButton(
//     //                   onPressed: () {
//     //                     tabController?.animateTo(2);
//     //                   }, // Switch tabs
//     //                   child: Text(
//     //                     S.of(context).Next,
//     //                     style: TextController.btnText,
//     //                   ),
//     //                 ),
//     //               ),
//     //             ],
//     //           ),
//     //         )
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }

// void showPlatformDialog(
//     {required BuildContext context,
//     required AlertDialog Function(dynamic context) builder}) {}

// FlatButton({required Text child, required Null Function() onPressed}) {}
