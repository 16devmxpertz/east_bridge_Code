// import 'package:east_bridge/generated/l10n.dart';
// import 'package:east_bridge/utility/Colors.dart';
// import 'package:east_bridge/utility/TextController.dart';
// import 'package:flutter/material.dart';

// class Permission extends StatefulWidget {
//   Permission({@required controller}) {
//     tabController = controller;
//   }

//   @override
//   State<Permission> createState() => _PermissionState();
// static ValueNotifier<String> name = ValueNotifier("");
// static ValueNotifier<String> role = ValueNotifier("");
// }

// TabController? tabController;

// class _PermissionState extends State<Permission> {
//   int? selectedValue = 0;

// bool isChecked01 = false;
// bool isChecked02 = false;
// bool isChecked03 = false;
// bool isChecked04 = false;
// bool isChecked05 = false;
// bool isChecked06 = false;

//   bool isChecked11 = false;
//   bool isChecked12 = false;
//   bool isChecked13 = false;
//   bool isChecked14 = false;
//   bool isChecked15 = false;
//   bool isChecked16 = false;

//   bool isChecked21 = false;
//   bool isChecked22 = false;
//   bool isChecked23 = false;
//   bool isChecked24 = false;
//   bool isChecked25 = false;
//   bool isChecked26 = false;

//   bool isChecked31 = false;
//   bool isChecked32 = false;
//   bool isChecked33 = false;
//   bool isChecked34 = false;
//   bool isChecked35 = false;
//   bool isChecked36 = false;

//   bool isChecked41 = false;
//   bool isChecked42 = false;
//   bool isChecked43 = false;
//   bool isChecked44 = false;
//   bool isChecked45 = false;
//   bool isChecked46 = false;

//   bool isChecked51 = false;
//   bool isChecked52 = false;
//   bool isChecked53 = false;
//   bool isChecked54 = false;
//   bool isChecked55 = false;
//   bool isChecked56 = false;

//   bool isChecked61 = false;
//   bool isChecked62 = false;
//   bool isChecked63 = false;
//   bool isChecked64 = false;
//   bool isChecked65 = false;
//   bool isChecked66 = false;

//   bool isChecked71 = false;
//   bool isChecked72 = false;
//   bool isChecked73 = false;
//   bool isChecked74 = false;
//   bool isChecked75 = false;
//   bool isChecked76 = false;

//   bool isChecked81 = false;
//   bool isChecked82 = false;
//   bool isChecked83 = false;
//   bool isChecked84 = false;
//   bool isChecked85 = false;
//   bool isChecked86 = false;

//   bool isChecked91 = false;
//   bool isChecked92 = false;
//   bool isChecked93 = false;
//   bool isChecked94 = false;
//   bool isChecked95 = false;
//   bool isChecked96 = false;

//   int _value = 0;

//   String dropdownvalue = 'Item 1';

