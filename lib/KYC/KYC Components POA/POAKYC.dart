import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:east_bridge/Global.dart';

import 'package:east_bridge/KYC/KYC%20Components%20POA/EmployerInfoPOA.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/OtherInfoPOA.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/POADraftList.dart';

import 'package:east_bridge/KYC/KYC%20Components%20POA/PersonalInfoPOA.dart';
import 'package:east_bridge/KYC/KYC%20Components/BankInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/ClientClassification.dart';
import 'package:east_bridge/KYC/KYC%20Components/ClientDeclaration.dart';
import 'package:east_bridge/KYC/KYC%20Components/CustodianInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/DocumentUpload.dart';
import 'package:east_bridge/KYC/KYC%20Components/FATCA.dart';
import 'package:east_bridge/KYC/KYC%20Components/GeneralInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/Income&NetWorth.dart';
import 'package:east_bridge/KYC/KYC%20Components/InvestmentPortfolioA.dart';
import 'package:east_bridge/KYC/KYC%20Components/InvestmentPortfolioB.dart';
import 'package:east_bridge/KYC/KYC%20Components/KYC%20pdf%20Upload/KYCPdfUploadIND.dart';
import 'package:east_bridge/KYC/KYC%20Components/Personalnfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/PostalAddress.dart';
import 'package:east_bridge/KYC/KYC%20Components/ProfessionalExp.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/utility/responsive_layout.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../utility/SideMenuBar.dart';
import 'ClientClassificationPOA.dart';

import 'DocumentUploadPOA.dart';
import 'GeneralInfoPOA.dart';
import 'InvestmentPortfolioAPOA.dart';
import 'InvestmentPortfolioBPOA.dart';
import 'PostalAddressPOA.dart';
import 'ProfessionalExpPOA.dart';

class IndividualKYC extends StatelessWidget {
  const IndividualKYC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: POAKYC(""),
      //mediumScreen: MediumChild(),
      smallScreen: IndividualKYCMob(),
    );
  }
}

//webKYC
class POAKYC extends StatefulWidget {
  // POAKYC({Key? key}) : super(key: key);

  @override
  State<POAKYC> createState() => _POAKYCState();
  POAKYC(@required pageType) {
    Type = pageType;
  }
}

String? Type;

