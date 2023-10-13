// import 'dart:convert';

// import 'package:east_bridge/Agreement%20Masters/CustomerAddAgreement.dart';
// import 'package:east_bridge/Fund%20Creation/Fees.dart';
// import 'package:east_bridge/Fund%20Creation/FundBankDetails.dart';
// import 'package:east_bridge/Fund%20Creation/FundFinancialDetails.dart';
// import 'package:east_bridge/generated/l10n.dart';
// import 'package:east_bridge/utility/Colors.dart';
// import 'package:east_bridge/utility/TextController.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';

// class FundCreation extends StatefulWidget {
//   FundCreation({@required controller}) {
//     tabController = controller;
//   }

//   @override
//   State<FundCreation> createState() => FundCreationState();
// }

// TabController? tabController;

// String? selectedValue;

// TextEditingController FundProductCode = new TextEditingController();
// TextEditingController FundProductName = new TextEditingController();
// TextEditingController Description = new TextEditingController();
// TextEditingController bussinessPhone = new TextEditingController();
// TextEditingController addressForCorrespondense = new TextEditingController();
// TextEditingController Email = new TextEditingController();
// TextEditingController Mobile = new TextEditingController();
// TextEditingController radioTwo = new TextEditingController();
// TextEditingController radioThree = new TextEditingController();
// TextEditingController radioOne = new TextEditingController();
// TextEditingController dateController = new TextEditingController();

// String? dropdownvalue;
// String? dropdownvalue1;
// String? dropdownvalue2;

// class FundCreationState extends State<FundCreation> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController FromDate = new TextEditingController();
//   TextEditingController ToDate = new TextEditingController();
//   TextEditingController subscriptionPeriod = new TextEditingController();

//   late int id;

//   var items = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//   ];
//   var cateogry = [
//     'Large Cap',
//     'Medium Cap',
//     'Small Cap',
//   ];
//   var status = [
//     'Open Ended',
//     'Closed Ended',
//   ];
//   var type = [
//     'Public Equity',
//     'Private Equity',
//   ];

//   var industry = [
//     'Banking & Financial Services',
//     'Information Technology',
//     'Engineering & Capital Goods',
//     'Oil & Gas',
//     'Pharmaceuticals',
//     'Automotive',
//     'Chemicals',
//     'Utilities',
//     'Metals & Mining',
//     'Cement & Construction',
//     'Miscellaneous',
//     'Tobacco',
//     'Manufacturing',
//     'Telecommunication',
//     'Consumer Non-durables',
//     'Services',
//     'Conglomerates',
//     'Retail & Real Estate',
//     'Food & Beverages',
//     'Media & Entertainment',
//     'Consumer Durables',
//     'Tourism',
//   ];

//   void fundDetail() async {
//     var url = Uri.parse(
//         'https://eastbridge.online/apicore/api/FundDetailandClassification/FundDetailandClassification/');

//     try {
//       var headers = {
//         'Content-Type': 'application/json',
//       };

//       var body = {
//         "fundCode": FundProductCode.text,
//         "fundName": FundProductName.text,
//         "fundDescription": Description.text,
//         "industryCategory": dropdownvalue,
//         "fundTypes": dropdownvalue1,
//         "status": dropdownvalue2,
//         "fundAllotment": selectedValue,
//         "fromDate": FromDate.text,
//         "toDate": ToDate.text
//       };

//       var response =
//           await http.post(url, headers: headers, body: jsonEncode(body));

//       if (response.statusCode == 200) {
//         print(jsonDecode(response.body));
//         print(response.body);
//         id = int.parse(response.body);
//         // id = response.body;

//         FundFinancial.id.value = id;
//         print("----");
//         Fees.id.value = id;
//         print("----");
//         FundBankInfo.id.value = id;
//         print("----");
//         FundAgreementFinal.id.value = id;
//         print("----");