//   // List of items in our dropdown menu
//   var items = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         margin: EdgeInsets.symmetric(horizontal: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         'User Name : ',
//                         style: DashFormTextController.SubHeading,
//                       ),
//                       Container(
//                         width: 200,
//                         child: Text(Permission.name.value),
//                       ),
//                       Flexible(
//                         child: SizedBox(
//                           width: 10,
//                         ),
//                       ),
//                       Text(
//                         'User Role : ',
//                         style: DashFormTextController.SubHeading,
//                       ),
//                       Text(
//                         Permission.role.value,
//                         style: DashFormTextController.SubHeading,
//                       ),
//                     ],
//                   ),
//                   Text(
//                     'Permission',
//                     style: DashFormTextController.SubHeading,
//                   ),
//                   SizedBox(height: 30),
// Table(
//   border: TableBorder.all(color: ColorSelect.tabBorderColor),
//   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//   columnWidths: {
//     0: FlexColumnWidth(1.5),
//     1: FlexColumnWidth(4.5),
//   },
//   children: [
//     TableRow(
//       decoration: BoxDecoration(color: ColorSelect.east_grey),
//       children: [
//         Container(
//           height: 40,
//           child: Center(
//             child: Text(
//               'Type',
//               style: DashFormTextController.SubHeading,
//             ),
//           ),
//         ),
//         Container(
//           height: 40,
//           child: Center(
//             child: Text(
//               'Permission',
//               style: DashFormTextController.SubHeading,
//             ),
//           ),
//         ),
//       ],
//     )
//   ],
// ),
// Table(
//   border: TableBorder.all(color: ColorSelect.tabBorderColor),
//   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//   columnWidths: {
//     0: FlexColumnWidth(2),
//     1: FlexColumnWidth(1),
//     2: FlexColumnWidth(1),
//     2: FlexColumnWidth(1),
//     2: FlexColumnWidth(1),
//     2: FlexColumnWidth(1),
//     2: FlexColumnWidth(1),
//     // 0: FixedColumnWidth(500),
//     // 1: FixedColumnWidth(200),
//     // 2: FixedColumnWidth(500),
//   },
//   children: [
//     TableRow(
//       children: [
//         Container(
//           height: 40,
//           child: Center(
//             child: Text(
//               'Form Name',
//               style: TextController.tableSubhead,
//             ),
//           ),
//         ),
//         Container(
//           height: 40,
//           child: Center(
//             child: Text(
//               'View',
//               style: TextController.tableSubhead,
//             ),
//           ),
//         ),
//         Container(
//           height: 40,
//           child: Center(
//             child: Text(
//               'New',
//               style: TextController.tableSubhead,
//             ),
//           ),
//         ),
//         Container(
//           height: 40,
//           child: Center(
//             child: Text(
//               'Delete',
//               style: TextController.tableSubhead,
//             ),
//           ),
//         ),
//         Container(
//           height: 40,
//           child: Center(
//             child: Text(
//               'Edit',
//               style: TextController.tableSubhead,
//             ),
//           ),
//         ),
//         Container(
//           height: 40,
//           child: Center(
//             child: Text(
//               'Print',
//               style: TextController.tableSubhead,
//             ),
//           ),
//         ),
//         Container(
//           height: 40,
//           child: Center(
//             child: Text(
//               'Approve',
//               style: TextController.tableSubhead,
//             ),
//           ),
//         ),
//       ],
// ),
//                   TableRow(
//                     children: [
//                       Container(
//                         height: 60,
//                         child: Center(
//                           child: Container(
//                             margin: EdgeInsetsDirectional.symmetric(
//                               horizontal: 10,
//                               vertical: 15,
//                             ),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: ColorSelect.tabBorderColor,
//                                   width: 0.5),
//                             ),
//                             padding: EdgeInsetsDirectional.symmetric(
//                               horizontal: 10,
//                             ),
//                             height: 44,
//                             width: 180,
//                             child: DropdownButton(
//                               value: dropdownvalue,
//                               isExpanded: true,
//                               underline: Container(),
//                               iconEnabledColor: ColorSelect.east_dark_blue,
//                               items: items.map(
//                                 (String items) {
//                                   return DropdownMenuItem(
//                                     value: items,
//                                     child: Text(
//                                       'Select Here',
//                                       style: TextController.BodyText,
//                                     ),
//                                   );
//                                 },
//                               ).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(
//                                   () {
//                                     dropdownvalue = newValue!;
//                                   },
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         child: Center(
//                           child: Checkbox(
//                               value: isChecked01,
//                               onChanged: (val) {
//                                 setState(() {
//                                   isChecked01 = val!;
//                                 });
//                               }),
//                         ),
//                       ),
//                       Container(
//                         child: Center(
//                           child: Checkbox(
//                               value: isChecked02,
//                               onChanged: (val) {
//                                 setState(() {
//                                   isChecked02 = val!;
//                                 });
//                               }),
//                         ),
//                       ),
//                       Container(
//                         child: Center(
//                           child: Checkbox(
//                               value: isChecked03,
//                               onChanged: (val) {
//                                 setState(() {
//                                   isChecked03 = val!;
//                                 });
//                               }),
//                         ),
//                       ),
//                       Container(
//                         child: Center(
//                           child: Checkbox(
//                               value: isChecked04,
//                               onChanged: (val) {
//                                 setState(() {
//                                   isChecked04 = val!;
//                                 });
//                               }),
//                         ),
//                       ),
//                       Container(
//                         child: Center(
//                           child: Checkbox(
//                               value: isChecked05,
//                               onChanged: (val) {
//                                 setState(() {
//                                   isChecked05 = val!;
//                                 });
//                               }),
//                         ),
//                       ),
//                       Container(
//                         child: Center(
//                           child: Checkbox(
//                               value: isChecked06,
//                               onChanged: (val) {
//                                 setState(() {
//                                   isChecked06 = val!;
//                                 });
//                               }),
//                         ),
//                       ),
//                     ],
//                   ),
//                       TableRow(
//                         children: [
//                           Container(
//                             height: 60,
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: ColorSelect.tabBorderColor,
//                                       width: 0.5),
//                                 ),
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 height: 44,
//                                 width: 180,
//                                 child: DropdownButton(
//                                   value: dropdownvalue,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   iconEnabledColor: ColorSelect.east_dark_blue,
//                                   items: items.map(
//                                     (String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(
//                                           'Select Here',
//                                           style: TextController.BodyText,
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(
//                                       () {
//                                         dropdownvalue = newValue!;
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked11,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked11 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked12,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked12 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked13,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked13 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked14,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked14 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked15,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked15 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked16,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked16 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Container(
//                             height: 60,
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: ColorSelect.tabBorderColor,
//                                       width: 0.5),
//                                 ),
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 height: 44,
//                                 width: 180,
//                                 child: DropdownButton(
//                                   value: dropdownvalue,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   iconEnabledColor: ColorSelect.east_dark_blue,
//                                   items: items.map(
//                                     (String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(
//                                           'Select Here',
//                                           style: TextController.BodyText,
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(
//                                       () {
//                                         dropdownvalue = newValue!;
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked21,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked21 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked22,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked22 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked23,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked23 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked24,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked24 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked25,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked25 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked26,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked26 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Container(
//                             height: 60,
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: ColorSelect.tabBorderColor,
//                                       width: 0.5),
//                                 ),
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 height: 44,
//                                 width: 180,
//                                 child: DropdownButton(
//                                   value: dropdownvalue,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   iconEnabledColor: ColorSelect.east_dark_blue,
//                                   items: items.map(
//                                     (String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(
//                                           'Select Here',
//                                           style: TextController.BodyText,
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(
//                                       () {
//                                         dropdownvalue = newValue!;
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked31,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked31 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked32,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked32 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked33,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked33 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked34,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked34 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked35,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked35 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked36,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked36 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Container(
//                             height: 60,
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: ColorSelect.tabBorderColor,
//                                       width: 0.5),
//                                 ),
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 height: 44,
//                                 width: 180,
//                                 child: DropdownButton(
//                                   value: dropdownvalue,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   iconEnabledColor: ColorSelect.east_dark_blue,
//                                   items: items.map(
//                                     (String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(
//                                           'Select Here',
//                                           style: TextController.BodyText,
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(
//                                       () {
//                                         dropdownvalue = newValue!;
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked41,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked41 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked42,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked42 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked43,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked43 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked44,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked44 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked45,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked45 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked46,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked46 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Container(
//                             height: 60,
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: ColorSelect.tabBorderColor,
//                                       width: 0.5),
//                                 ),
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 height: 44,
//                                 width: 180,
//                                 child: DropdownButton(
//                                   value: dropdownvalue,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   iconEnabledColor: ColorSelect.east_dark_blue,
//                                   items: items.map(
//                                     (String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(
//                                           'Select Here',
//                                           style: TextController.BodyText,
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(
//                                       () {
//                                         dropdownvalue = newValue!;
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked51,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked51 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked52,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked52 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked53,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked53 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked54,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked54 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked55,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked55 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked56,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked56 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Container(
//                             height: 60,
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: ColorSelect.tabBorderColor,
//                                       width: 0.5),
//                                 ),
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 height: 44,
//                                 width: 180,
//                                 child: DropdownButton(
//                                   value: dropdownvalue,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   iconEnabledColor: ColorSelect.east_dark_blue,
//                                   items: items.map(
//                                     (String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(
//                                           'Select Here',
//                                           style: TextController.BodyText,
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(
//                                       () {
//                                         dropdownvalue = newValue!;
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked61,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked61 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked62,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked62 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked63,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked63 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked64,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked64 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked65,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked65 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked66,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked66 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Container(
//                             height: 60,
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: ColorSelect.tabBorderColor,
//                                       width: 0.5),
//                                 ),
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 height: 44,
//                                 width: 180,
//                                 child: DropdownButton(
//                                   value: dropdownvalue,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   iconEnabledColor: ColorSelect.east_dark_blue,
//                                   items: items.map(
//                                     (String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(
//                                           'Select Here',
//                                           style: TextController.BodyText,
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(
//                                       () {
//                                         dropdownvalue = newValue!;
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked71,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked71 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked72,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked72 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked73,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked73 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked74,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked74 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked75,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked75 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked76,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked76 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Container(
//                             height: 60,
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: ColorSelect.tabBorderColor,
//                                       width: 0.5),
//                                 ),
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 height: 44,
//                                 width: 180,
//                                 child: DropdownButton(
//                                   value: dropdownvalue,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   iconEnabledColor: ColorSelect.east_dark_blue,
//                                   items: items.map(
//                                     (String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(
//                                           'Select Here',
//                                           style: TextController.BodyText,
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(
//                                       () {
//                                         dropdownvalue = newValue!;
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked81,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked81 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked82,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked82 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked83,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked83 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked84,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked84 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked85,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked85 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked86,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked86 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                       TableRow(
//                         children: [
//                           Container(
//                             height: 60,
//                             child: Center(
//                               child: Container(
//                                 margin: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                   vertical: 15,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                       color: ColorSelect.tabBorderColor,
//                                       width: 0.5),
//                                 ),
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                   horizontal: 10,
//                                 ),
//                                 height: 44,
//                                 width: 180,
//                                 child: DropdownButton(
//                                   value: dropdownvalue,
//                                   isExpanded: true,
//                                   underline: Container(),
//                                   iconEnabledColor: ColorSelect.east_dark_blue,
//                                   items: items.map(
//                                     (String items) {
//                                       return DropdownMenuItem(
//                                         value: items,
//                                         child: Text(
//                                           'Select Here',
//                                           style: TextController.BodyText,
//                                         ),
//                                       );
//                                     },
//                                   ).toList(),
//                                   onChanged: (String? newValue) {
//                                     setState(
//                                       () {
//                                         dropdownvalue = newValue!;
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked91,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked91 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked92,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked92 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked93,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked93 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked94,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked94 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked95,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked95 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                           Container(
//                             child: Center(
//                               child: Checkbox(
//                                   value: isChecked96,
//                                   onChanged: (val) {
//                                     setState(() {
//                                       isChecked96 = val!;
//                                     });
//                                   }),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         height: 35,
//                         width: 140,
//                         margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
//                         color: ColorSelect.east_blue,
//                         child: TextButton(
//                           style: TextButton.styleFrom(
//                             side: BorderSide(
//                               width: 1.0,
//                               color: Color(0xFFC9BBBB),
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(0),
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: Text(
//                             S.of(context).Next,
//                             style: TextController.btnText,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/User%20Management/UserManagement.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RowData1 {
  late String dropdownValue;
  late bool isChecked01;
  late bool isChecked02;
  late bool isChecked03;
  late bool isChecked04;
  late bool isChecked05;
  late bool isChecked06;

  RowData1() {
    isChecked01 = false;
    isChecked02 = false;
    isChecked03 = false;
    isChecked04 = false;
    isChecked05 = false;
    isChecked06 = false;
    dropdownValue = " ";
  }
}

class Permission extends StatefulWidget {
  Permission({@required controller}) {
    tabController = controller;
  }
  @override
  _DynamicTableState createState() => _DynamicTableState();
  static ValueNotifier<int> id = new ValueNotifier(0);
  static ValueNotifier<String> name = ValueNotifier("");
  static ValueNotifier<String> role = ValueNotifier("");
}

TabController? tabController;

class _DynamicTableState extends State<Permission> {
  List<RowData1> rowDataList = [];

  @override
  void dispose() {
    for (var rowData in rowDataList) {
      rowData.isChecked01 = false;
      rowData.isChecked02 = false;
      rowData.isChecked03 = false;
      rowData.isChecked04 = false;
      rowData.isChecked05 = false;
      rowData.isChecked06 = false;
    }
    super.dispose();
  }

  void addRow() {
    setState(() {
      rowDataList.add(RowData1());
    });
  }

  void removeRow(int index) {
    setState(() {
      rowDataList.removeAt(index);
    });
  }

  List<RowData1> newlist = []; // Assuming you have a list of RowData objects

  void Permissions() async {
    List<Map<String, dynamic>> feesList = [];
    for (var rowData in rowDataList) {
      Map<String, dynamic> permission = {
        "View": rowData.isChecked01,
        "New": rowData.isChecked02,
        "Delete": rowData.isChecked03,
        "Edit": rowData.isChecked04,
        "Print": rowData.isChecked05,
        "Approve": rowData.isChecked06
      };

      Map<String, dynamic> form = {rowData.dropdownValue: permission};
      feesList.add(form);
    }

    Map<String, dynamic> combinedMap = {};

    for (var form in feesList) {
      String key = form.keys.first; // Get the key from the form map
      Map<String, dynamic> permission =
          form.values.first; // Get the permission map

      combinedMap[key] =
          permission; // Add the permission map to the combined map
    }

    print(combinedMap);

    print(feesList);

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/DashBoardAdminPermisssions/AdminPermissions');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "employeeId": Permission.id.value,
        "permissions": combinedMap,
      };

      print(body);

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "User Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UserManagement(),
        ));
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print(jsonDecode(response.body));
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(top: 20),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              horizontal: 50,
            ),
            child: Column(
              children: [
                Table(
                  border: TableBorder.all(color: ColorSelect.tabBorderColor),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: FlexColumnWidth(1.3),
                    1: FlexColumnWidth(4.5),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: ColorSelect.east_grey),
                      children: [
                        Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              'Type',
                              style: DashFormTextController.SubHeading,
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          child: Center(
                            child: Text(
                              'Permission',
                              style: DashFormTextController.SubHeading,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Table(
                    border: TableBorder.all(color: ColorSelect.tabBorderColor),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FlexColumnWidth(1.73),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      // 2: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),

                      // 0: FixedColumnWidth(500),
                      // 1: FixedColumnWidth(200),
                      // 2: FixedColumnWidth(500),
                    },
                    children: [
                      TableRow(
                        children: [
                          Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                'Form Name',
                                style: TextController.tableSubhead,
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.content_paste_search,
                                    size: 15,
                                    color: ColorSelect.east_blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    S.of(context).View,
                                    style: TextController.tableSubhead,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_card_rounded,
                                    size: 15,
                                    color: ColorSelect.east_blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    S.of(context).New,
                                    style: TextController.tableSubhead,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 15,
                                    color: ColorSelect.east_blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Delete',
                                    style: TextController.tableSubhead,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit_calendar_outlined,
                                    size: 15,
                                    color: ColorSelect.east_blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    S.of(context).Edit,
                                    style: TextController.tableSubhead,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.print,
                                    size: 15,
                                    color: ColorSelect.east_blue,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    S.of(context).Print,
                                    style: TextController.tableSubhead,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   height: 40,
                          //   child: Center(
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Icon(
                          //           Icons.Ap,
                          //           size: 15,
                          //           color: ColorSelect.east_blue,
                          //         ),
                          //         SizedBox(
                          //           width: 5,
                          //         ),
                          //         Text(
                          //           'Approve',
                          //           style: TextController.tableSubhead,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Container(
                            height: 40,
                            child: Center(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorSelect.east_blue)),
                                onPressed: addRow,
                                child: Text('Add Row'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ],
            )),
        Expanded(
          child: ListView.builder(
            itemCount: rowDataList.length,
            itemBuilder: (context, index) {
              return buildRowWidget(index);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorSelect.tabBorderColor)),
                  child: TextButton(
                    onPressed: () {
                      tabController!.animateTo(0);
                    }, // Switch tabs
                    child: Text(
                      S.of(context).Back,
                      style: TextController.SideMenuText,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50, bottom: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 35,
                  width: 140,
                  decoration: BoxDecoration(
                      color: ColorSelect.east_blue,
                      border: Border.all(color: ColorSelect.tabBorderColor)),
                  child: TextButton(
                    onPressed: () {
                      Permissions();
                    }, // Switch tabs
                    child: Text(
                      S.of(context).Submit,
                      style: TextController.btnText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRowWidget(int index) {
    var feesType = [
      'Establishment Expenses',
      'Entry Fees',
      'Management Fees',
      'Performance Advisory Fees',
      'Custody Advisory Fees',
      'Advisory Operator Fees',
      'Auditor Advisory Fees',
      'Trading Advisory Fees',
      'Arranging Financing',
      'Other Expenses',
    ];
    var items = [
      'KYC Individual',
      'KYC Institutional',
      'KYC POA',
      'KYC Upload',
      'Client\'s Investment Account Opening',
      'Fund Creation',
      'Fund Agreement',
      'Fund Subscription',
      'Fund Redemption',
      'Agreement Upload',
      'DPM Creation',
      'DPM Portfolio Creation',
      'DPM Agreement',
      'Customer DPM Agreement',
      'DPM Buy',
      'DPM Sell',
      'NDPM Creation',
      'NDPM Portfolio Creation',
      'NDPM Agreement',
      'NDPM Subscribe',
      'NDPM Redeem',
      'Agreement Upload',
    ];

    return Container(
      //  padding: EdgeInsets.all(25),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Table(
        border: TableBorder.all(color: ColorSelect.tabBorderColor),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          // 0: FixedColumnWidth(150),
          // 1: FixedColumnWidth(150),
          // 2: FixedColumnWidth(150),
          // 3: FixedColumnWidth(150),
          // 4: FixedColumnWidth(150),
          // 5: FixedColumnWidth(150),
          // 6: FixedColumnWidth(150),
          // 7: FixedColumnWidth(150),
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          // 2: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
        },
        children: [
          TableRow(
            children: [
              Container(
                height: 60,
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                      vertical: 05,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorSelect.tabBorderColor, width: 0.5),
                    ),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 10,
                    ),
                    height: 44,
                    width: 180,
                    child: DropdownButtonHideUnderline(
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(focusColor: Colors.white),
                        child: DropdownButtonFormField(
                          hint: Center(
                            child: Text(
                              S.of(context).SelectHere,
                              style: TextController.labelText,
                            ),
                          ),
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            hoverColor: Colors.white,
                          ),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Center(
                                  child: Text(items,
                                      style: TextController.BodyText)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              rowDataList[index].dropdownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Checkbox(
                      value: rowDataList[index].isChecked01,
                      onChanged: (val) {
                        setState(() {
                          rowDataList[index].isChecked01 = val!;
                        });
                      }),
                ),
              ),
              Container(
                child: Center(
                  child: Checkbox(
                      value: rowDataList[index].isChecked02,
                      onChanged: (val) {
                        setState(() {
                          rowDataList[index].isChecked02 = val!;
                        });
                      }),
                ),
              ),
              Container(
                child: Center(
                  child: Checkbox(
                      value: rowDataList[index].isChecked03,
                      onChanged: (val) {
                        setState(() {
                          rowDataList[index].isChecked03 = val!;
                        });
                      }),
                ),
              ),
              // Container(
              //   child: Center(
              //     child: Checkbox(
              //         value: rowDataList[index].isChecked04,
              //         onChanged: (val) {
              //           setState(() {
              //             rowDataList[index].isChecked04 = val!;
              //           });
              //         }),
              //   ),
              // ),
              Container(
                child: Center(
                  child: Checkbox(
                      value: rowDataList[index].isChecked05,
                      onChanged: (val) {
                        setState(() {
                          rowDataList[index].isChecked05 = val!;
                        });
                      }),
                ),
              ),
              Container(
                child: Center(
                  child: Checkbox(
                      value: rowDataList[index].isChecked06,
                      onChanged: (val) {
                        setState(() {
                          rowDataList[index].isChecked06 = val!;
                        });
                      }),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeRow(index),
                ),
              ),
            ],
          ),
          // ...List.generate(
          //   numberOfRowsToAdd,
          //   (index) => TableRow(
          //     children: [
          //       Container(
          //         height: 70,
          //         width: double.infinity,
          //         child: DropdownButtonHideUnderline(
          //           child: Theme(
          //             data: Theme.of(context)
          //                 .copyWith(focusColor: Colors.white),
          //             child: DropdownButtonFormField(
          //               hint: Center(
          //                 child: Text(
          //                   S.of(context).SelectHere,
          //                   style: TextController.labelText,
          //                 ),
          //               ),
          //               isExpanded: true,
          //               icon: const Icon(Icons.keyboard_arrow_down),
          //               decoration: InputDecoration(
          //                 enabledBorder: InputBorder.none,
          //                 border: InputBorder.none,
          //                 hoverColor: Colors.white,
          //               ),
          //               items: feesType.map((String items) {
          //                 return DropdownMenuItem(
          //                   value: items,
          //                   child: Center(
          //                       child: Text(items,
          //                           style: TextController.BodyText)),
          //                 );
          //               }).toList(),
          //               onChanged: (String? newValue) {
          //                 setState(() {
          //                   dropdownvalue = newValue!;
          //                 });
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: RangeFrom,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: RangeTo,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: FixedAdvisoryFees,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: AdvisoryFeesRate,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         width: 100,
          //         child: DropdownButtonHideUnderline(
          //           child: Theme(
          //             data: Theme.of(context)
          //                 .copyWith(focusColor: Colors.white),
          //             child: DropdownButtonFormField(
          //               hint: Center(
          //                 child: Text(
          //                   S.of(context).SelectHere,
          //                   style: TextController.labelText,
          //                 ),
          //               ),
          //               isExpanded: true,
          //               icon: const Icon(Icons.keyboard_arrow_down),
          //               decoration: InputDecoration(
          //                 enabledBorder: InputBorder.none,
          //                 border: InputBorder.none,
          //                 hoverColor: Colors.white,
          //               ),
          //               items: items.map((String items) {
          //                 return DropdownMenuItem(
          //                   value: items,
          //                   child: Center(
          //                       child: Text(items,
          //                           style: TextController.BodyText)),
          //                 );
          //               }).toList(),
          //               onChanged: (String? newValue) {
          //                 setState(() {
          //                   dropdownvalue2 = newValue!;
          //                 });
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: Lower,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: Upper,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: Upper,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
