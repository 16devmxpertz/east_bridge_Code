// import 'package:buttons_tabbar/buttons_tabbar.dart';
// import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/AuthorizedR.dart';
// import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/BankInfo.dart';
// import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/ClientDeclaration.dart';
// import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/DocumentUpload.dart';
// import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/Fatqa.dart';
// import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GeneralInfo.dart';
// import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/RegisteredAddress.dart';
// import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/contact.dart';
// import 'package:east_bridge/KYC/KYC%20Components/BankInfo.dart';

// import 'package:east_bridge/KYC/KYC%20Components/ClientDeclaration.dart';
// import 'package:east_bridge/KYC/KYC%20Components/CustodianInfo.dart';
// import 'package:east_bridge/KYC/KYC%20Components/DocumentUpload.dart';

// import 'package:east_bridge/KYC/KYC%20Components/GeneralInfo.dart';
// import 'package:buttons_tabbar/buttons_tabbar.dart';
// import 'package:east_bridge/KYC/KYC%20Components/ClientDeclaration.dart';
// import 'package:east_bridge/KYC/KYC%20Components/DocumentUpload.dart';
// import 'package:east_bridge/KYC/KYC Components/InvestmentPortfolioA.dart';
// import 'package:east_bridge/KYC/KYC Components/InvestmentPortfolioB.dart';
// import 'package:east_bridge/KYC/KYC%20Components/BankInfo.dart';
// import 'package:east_bridge/KYC/KYC%20Components/CustodianInfo.dart';
// import 'package:east_bridge/KYC/KYC%20Components/GeneralInfo.dart';
// import 'package:east_bridge/utility/Colors.dart';
// import 'package:east_bridge/utility/Header.dart';
// import 'package:east_bridge/utility/TextController.dart';
// import 'package:flutter/material.dart';
// import 'package:east_bridge/utility/responsive_layout.dart';
// import 'package:east_bridge/generated/l10n.dart';

// import 'package:east_bridge/utility/Colors.dart';
// import 'package:east_bridge/utility/Header.dart';
// import 'package:east_bridge/utility/TextController.dart';
// import 'package:flutter/material.dart';
// import 'package:east_bridge/utility/responsive_layout.dart';
// import 'package:east_bridge/generated/l10n.dart';
// import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

// class IndividualKYC extends StatelessWidget {
//   const IndividualKYC({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveLayout(
//       largeScreen: newInd(),
//       //mediumScreen: MediumChild(),
//       smallScreen: IndividualKYCMob(),
//     );
//   }
// }

// //webKYC
// class newInd extends StatefulWidget {
//   newInd({Key? key}) : super(key: key);

//   @override
//   State<newInd> createState() => _newIndState();
// }

// class _newIndState extends State<newInd>
//     with TickerProviderStateMixin, WidgetsBindingObserver {
//   double yOffset = 0;
//   double xOffset = 0;
//   bool sidBarOpen = false;

//   void setSideBarState() {
//     setState(() {
//       xOffset = sidBarOpen ? 250 : 0;
//     });
//   }

//   final _formKey = GlobalKey<FormState>();
//   TabController? tabController;
//   @override
//   void initState() {
//     tabController = TabController(
//       vsync: this,
//       length: 13,
//     );

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     int? selectedValue = 1;
//     int _tabIndex = 0;

//     TextEditingController _firstName = new TextEditingController();

//     void _toggleTab() {
//       //_tabIndex = tabController?.index + 1;
//       tabController?.animateTo(_tabIndex);
//     }

//     void _back() {
//       // _tabIndex = tabController?.index - 1;
//       tabController?.animateTo(_tabIndex);
//     }

//     String dropdownvalue;

//     // List of items in our dropdown menu
//     var items = [
//       'Item 1',
//       'Item 2',
//       'Item 3',
//       'Item 4',
//       'Item 5',
//     ];