//         // return id;
//       } else {
//         print(response.statusCode);
//         showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text(
//                   S.of(context).Status,
//                   style: TextController.SubHeadingText,
//                 ),
//                 content: Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         S.of(context).SomethingWentWrong + "!",
//                         style: TextController.BodyText,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             });
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void updateSubscriptionPeriod() {
//     print("updating");

//     if (FromDate.text.isNotEmpty && ToDate.text.isNotEmpty) {
//       DateTime startDate = DateFormat('dd-MM-yyyy').parse(FromDate.text);
//       DateTime endDate = DateFormat('dd-MM-yyyy').parse(ToDate.text);

//       int daysDifference = endDate.difference(startDate).inDays;
//       print(daysDifference);
//       setState(() {
//         subscriptionPeriod.text = (daysDifference + 1).toString();
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       // subscriptionPeriod.text = daysDifference.toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // List of items in our dropdown menu

//     return Material(
//       child: SingleChildScrollView(
//         child: Container(
//           child: Form(
//             key: _formKey,
//             child: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 20,
//                     ),
//                     child: Text(
//                       S.of(context).FundDetails,
//                       style: TextController.BodyHeadingText,
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 20,
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: ColorSelect.textField)),
//                     height: 250,
//                     width: double.infinity,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 35,
//                               margin:
//                                   const EdgeInsets.only(top: 15, bottom: 15),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 S.of(context).FundProductCode,
//                                 style: TextController.BodyText,
//                               ),
//                             ),
//                             Container(
//                               height: 130,
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 S.of(context).Description,
//                                 style: TextController.BodyText,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(top: 15, bottom: 15),
//                                 padding: EdgeInsets.symmetric(horizontal: 15),
//                                 width: 400,
//                                 height: 35,
//                                 alignment: Alignment.centerLeft,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: ColorSelect.textField)),
//                                 child: TextFormField(
//                                   controller: FundProductCode,
//                                   style: TextController.BodyText,
//                                   textAlignVertical: TextAlignVertical.center,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'This field is required.';
//                                     }
//                                     return null; // Return null if the input is valid
//                                   },
//                                   decoration: InputDecoration(
//                                       errorStyle: TextController.inputErrorText,
//                                       isDense: true,
//                                       hintText: S.of(context).TypeHere,
//                                       hintStyle: TextController.labelText,
//                                       border: InputBorder.none),
//                                 ),
//                               ),
//                               Container(
//                                 width: 400,
//                                 height: 130,
//                                 padding: EdgeInsetsDirectional.symmetric(
//                                     horizontal: 15),
//                                 alignment: Alignment.centerLeft,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: ColorSelect.textField)),
//                                 child: TextFormField(
//                                   style: TextController.BodyText,
//                                   controller: Description,
//                                   keyboardType: TextInputType.multiline,
//                                   minLines: 1,
//                                   maxLines: 5,
//                                   textAlignVertical: TextAlignVertical.center,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'This field is required.';
//                                     }
//                                     return null; // Return null if the input is valid
//                                   },
//                                   decoration: InputDecoration(
//                                       errorStyle: TextController.inputErrorText,
//                                       isDense: true,
//                                       hintText: S.of(context).TypeHere,
//                                       hintStyle: TextController.labelText,
//                                       border: InputBorder.none),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 35,
//                               margin: const EdgeInsets.only(top: 15),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 S.of(context).FundProductName,
//                                 style: TextController.BodyText,
//                               ),
//                             ),
//                             Container(
//                               height: 35,
//                               margin: const EdgeInsets.only(top: 15),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 S.of(context).FromDate,
//                                 style: TextController.BodyText,
//                               ),
//                             ),
//                             Container(
//                               height: 35,
//                               margin: const EdgeInsets.only(top: 15),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 S.of(context).ToDate,
//                                 style: TextController.BodyText,
//                               ),
//                             ),
//                             Container(
//                               height: 35,
//                             ),
//                             Container(
//                               height: 35,
//                               // margin: const EdgeInsets.only(top: 15),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 S.of(context).subscriptionPeriod,
//                                 style: TextController.BodyText,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.only(top: 15),
//                                 padding: EdgeInsets.symmetric(horizontal: 15),
//                                 width: 400,
//                                 height: 35,
//                                 alignment: Alignment.centerLeft,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: ColorSelect.textField)),
//                                 child: TextFormField(
//                                   style: TextController.BodyText,
//                                   controller: FundProductName,
//                                   textAlignVertical: TextAlignVertical.center,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'This field is required.';
//                                     }
//                                     return null; // Return null if the input is valid
//                                   },
//                                   decoration: InputDecoration(
//                                       errorStyle: TextController.inputErrorText,
//                                       isDense: true,
//                                       hintText: S.of(context).TypeHere,
//                                       hintStyle: TextController.labelText,
//                                       border: InputBorder.none),
//                                 ),
//                               ),
//                               Container(
//                                 margin: const EdgeInsets.only(top: 15),
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 15,
//                                 ),
//                                 width: 400,
//                                 height: 35,
//                                 alignment: Alignment.centerLeft,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: ColorSelect.textField)),
//                                 child: TextFormField(
//                                   textAlignVertical: TextAlignVertical.center,
//                                   style: TextController.BodyText,
//                                   controller: FromDate,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'This field is required.';
//                                     }
//                                     return null; // Return null if the input is valid
//                                   },
//                                   // readOnly: true,
//                                   decoration: InputDecoration(
//                                       errorStyle: TextController.inputErrorText,
//                                       isDense: true,
//                                       suffixIcon: Icon(
//                                         Icons.calendar_month_outlined,
//                                         size: 15,
//                                       ),
//                                       hintText: S.of(context).DateFormat,
//                                       hintStyle: TextController.labelText,
//                                       border: InputBorder.none),
//                                   readOnly: true,
//                                   onTap: () async {
//                                     DateTime? datepicked = await showDatePicker(
//                                         context: context,
//                                         initialDate: DateTime.now(),
//                                         firstDate: DateTime.now(),
//                                         lastDate: DateTime(3000));
//                                     if (datepicked != null) {
//                                       print(
//                                           datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
//                                       String formattedDate =
//                                           DateFormat('dd-MM-yyyy')
//                                               .format(datepicked!);
//                                       WidgetsBinding.instance
//                                           .addPostFrameCallback((_) {
//                                         setState(() {
//                                           FromDate.text = formattedDate;
//                                         });
//                                       });
//                                       // format date in required form here we use yyyy-MM-dd that means time is remove
//                                     } else {
//                                       print("Date is not selected");
//                                     }
//                                   },
//                                 ),
//                               ),
//                               Container(
//                                 margin: const EdgeInsets.only(top: 15),
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 15,
//                                 ),
//                                 width: 400,
//                                 height: 35,
//                                 alignment: Alignment.centerLeft,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: ColorSelect.textField)),
//                                 child: TextFormField(
//                                   textAlignVertical: TextAlignVertical.center,
//                                   style: TextController.BodyText,
//                                   controller: ToDate,
//                                   readOnly: true,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'This field is required.';
//                                     }
//                                     return null; // Return null if the input is valid
//                                   },
//                                   decoration: InputDecoration(
//                                       errorStyle: TextController.inputErrorText,
//                                       isDense: true,
//                                       suffixIcon: Icon(
//                                         Icons.calendar_month_outlined,
//                                         size: 15,
//                                       ),
//                                       hintText: S.of(context).DateFormat,
//                                       hintStyle: TextController.labelText,
//                                       border: InputBorder.none),
//                                   //readOnly: true,
//                                   onTap: () async {
//                                     DateTime? datepicked = await showDatePicker(
//                                         context: context,
//                                         initialDate: DateTime.now(),
//                                         firstDate: DateTime.now(),
//                                         lastDate: DateTime(3000));
//                                     if (datepicked != null) {
//                                       print(
//                                           datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
//                                       String formattedDate =
//                                           DateFormat('dd-MM-yyyy')
//                                               .format(datepicked!);
//                                       WidgetsBinding.instance
//                                           .addPostFrameCallback((_) {
//                                         setState(() {
//                                           ToDate.text = formattedDate;
//                                         });
//                                       });
//                                       // format date in required form here we use yyyy-MM-dd that means time is remove
//                                     } else {
//                                       print("Date is not selected");
//                                     }
//                                   },
//                                 ),
//                               ),
//                               Container(
//                                 width: 400,
//                                 height: 35,
//                                 alignment: Alignment.centerRight,
//                                 child: TextButton(
//                                   style: ButtonStyle(
//                                       backgroundColor: MaterialStatePropertyAll(
//                                           ColorSelect.east_blue)),
//                                   child: Text(
//                                     "oooooooooo",
//                                     style: TextController.btnText,
//                                   ),
//                                   onPressed: () {
//                                     updateSubscriptionPeriod();
//                                   },
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 15),
//                                 width: 400,
//                                 height: 35,
//                                 alignment: Alignment.centerLeft,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     border: Border.all(
//                                         color: ColorSelect.textField)),
//                                 child: TextFormField(
//                                   style: TextController.BodyText,
//                                   controller: subscriptionPeriod,
//                                   keyboardType: TextInputType.number,
//                                   readOnly: true,
//                                   textAlignVertical: TextAlignVertical.center,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'This field is required.';
//                                     }
//                                     return null; // Return null if the input is valid
//                                   },
//                                   decoration: InputDecoration(
//                                       errorStyle: TextController.inputErrorText,
//                                       isDense: true,
//                                       hintText: S.of(context).inDays,
//                                       hintStyle: TextController.labelText,
//                                       border: InputBorder.none),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 20),
//                     child: Text(
//                       S.of(context).FundClassification,
//                       style: TextController.BodyHeadingText,
//                     ),
//                   ),
//                   Container(
//                     height: 300,
//                     width: double.infinity,
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 20),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 20),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: Border.all(color: ColorSelect.textField)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Container(
//                               height: 44,
//                               margin:
//                                   const EdgeInsets.only(top: 10, bottom: 10),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 S.of(context).IndustryCategory,
//                                 style: TextController.BodyText,
//                               ),
//                             ),
//                             Container(
//                               height: 44,
//                               margin:
//                                   const EdgeInsets.only(top: 10, bottom: 10),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 S.of(context).FundType,
//                                 style: TextController.BodyText,
//                               ),
//                             ),
//                             Container(
//                               height: 44,
//                               margin:
//                                   const EdgeInsets.only(top: 10, bottom: 10),
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 S.of(context).FundAllotment,
//                                 style: TextController.BodyText,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Flexible(
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                       top: 10, bottom: 10),
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 15,
//                                   ),
//                                   width: 400,
//                                   height: 44,
//                                   alignment: Alignment.centerLeft,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: ColorSelect.textField)),
//                                   child: DropdownButtonHideUnderline(
//                                     child: Theme(
//                                       data: Theme.of(context)
//                                           .copyWith(focusColor: Colors.white),
//                                       child: DropdownButtonFormField(
//                                         hint: Text(
//                                           S.of(context).SelectHere,
//                                           style: TextController.labelText,
//                                         ),
//                                         isExpanded: true,
//                                         icon: const Icon(
//                                             Icons.keyboard_arrow_down),
//                                         decoration: InputDecoration(
//                                           enabledBorder: InputBorder.none,
//                                           border: InputBorder.none,
//                                           hoverColor: Colors.white,
//                                         ),
//                                         items: industry.map((String items) {
//                                           return DropdownMenuItem(
//                                             value: items,
//                                             child: Text(items,
//                                                 style: TextController.BodyText),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             dropdownvalue = newValue!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Flexible(
//                                 child: Container(
//                                   margin:
//                                       const EdgeInsets.only(top: 10, bottom: 0),
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 15,
//                                   ),
//                                   width: 400,
//                                   height: 44,
//                                   alignment: Alignment.centerLeft,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: ColorSelect.textField)),
//                                   child: DropdownButtonHideUnderline(
//                                     child: Theme(
//                                       data: Theme.of(context)
//                                           .copyWith(focusColor: Colors.white),
//                                       child: DropdownButtonFormField(
//                                         hint: Text(
//                                           S.of(context).SelectHere,
//                                           style: TextController.labelText,
//                                         ),
//                                         isExpanded: true,
//                                         icon: const Icon(
//                                             Icons.keyboard_arrow_down),
//                                         decoration: InputDecoration(
//                                           enabledBorder: InputBorder.none,
//                                           border: InputBorder.none,
//                                           hoverColor: Colors.white,
//                                         ),
//                                         items: type.map((String items) {
//                                           return DropdownMenuItem(
//                                             value: items,
//                                             child: Text(items,
//                                                 style: TextController.BodyText),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             dropdownvalue1 = newValue!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Flexible(
//                                 child: Container(
//                                   height: 44,
//                                   margin: const EdgeInsets.only(
//                                     top: 20,
//                                   ),
//                                   alignment: Alignment.centerLeft,
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Flexible(
//                                         child: Text(
//                                           S.of(context).Cash,
//                                           style: TextController.BodyText,
//                                         ),
//                                       ),
//                                       Radio<String>(
//                                         value: "Cash",
//                                         groupValue: selectedValue,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             selectedValue =
//                                                 value!; //<-- change this
//                                           });
//                                         },
//                                       ),
//                                       SizedBox(
//                                         height: 60,
//                                       ),
//                                       Flexible(
//                                         child: Text(
//                                           S.of(context).cashKind,
//                                           style: TextController.BodyText,
//                                         ),
//                                       ),
//                                       Radio<String>(
//                                         value: "Cash & Kind",
//                                         groupValue: selectedValue,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             selectedValue =
//                                                 value!; //<-- change this
//                                           });
//                                         },
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Flexible(
//                                 child: Container(
//                                   height: 44,
//                                   margin: const EdgeInsets.only(
//                                       top: 20, bottom: 10),
//                                   child: Text(
//                                     S.of(context).Status,
//                                     style: TextController.BodyText,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Flexible(
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                       top: 10, bottom: 10),
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 15,
//                                   ),
//                                   width: 400,
//                                   height: 44,
//                                   alignment: Alignment.centerLeft,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       border: Border.all(
//                                           color: ColorSelect.textField)),
//                                   child: DropdownButtonHideUnderline(
//                                     child: Theme(
//                                       data: Theme.of(context)
//                                           .copyWith(focusColor: Colors.white),
//                                       child: DropdownButtonFormField(
//                                         hint: Text(
//                                           S.of(context).SelectHere,
//                                           style: TextController.labelText,
//                                         ),
//                                         isExpanded: true,
//                                         icon: const Icon(
//                                             Icons.keyboard_arrow_down),
//                                         decoration: InputDecoration(
//                                           enabledBorder: InputBorder.none,
//                                           border: InputBorder.none,
//                                           hoverColor: Colors.white,
//                                         ),
//                                         items: status.map((String items) {
//                                           return DropdownMenuItem(
//                                             value: items,
//                                             child: Text(items,
//                                                 style: TextController.BodyText),
//                                           );
//                                         }).toList(),
//                                         onChanged: (String? newValue) {
//                                           setState(() {
//                                             dropdownvalue2 = newValue!;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                         // alignment: Alignment.centerRight,
//                         height: 35,
//                         width: 140,
//                         color: ColorSelect.east_blue,
//                         child: TextButton(
//                           onPressed: () {
//                             print("=================");
//                             tabController!.animateTo(1);
//                             print("=================");

//                             // if (_formKey.currentState!.validate()) {
//                             //   _formKey.currentState?.save();

//                             //   fundDetail();
//                             // }
//                           }, // Switch tabs
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
//           ),
//         ),
//       ),
//     );
//   }
// }
