// import 'dart:convert';
// import 'package:east_bridge/KYC/KYC%20Components%20POA/POAKYC.dart';
// import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
// import 'package:east_bridge/KYC/corporate.dart';
// import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';
// import 'package:east_bridge/generated/l10n.dart';
// import 'package:east_bridge/utility/Colors.dart';
// import 'package:east_bridge/utility/Navigation.dart';
// import 'package:east_bridge/utility/NewHeader1.dart';
// import 'package:east_bridge/utility/SideMenuBar.dart';
// import 'package:east_bridge/utility/TextController.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class searchKYCdraft extends StatefulWidget {
//   const searchKYCdraft({super.key});

//   @override
//   State<searchKYCdraft> createState() => _searchKYCdraftState();
// }

// class _searchKYCdraftState extends State<searchKYCdraft> {
//   double yOffset = 0;
//   double xOffset = 0;
//   bool sidBarOpen = false;
//   bool _sidebarVisible = false;

//   bool get sidebarVisible => _sidebarVisible;

//   void toggleSidebar() {
//     _sidebarVisible = !_sidebarVisible;
//   }

//   void setSideBarState() {
//     setState(() {
//       xOffset = sidBarOpen ? 250 : 0;
//     });
//   }

//   // customer search
//   TextEditingController FirstNameCompanyName = new TextEditingController();
//   TextEditingController FatherNameMainBusinessName =
//       new TextEditingController();
//   TextEditingController GrandFatherName = new TextEditingController();
//   TextEditingController FamilyName = new TextEditingController();
//   TextEditingController FromDate = new TextEditingController();
//   TextEditingController ToDate = new TextEditingController();
//   TextEditingController Clienttype = new TextEditingController();

//   String clientType = "";

//   void clientIdentification(int i) async {
//     print("Shah");

//     final response = await http.post(Uri.parse(
//         'https://localhost:44323/api/ClientIdentificationApi/ClientIdentification?id=${i}'));

//     print("Shah1");

//     if (response.statusCode == 200) {
//       print("Shah2");
//       final json = response.body;
//       //print(json.decode(response.body));
//       setState(() {
//         clientType = response.body;
//       });
//       print(clientType);
//       print("Shah3");
//     } else {
//       print("ShahError");
//       throw Exception('Failed to fetch data');
//     }
//   }

//   String? ClientTypeDropdownvalue;

//   List<dynamic> drafts = [];
//   List<dynamic> draftskey = [];
//   List<String> range = [];
//   Future<void> fetchDataFromAPI() async {
//     var dio = Dio();
//     var name = null;
//     if (FirstNameCompanyName.text != "") {
//       name = FirstNameCompanyName.text;
//     }
//     var _FatherNameMainBusinessName = null;
//     if (FatherNameMainBusinessName.text != "") {
//       _FatherNameMainBusinessName = FatherNameMainBusinessName.text;
//     }
//     var _GrandFatherName = null;
//     if (GrandFatherName.text != "") {
//       _GrandFatherName = GrandFatherName.text;
//     }
//     var familyName = null;
//     if (FamilyName.text != "") {
//       familyName = FamilyName.text;
//     }
//     range.clear();
//     if (FromDate.text != "") {
//       range.add(FromDate.text);
//     }

//     if (ToDate.text != "") {
//       range.add(ToDate.text);
//     }

//     FormData datas = FormData.fromMap({
//       "Firstname": FirstNameCompanyName.text,
//       "FatherName": FatherNameMainBusinessName.text,
//       "GrandfatherName": GrandFatherName.text,
//       "Lastname": FamilyName.text,
//       "clienttype": ClientTypeDropdownvalue,
//       "range": range
//     });

//     var response = await dio.post(
//         'https://localhost:44323/api/Search/CustomerSearchDrafts',
//         data: datas);

//     if (response.statusCode == 200) {
//       // Request successful

//       var responseData = jsonDecode(response.toString());
//       print(responseData);
//       setState(() {
//         drafts = responseData.values.toList();
//         draftskey = responseData.keys.toList();
//         // key = responseData.keys.toList();
//       });
//       // rocess the response data

//       print(drafts);

//       print('Successful');

//       // Process the responseData
//     } else {
//       // Reqest failed
//       print('Request failed with status: ${response.statusCode}');
//       print(drafts.length);
//       // Display or handle the error
//     }
//   }