//     return SingleChildScrollView(
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight: 817,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Header(),
//               Stack(
//                 children: [
//                   SideBar(),
//                   GestureDetector(
//                     onTap: () {
//                       sidBarOpen = !sidBarOpen;
//                       setSideBarState();
//                     },
//                     child: AnimatedContainer(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                       transform:
//                           Matrix4.translationValues(xOffset, yOffset, 1.0),
//                       duration: Duration(milliseconds: 200),
//                       curve: Curves.easeInOut,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Center(
//                                   child: Text(
//                                 S.of(context).KnowYourClient,
//                                 style: TextController.MainHeadingText,
//                               )),
//                               SizedBox(
//                                 width: 2,
//                               ),
//                               Center(
//                                   child: Text(
//                                 S.of(context).IndividualAccount,
//                                 style: TextController.SubHeadingText,
//                               )),
//                             ],
//                           ),

//                           //tabBar

//                           Container(
//                             width: double.infinity,
//                             height: 60,
//                             decoration: BoxDecoration(
//                               color: ColorSelect.east_grey,
//                               border: Border.all(
//                                 color: ColorSelect.tabBorderColor,
//                               ),
//                             ),
//                             alignment: AlignmentDirectional.centerStart,
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 50),
//                               child: Container(
//                                 margin: EdgeInsets.all(10),
//                                 width: double.infinity,
//                                 height: 35,
//                                 child: Material(
//                                   child: TabBar(
//                                     physics: NeverScrollableScrollPhysics(),
//                                     labelColor: Colors.white,
//                                     unselectedLabelColor:
//                                         ColorSelect.tabTextColor,
//                                     dividerColor: ColorSelect.tabBorderColor,
//                                     indicator: BoxDecoration(
//                                       border: Border.all(
//                                         color: ColorSelect.tabBorderColor,
//                                       ),
//                                       color: ColorSelect.east_blue,
//                                     ),
//                                     controller: tabController,
//                                     isScrollable: true,
//                                     labelPadding:
//                                         EdgeInsets.symmetric(horizontal: 20),

//                                     //tabs
//                                     tabs: [
//                                       Tab(
//                                         child: Text(
//                                           S.of(context).PersonalInformation,
//                                           style: TextController.TabHeadingText,
//                                         ),
//                                       ),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).ClientClassification,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).PostalAddress,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).NetWorth,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).EmployerInformation,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).BankInformation,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).ProfessionalExperience,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).GeneralInformation,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).CustodianInformation,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).InvestmentPortfolioA,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).InvestmentPortfolioA,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).Fatca,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                       Tab(
//                                           child: Text(
//                                         S.of(context).DocumentUpload,
//                                         style: TextController.TabHeadingText,
//                                       )),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),

//                           //tabBarView

//                           Expanded(
//                               child: TabBarView(
//                             controller: tabController,
//                             physics: NeverScrollableScrollPhysics(),
//                             children: [
//                               //personalInfo
//                               Generalinfo(
//                                 controller: tabController,
//                               ),

//                               Registered_Address(
//                                 controller: tabController,
//                               ),

//                               //postalAddress
//                               AuthorizedInfo(
//                                 controller: tabController,
//                               ),

//                               //income&netWorth
//                               BankInfo(
//                                 controller: tabController,
//                               ),

//                               //employerInfo
//                               ContactInfoo(controller: tabController),

//                               //bankInfo
//                               BankInfo(
//                                 controller: tabController,
//                               ),

//                               //professionalExperience
//                               //  OtherInfo(controller: tabController),
//                               //generalInfo
//                               CustodianInfo(
//                                 controller: tabController,
//                               ),

//                               //custodianInfo
//                               InvestmentPortfolioA(
//                                 controller: tabController,
//                               ),

//                               //investmentPortfoliA
//                               InvestmentPortfolioB(
//                                 controller: tabController,
//                               ),

//                               //investmentPortfoliB
//                               Fatqa(
//                                 controller: tabController, textValue: '',
//                               ),

//                               //fatca
//                               DocumentUploadCorporate(
//                                 controller: tabController,
//                               ),

//                               //DocumentUpload
//                               ClientDec(),
//                             ],
//                           ))
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// SideBar() {}

// //MobKYC
// class IndividualKYCMob extends StatefulWidget {
//   const IndividualKYCMob({Key? key}) : super(key: key);

//   @override
//   State<IndividualKYCMob> createState() => _IndividualKYCMobState();
// }

// class _IndividualKYCMobState extends State<IndividualKYCMob> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