class _POAKYCState extends State<POAKYC>
    with TickerProviderStateMixin, WidgetsBindingObserver {
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

  final _formKey = GlobalKey<FormState>();
  TabController? tabController;
  late Map<String, dynamic> permission = {};

  void a() async {
    var data = await GlobalPermission.formPermission("KYC POA");
    setState(() {
      permission = data;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 10,
    );
    a();
  }

  @override
  Widget build(BuildContext context) {
    int? selectedValue = 1;
    int _tabIndex = 0;

    TextEditingController _firstName = new TextEditingController();

    void _toggleTab() {
      //_tabIndex = tabController?.index + 1;
      tabController?.animateTo(_tabIndex);
    }

    void _back() {
      // _tabIndex = tabController?.index - 1;
      tabController?.animateTo(_tabIndex);
    }

    String dropdownvalue;

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      // Header(),

                      // HEADER START
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
                                if (permission['New'] == true)
                                  Container(
                                    // width: 100,
                                    height: 44,
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => POAKYC(""),
                                        ));
                                      },
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
                                if (permission['Edit'] == true)
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
                                if (permission['View'] == true)
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
                                if (permission['Delete'] == true)
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
                                if (permission['Print'] == true)
                                  Container(
                                    // width: 100,
                                    height: 44,
                                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) =>
                                              KYCPdfUploadIND(),
                                        ));
                                      },
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
                                //
                                if (permission['Download'] == true)
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
                                    onPressed: () {
                                        Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            POADraftList(),
                                      ));
                                    },
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
                                              "Draft",
                                              style:
                                                  TextController.ControllerText,
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
                          // SideBar(),
                          AnimatedContainer(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            transform: Matrix4.translationValues(
                                xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                      S.of(context).KnowYourClient +
                                          " " +
                                          S.of(context).POAn,
                                      style: TextController.MainHeadingText,
                                    )),
                                    // SizedBox(
                                    //   width: 2,
                                    // ),
                                    // Center(
                                    //     child: Text(
                                    //   S.of(context).POA,
                                    //   style: TextController.SubHeadingText,
                                    // )),
                                  ],
                                ),

                                //tabBar

                                Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: ColorSelect.east_grey,
                                    border: Border.all(
                                      color: ColorSelect.tabBorderColor,
                                    ),
                                  ),
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      width: double.infinity,
                                      height: 35,
                                      child: Material(
                                        child: TabBar(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          labelColor: Colors.white,
                                          unselectedLabelColor:
                                              ColorSelect.tabTextColor,
                                          dividerColor:
                                              ColorSelect.tabBorderColor,
                                          indicator: BoxDecoration(
                                            border: Border.all(
                                              color: ColorSelect.tabBorderColor,
                                            ),
                                            color: ColorSelect.east_blue,
                                          ),
                                          controller: tabController,
                                          isScrollable: true,
                                          labelPadding: EdgeInsets.symmetric(
                                              horizontal: 20),

                                          //tabs
                                          tabs: [
                                            Tab(
                                              child: Text(
                                                S
                                                    .of(context)
                                                    .PersonalInformation,
                                                style: TextController
                                                    .TabHeadingText,
                                              ),
                                            ),
                                            Tab(
                                                child: Text(
                                              S
                                                  .of(context)
                                                  .ClientClassification,
                                              style:
                                                  TextController.TabHeadingText,
                                            )),
                                            Tab(
                                                child: Text(
                                              S.of(context).PostalAddress,
                                              style:
                                                  TextController.TabHeadingText,
                                            )),
                                            Tab(
                                                child: Text(
                                              S.of(context).EmployerInformation,
                                              style:
                                                  TextController.TabHeadingText,
                                            )),
                                            Tab(
                                                child: Text(
                                              S
                                                  .of(context)
                                                  .ProfessionalExperience,
                                              style:
                                                  TextController.TabHeadingText,
                                            )),
                                            Tab(
                                                child: Text(
                                              S.of(context).GeneralInformation,
                                              style:
                                                  TextController.TabHeadingText,
                                            )),
                                            Tab(
                                                child: Text(
                                              S.of(context).InvestmentPortfolio,
                                              style:
                                                  TextController.TabHeadingText,
                                            )),
                                            Tab(
                                                child: Text(
                                              S.of(context).InvestmentPortfolio,
                                              style:
                                                  TextController.TabHeadingText,
                                            )),
                                            Tab(
                                                child: Text(
                                              S.of(context).OtherInfo,
                                              style:
                                                  TextController.TabHeadingText,
                                            )),
                                            Tab(
                                                child: Text(
                                              S.of(context).DocumentUpload,
                                              style:
                                                  TextController.TabHeadingText,
                                            )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //tabBarView

                                Expanded(
                                    child: TabBarView(
                                  controller: tabController,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    //personalInfo
                                    PersonalInfoPOA(
                                      controller: tabController,
                                      type: Type,
                                    ),

                                    ClientClassificationPOA(
                                      controller: tabController,
                                    ),

                                    //postalAddress
                                    PostalAddressPOA(
                                      controller: tabController,
                                    ),

                                    //income&netWorth

                                    //employerInfo
                                    EmployerInfoPOA(controller: tabController),

                                    //bankInfo

                                    //professionalExperience
                                    ProfessionalExpPOA(
                                        controller: tabController),
                                    //generalInfo
                                    GeneralInfoPOA(
                                      controller: tabController,
                                    ),

                                    //investmentPortfoliA
                                    InvestmentPortfolioAPOA(
                                      controller: tabController,
                                    ),

                                    //investmentPortfoliB
                                    InvestmentPortfolioBPOA(
                                      controller: tabController,
                                    ),

                                    //fatca
                                    OtherInfoPOA(
                                      controller: tabController,
                                    ),

                                    //DocumentUpload
                                    DocumentUploadPOA(
                                      controller: tabController,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                          if (sidebarVisible) SideBar() else Container(),
                        ],
                      ),
                    ],
                  ),
                ),
                Navigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//MobKYC
class IndividualKYCMob extends StatefulWidget {
  const IndividualKYCMob({Key? key}) : super(key: key);

  @override
  State<IndividualKYCMob> createState() => _IndividualKYCMobState();
}

class _IndividualKYCMobState extends State<IndividualKYCMob> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