//   // catch (e) {
//   //  Error ocurred
//   //   print('Error: $e');
//   //    Display or handle the error
//   //  }
//   List<String> ClientTypeItem = ['Individual', 'institutional'];

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(),
//           child: Stack(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: 40),
//                 color: Colors.white,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Column(
//                         children: [
//                           // Header Start
//                           // Navigation(),
//                           HeaderTop(),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
//                             width: double.infinity,
//                             height: 40,
//                             color: ColorSelect.east_blue,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   height: 40,
//                                   child: Container(
//                                     height: 40,
//                                     child: Center(
//                                       child: IconButton(
//                                         color: Colors.white,
//                                         icon: Icon(Icons.menu),
//                                         onPressed: () {
//                                           sidBarOpen = !sidBarOpen;
//                                           setSideBarState();
//                                           toggleSidebar();
//                                         },
//                                         // onPressed: () {

//                                         // _globalKey.currentState?.openDrawer();
//                                         // },
//                                       ),
//                                     ),
//                                   ),
//                                 ),

//                                 // new
//                                 Container(
//                                   // width: 100,
//                                   height: 44,
//                                   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.white),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Container(
//                                       //color: ColorSelect.east_blue,
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Icon(
//                                               Icons.add_card_rounded,
//                                               size: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Center(
//                                             child: Text(
//                                               S.of(context).New,
//                                               style:
//                                                   TextController.ControllerText,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 // EDIT
//                                 Container(
//                                   // width: 100,
//                                   height: 44,
//                                   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.white),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Container(
//                                       //color: ColorSelect.east_blue,
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Icon(
//                                               Icons.edit_calendar_outlined,
//                                               size: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Center(
//                                             child: Text(
//                                               S.of(context).Edit,
//                                               style:
//                                                   TextController.ControllerText,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 // view
//                                 Container(
//                                   // width: 100,
//                                   height: 44,
//                                   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.white),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Container(
//                                       //color: ColorSelect.east_blue,
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Icon(
//                                               Icons.content_paste_search,
//                                               size: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Center(
//                                             child: Text(
//                                               S.of(context).View,
//                                               style:
//                                                   TextController.ControllerText,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 // cancel
//                                 Container(
//                                   // width: 100,
//                                   height: 44,
//                                   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.white),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Container(
//                                       //color: ColorSelect.east_blue,
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Icon(
//                                               Icons.free_cancellation_outlined,
//                                               size: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Center(
//                                             child: Text(
//                                               S.of(context).Cancel,
//                                               style:
//                                                   TextController.ControllerText,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 // print
//                                 Container(
//                                   // width: 100,
//                                   height: 44,
//                                   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.white),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Container(
//                                       //color: ColorSelect.east_blue,
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Icon(
//                                               Icons.print,
//                                               size: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Center(
//                                             child: Text(
//                                               S.of(context).Print,
//                                               style:
//                                                   TextController.ControllerText,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 // download
//                                 Container(
//                                   // width: 100,
//                                   height: 44,
//                                   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.white),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Container(
//                                       //color: ColorSelect.east_blue,
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Icon(
//                                               Icons.download,
//                                               size: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Center(
//                                             child: Text(
//                                               S.of(context).Download,
//                                               style:
//                                                   TextController.ControllerText,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 // saveDraft
//                                 Container(
//                                   // width: 100,
//                                   height: 44,
//                                   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.white),
//                                   ),
//                                   child: TextButton(
//                                     onPressed: () {},
//                                     child: Container(
//                                       //color: ColorSelect.east_blue,
//                                       child: Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(5.0),
//                                             child: Icon(
//                                               Icons.save_as_outlined,
//                                               size: 15,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Center(
//                                             child: Text(
//                                               S.of(context).SaveDraft,
//                                               style:
//                                                   TextController.ControllerText,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       // HEADER END

//                       Stack(
//                         children: [
//                           AnimatedContainer(
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.height,
//                             transform: Matrix4.translationValues(
//                                 xOffset, yOffset, 1.0),
//                             duration: Duration(milliseconds: 500),
//                             curve: Curves.easeInOut,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.symmetric(
//                                     vertical: 10,
//                                     horizontal: 40,
//                                   ),
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     color: Color(0xFFFFFFFF),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         blurRadius: 3,
//                                         color:
//                                             Color.fromRGBO(0, 0, 0, 0.363),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         child: Column(
//                                           children: [
//                                             Container(
//                                               width: double.infinity,
//                                               padding: EdgeInsets.symmetric(
//                                                   vertical: 10,
//                                                   horizontal: 10),
//                                               margin: EdgeInsets.symmetric(
//                                                   vertical: 5),
//                                               child: Flexible(
//                                                 child: Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment
//                                                           .start,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Flexible(
//                                                       child: Container(
//                                                         // width:
//                                                         //     double.infinity,
//                                                         // color: ColorSelect.east_blue,
//                                                         padding:
//                                                             EdgeInsets.all(
//                                                                 10),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                               S
//                                                                   .of(context)
//                                                                   .ClientCompany,
//                                                               style: TextController
//                                                                   .BodyHeadingText,
//                                                             ),
//                                                             SizedBox(
//                                                               height: 15,
//                                                             ),
//                                                             Container(
//                                                               padding: EdgeInsets.symmetric(
//                                                                   horizontal:
//                                                                       10),
//                                                               width: double
//                                                                   .infinity,
//                                                               height: 35,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .centerLeft,
//                                                               decoration: BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   border: Border.all(
//                                                                       color:
//                                                                           ColorSelect.textField)),
//                                                               child:
//                                                                   TextFormField(
//                                                                 controller:
//                                                                     FirstNameCompanyName,
//                                                                 textAlignVertical:
//                                                                     TextAlignVertical
//                                                                         .center,
//                                                                 style: TextController
//                                                                     .BodyHeadingText,
//                                                                 decoration: InputDecoration(
//                                                                     isDense:
//                                                                         true,
//                                                                     hintText: S
//                                                                         .of(
//                                                                             context)
//                                                                         .FirstNameCompanyName,
//                                                                     hintStyle: TextController
//                                                                         .labelText,
//                                                                     border:
//                                                                         InputBorder.none),
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                               height: 10,
//                                                             ),
//                                                             Container(
//                                                               padding: EdgeInsets.symmetric(
//                                                                   horizontal:
//                                                                       10),
//                                                               width: double
//                                                                   .infinity,
//                                                               height: 35,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .centerLeft,
//                                                               decoration: BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   border: Border.all(
//                                                                       color:
//                                                                           ColorSelect.textField)),
//                                                               child:
//                                                                   TextFormField(
//                                                                 controller:
//                                                                     FatherNameMainBusinessName,
//                                                                 textAlignVertical:
//                                                                     TextAlignVertical
//                                                                         .center,
//                                                                 style: TextController
//                                                                     .BodyHeadingText,
//                                                                 decoration: InputDecoration(
//                                                                     isDense:
//                                                                         true,
//                                                                     hintText: S
//                                                                         .of(
//                                                                             context)
//                                                                         .FatherNameMainBusinessName,
//                                                                     hintStyle: TextController
//                                                                         .labelText,
//                                                                     border:
//                                                                         InputBorder.none),
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                               height: 10,
//                                                             ),
//                                                             Container(
//                                                               padding: EdgeInsets.symmetric(
//                                                                   horizontal:
//                                                                       10),
//                                                               width: double
//                                                                   .infinity,
//                                                               height: 35,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .centerLeft,
//                                                               decoration: BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   border: Border.all(
//                                                                       color:
//                                                                           ColorSelect.textField)),
//                                                               child:
//                                                                   TextFormField(
//                                                                 controller:
//                                                                     GrandFatherName,
//                                                                 textAlignVertical:
//                                                                     TextAlignVertical
//                                                                         .center,
//                                                                 style: TextController
//                                                                     .BodyHeadingText,
//                                                                 decoration: InputDecoration(
//                                                                     isDense:
//                                                                         true,
//                                                                     hintText: S
//                                                                         .of(
//                                                                             context)
//                                                                         .GrandFatherName,
//                                                                     hintStyle: TextController
//                                                                         .labelText,
//                                                                     border:
//                                                                         InputBorder.none),
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                               height: 10,
//                                                             ),
//                                                             Container(
//                                                               padding: EdgeInsets.symmetric(
//                                                                   horizontal:
//                                                                       10),
//                                                               width: double
//                                                                   .infinity,
//                                                               height: 35,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .centerLeft,
//                                                               decoration: BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   border: Border.all(
//                                                                       color:
//                                                                           ColorSelect.textField)),
//                                                               child:
//                                                                   TextFormField(
//                                                                 controller:
//                                                                     FamilyName,
//                                                                 textAlignVertical:
//                                                                     TextAlignVertical
//                                                                         .center,
//                                                                 style: TextController
//                                                                     .BodyHeadingText,
//                                                                 decoration: InputDecoration(
//                                                                     isDense:
//                                                                         true,
//                                                                     hintText: S
//                                                                         .of(
//                                                                             context)
//                                                                         .FamilyName,
//                                                                     hintStyle: TextController
//                                                                         .labelText,
//                                                                     border:
//                                                                         InputBorder.none),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Flexible(
//                                                       child: Container(
//                                                         // width:
//                                                         //     double.infinity,
//                                                         // color: ColorSelect.east_blue,
//                                                         padding:
//                                                             EdgeInsets.all(
//                                                                 10),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                               S
//                                                                   .of(context)
//                                                                   .ClientType,
//                                                               style: TextController
//                                                                   .BodyHeadingText,
//                                                             ),
//                                                             SizedBox(
//                                                               height: 15,
//                                                             ),
//                                                             Container(
//                                                               padding: EdgeInsets.symmetric(
//                                                                   horizontal:
//                                                                       10),
//                                                               width: double
//                                                                   .infinity,
//                                                               height: 35,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .centerLeft,
//                                                               decoration: BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   border: Border.all(
//                                                                       color:
//                                                                           ColorSelect.textField)),
//                                                               child:
//                                                                   DropdownButton(
//                                                                 hint: Text(
//                                                                     "Select Here",
//                                                                     style:
//                                                                         TextController.labelText),
//                                                                 value:
//                                                                     ClientTypeDropdownvalue,
//                                                                 isExpanded:
//                                                                     true,
//                                                                 underline:
//                                                                     Container(),
//                                                                 iconEnabledColor:
//                                                                     ColorSelect
//                                                                         .east_dark_blue,
//                                                                 items: ClientTypeItem
//                                                                     .map(
//                                                                   (String
//                                                                       items) {
//                                                                     return DropdownMenuItem(
//                                                                       value:
//                                                                           items,
//                                                                       child:
//                                                                           Text(
//                                                                         items,
//                                                                         style: TextController.BodyText,
//                                                                       ),
//                                                                     );
//                                                                   },
//                                                                 ).toList(),
//                                                                 onChanged:
//                                                                     (newValue) {
//                                                                   setState(
//                                                                     () {
//                                                                       ClientTypeDropdownvalue =
//                                                                           newValue;
//                                                                     },
//                                                                   );
//                                                                 },
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Flexible(
//                                                       child: Container(
//                                                         // width:
//                                                         //     double.infinity,
//                                                         // color: ColorSelect.east_blue,
//                                                         padding:
//                                                             EdgeInsets.all(
//                                                                 10),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                               S
//                                                                   .of(context)
//                                                                   .FromDate,
//                                                               style: TextController
//                                                                   .BodyHeadingText,
//                                                             ),
//                                                             SizedBox(
//                                                               height: 15,
//                                                             ),
//                                                             Container(
//                                                               padding: EdgeInsets.symmetric(
//                                                                   horizontal:
//                                                                       10),
//                                                               width: double
//                                                                   .infinity,
//                                                               height: 35,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .centerLeft,
//                                                               decoration: BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   border: Border.all(
//                                                                       color:
//                                                                           ColorSelect.textField)),
//                                                               child:
//                                                                   TextFormField(
//                                                                 textAlignVertical:
//                                                                     TextAlignVertical
//                                                                         .center,
//                                                                 style: TextController
//                                                                     .BodyHeadingText,
//                                                                 controller:
//                                                                     FromDate,
//                                                                 decoration: InputDecoration(
//                                                                     suffixIcon: Icon(
//                                                                       Icons.calendar_month_outlined,
//                                                                       size:
//                                                                           15,
//                                                                     ),
//                                                                     isDense: true,
//                                                                     hintText: S.of(context).DateFormat,
//                                                                     hintStyle: TextController.labelText,
//                                                                     border: InputBorder.none),
//                                                                 //readOnly: true,
//                                                                 onTap:
//                                                                     () async {
//                                                                   DateTime? datepicked = await showDatePicker(
//                                                                       context:
//                                                                           context,
//                                                                       initialDate:
//                                                                           DateTime.now(),
//                                                                       firstDate: DateTime(2023),
//                                                                       lastDate: DateTime(3000));
//                                                                   if (datepicked !=
//                                                                       null) {
//                                                                     print(
//                                                                         datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
//                                                                     String
//                                                                         formattedDate =
//                                                                         DateFormat('yyyy-MM-dd').format(datepicked!);
//                                                                     WidgetsBinding
//                                                                         .instance
//                                                                         .addPostFrameCallback((_) => setState((FromDate.text = formattedDate) as VoidCallback));
//                                                                     // format date in required form here we use yyyy-MM-dd that means time is remove
//                                                                   } else {
//                                                                     print(
//                                                                         "Date is not selected");
//                                                                   }
//                                                                 },
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Flexible(
//                                                       child: Container(
//                                                         // width:
//                                                         //     double.infinity,
//                                                         // color: ColorSelect.east_blue,
//                                                         padding:
//                                                             EdgeInsets.all(
//                                                                 10),
//                                                         child: Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                               S
//                                                                   .of(context)
//                                                                   .ToDate,
//                                                               style: TextController
//                                                                   .BodyHeadingText,
//                                                             ),
//                                                             SizedBox(
//                                                               height: 15,
//                                                             ),
//                                                             Container(
//                                                               padding: EdgeInsets.symmetric(
//                                                                   horizontal:
//                                                                       10),
//                                                               width: double
//                                                                   .infinity,
//                                                               height: 35,
//                                                               alignment:
//                                                                   Alignment
//                                                                       .centerLeft,
//                                                               decoration: BoxDecoration(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   border: Border.all(
//                                                                       color:
//                                                                           ColorSelect.textField)),
//                                                               child:
//                                                                   TextFormField(
//                                                                 textAlignVertical:
//                                                                     TextAlignVertical
//                                                                         .center,
//                                                                 style: TextController
//                                                                     .BodyHeadingText,
//                                                                 controller:
//                                                                     ToDate,
//                                                                 decoration: InputDecoration(
//                                                                     suffixIcon: Icon(
//                                                                       Icons.calendar_month_outlined,
//                                                                       size:
//                                                                           15,
//                                                                     ),
//                                                                     isDense: true,
//                                                                     hintText: S.of(context).DateFormat,
//                                                                     hintStyle: TextController.labelText,
//                                                                     border: InputBorder.none),
//                                                                 //readOnly: true,
//                                                                 onTap:
//                                                                     () async {
//                                                                   DateTime? datepicked = await showDatePicker(
//                                                                       context:
//                                                                           context,
//                                                                       initialDate:
//                                                                           DateTime.now(),
//                                                                       firstDate: DateTime(2023),
//                                                                       lastDate: DateTime(3000));
//                                                                   if (datepicked !=
//                                                                       null) {
//                                                                     print(
//                                                                         datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
//                                                                     String
//                                                                         formattedDate =
//                                                                         DateFormat('yyyy-MM-dd').format(datepicked!);
//                                                                     WidgetsBinding
//                                                                         .instance
//                                                                         .addPostFrameCallback((_) => setState((ToDate.text = formattedDate) as VoidCallback));
//                                                                     // format date in required form here we use yyyy-MM-dd that means time is remove
//                                                                   } else {
//                                                                     print(
//                                                                         "Date is not selected");
//                                                                   }
//                                                                 },
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.end,
//                                               children: [
//                                                 Flexible(
//                                                   child: Container(
//                                                     height: 35,
//                                                     width: 140,
//                                                     margin:
//                                                         EdgeInsets.fromLTRB(
//                                                             10, 0, 20, 10),
//                                                     color: ColorSelect
//                                                         .east_blue,
//                                                     child: TextButton(
//                                                       style: TextButton
//                                                           .styleFrom(
//                                                         side: BorderSide(
//                                                           width: 1.0,
//                                                           color: Color(
//                                                               0xFFC9BBBB),
//                                                         ),
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       0),
//                                                         ),
//                                                       ),
//                                                       onPressed: () {
//                                                         fetchDataFromAPI();
//                                                       },
//                                                       child: Text(
//                                                         S
//                                                             .of(context)
//                                                             .search,
//                                                         style:
//                                                             TextController
//                                                                 .btnText,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                             vertical: 15, horizontal: 20),
//                                         decoration: BoxDecoration(
//                                           border: Border(
//                                             top: BorderSide(
//                                               color: ColorSelect
//                                                   .tabBorderColor,
//                                               width: 1,
//                                             ),
//                                             bottom: BorderSide(
//                                               color: ColorSelect
//                                                   .tabBorderColor,
//                                               width: 1,
//                                             ),
//                                           ),
//                                         ),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment
//                                                   .spaceBetween,
//                                           children: [
//                                             Flexible(
//                                               child: Container(
//                                                 child: Text(
//                                                   S.of(context).FullName,
//                                                   style: TextController
//                                                       .SubHeadingText,
//                                                 ),
//                                               ),
//                                             ),
//                                             Flexible(
//                                               child: Container(
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .end,
//                                                   children: [
//                                                     Text(
//                                                       "Edit",
//                                                       style: TextController
//                                                           .SubHeadingText,
//                                                     ),
//                                                     Container(
//                                                       margin:
//                                                           EdgeInsets.only(
//                                                         left: 25,
//                                                       ),
//                                                       child: Text(
//                                                         "Delete",
//                                                         style: TextController
//                                                             .SubHeadingText,
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Expanded(
//                                         // height: 500,
//                                         child: ListView.builder(
//                                           itemCount: drafts.length,
//                                           itemBuilder:
//                                               (BuildContext context,
//                                                   int index) {
//                                             final draftsList = drafts;
//                                             final key = draftskey[index];
//                                             return Container(
//                                               width: 100,
//                                               decoration: BoxDecoration(
//                                                 border: Border(
//                                                   bottom: BorderSide(
//                                                     color: ColorSelect
//                                                         .tabBorderColor,
//                                                     width: 0.5,
//                                                   ),
//                                                 ),
//                                               ),
//                                               padding:
//                                                   EdgeInsets.symmetric(
//                                                       vertical: 5,
//                                                       horizontal: 20),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Flexible(
//                                                     child: Container(
//                                                       child: Text(
//                                                         draftsList[index],
//                                                         style: TextController
//                                                             .SubHeadingText,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Flexible(
//                                                     child: Container(
//                                                       child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .end,
//                                                         children: [
//                                                           IconButton(
//                                                               iconSize:
//                                                                   20,
//                                                               icon:
//                                                                   const Icon(
//                                                                 Icons
//                                                                     .edit,
//                                                                 color: Color(
//                                                                     0xFF565252),
//                                                               ),
//                                                               onPressed:
//                                                                   () {
//                                                                 clientIdentification(
//                                                                     int.parse(
//                                                                         key));
//                                                                 print(
//                                                                     clientType);
//                                                                 print(
//                                                                     key);
//                                                                 if (clientType ==
//                                                                     "Individual") {
//                                                                   Navigator.of(context).push(MaterialPageRoute(
//                                                                       builder: (context) =>
//                                                                           new newInd("Draft")));
//                                                                 } else if (clientType ==
//                                                                     "Corporate") {
//                                                                   Navigator.of(context).push(MaterialPageRoute(
//                                                                       builder: (context) =>
//                                                                           new CorporateKYC("Draft")));
//                                                                 } else if (clientType ==
//                                                                     "POA") {
//                                                                   Navigator.of(context).push(MaterialPageRoute(
//                                                                       builder: (context) =>
//                                                                           new POAKYC("Draft")));
//                                                                 }

//                                                                 var type =
//                                                                     'draft';
//                                                               }),
//                                                           Container(
//                                                             margin: EdgeInsets
//                                                                 .only(
//                                                                     left:
//                                                                         25),
//                                                             child: IconButton(
//                                                                 iconSize: 20,
//                                                                 icon: const Icon(
//                                                                   Icons
//                                                                       .delete,
//                                                                   color: Color(
//                                                                       0xFF565252),
//                                                                 ),
//                                                                 onPressed: () {}),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           if (sidebarVisible) SideBar() else Container(),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Navigation(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
