import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC Components (Corporate)/BankInfo.dart';
import 'package:east_bridge/KYC/KYC Components (Corporate)/OtherTab.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/AuthorizedR.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/CC3.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/CorporatedraftList.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/CustodianInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/DocumentUpload.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/Fatqa.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GeneralInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/contact.dart';
import 'package:east_bridge/KYC/KYC%20Components/KYC%20pdf%20Upload/KYCPdfUploadIND.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:east_bridge/utility/responsive_layout.dart';
import 'package:flutter/material.dart';

import 'KYC Components (Corporate)/ClientClassificationTabs/ClientClassificationTab.dart';
import 'KYC Components (Corporate)/InvestmentPortfolioACorporate.dart';
import 'KYC Components (Corporate)/InvestmentPortfolioBCorporate.dart';
import 'KYC Components (Corporate)/RegisteredAddress.dart';
import 'KYC Components (Corporate)/otherInformation.dart';

class IndividualKYC extends StatelessWidget {
  const IndividualKYC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: CorporateKYC(""),
      //mediumScreen: MediumChild(),
      smallScreen: IndividualKYCMob(),
    );
  }
}

//webKYC
class CorporateKYC extends StatefulWidget {
  //const CorporateKYC({Key? key}) : super(key: key);

  @override
  State<CorporateKYC> createState() => CorporateKYCState();
  CorporateKYC(@required pageType) {
    Type = pageType;
  }
}

String? Type;

class CorporateKYCState extends State<CorporateKYC>
    with TickerProviderStateMixin {
  // SideMenu Function Start
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

  late Map<String, dynamic> permission = {};

  // SideMenu Function End
  void a() async {
    var data = await GlobalPermission.formPermission("KYC Institutional");
    setState(() {
      permission = data;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      vsync: this,
      length: 13,
    );
    a();
  }

  TabController? tabController;

  @override
  Widget build(BuildContext context) {
    int? selectedValue = 1;
    int _tabIndex = 0;

    TextEditingController _firstName = new TextEditingController();

    //TabController tabController = TabController(length: 12, vsync: this);

    void _toggleTab() {
      _tabIndex = tabController!.index + 1;
      tabController!.animateTo(_tabIndex);
    }

    void _back() {
      _tabIndex = tabController!.index - 1;
      tabController!.animateTo(_tabIndex);
    }

    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                color: Colors.white,
                child: Column(
                  children: [
                    // Header(),
                    //Header(),

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
                                        builder: (context) => CorporateKYC(""),
                                      ));
                                    },
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
                                              style:
                                                  TextController.ControllerText,
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
                                              style:
                                                  TextController.ControllerText,
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
                                              style:
                                                  TextController.ControllerText,
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
                                              style:
                                                  TextController.ControllerText,
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
                                        builder: (context) => KYCPdfUploadIND(),
                                      ));
                                    },
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
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              // download
                              if (permission['Download'] == true)
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
                                        builder: (context) => KYCPdfUploadIND(),
                                      ));
                                    },
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
                                              style:
                                                  TextController.ControllerText,
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
                                          CorporateDraftList(),
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
                        AnimatedContainer(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          transform:
                              Matrix4.translationValues(xOffset, yOffset, 1.0),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      S.of(context).KnowYourClient,
                                      style: TextController.MainHeadingText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Center(
                                    child: Text(
                                      " (" +
                                          S.of(context).InstitutionalClient +
                                          ")",
                                      style: TextController.MainHeadingText,
                                    ),
                                  ),
                                ],
                              ),

                              //tabBar

                              Container(
                                width: double.infinity,
                                height: 80,
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
                                        physics: BouncingScrollPhysics(),
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
                                              S.of(context).GeneralInformation,
                                              style:
                                                  TextController.TabHeadingText,
                                            ),
                                          ),
                                          Tab(
                                              child: Text(
                                            S.of(context).RegisteredAddress,
                                            style:
                                                TextController.TabHeadingText,
                                          )),
                                          Tab(
                                              child: Text(
                                            S
                                                .of(context)
                                                .AuthorizedRepresentatives,
                                            style:
                                                TextController.TabHeadingText,
                                          )),
                                          Tab(
                                              child: Text(
                                            S.of(context).ClientClassification,
                                            style:
                                                TextController.TabHeadingText,
                                          )),
                                          Tab(
                                              child: Text(
                                            S.of(context).Contact,
                                            style:
                                                TextController.TabHeadingText,
                                          )),
                                          Tab(
                                              child: Text(
                                            S.of(context).BankInformation,
                                            style:
                                                TextController.TabHeadingText,
                                          )),
                                          Tab(
                                              child: Text(
                                            S.of(context).AdditionalInfo,
                                            style:
                                                TextController.TabHeadingText,
                                          )),
                                          Tab(
                                              child: Text(
                                            S.of(context).CustodianInformation,
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
                                            S.of(context).Fatca,
                                            style:
                                                TextController.TabHeadingText,
                                          )),
                                          Tab(
                                              child: Text(
                                            S.of(context).otherInformation,
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

                              // tabBarView

                              Flexible(
                                child: TabBarView(
                                  controller: tabController,
                                  // physics: NeverScrollableScrollPhysics(),
                                  children: [
                                    Generalinfo(
                                      controller: tabController,
                                    ),

                                    //postalAddress
                                    Registered_Address(
                                      controller: tabController,
                                    ),

                                    //employerInfo
                                    AuthorizedInfo(
                                      controller: tabController,
                                    ),

                                    //bankInfo
                                    CC3(
                                      controller: tabController,
                                    ),

                                    //professionalExperience
                                    ContactInfoo(
                                      controller: tabController,
                                    ),

                                    //custodianInfo
                                    BankInfo(
                                      controller: tabController,
                                    ),

                                    OtherInfoCorporate(
                                      controller: tabController,
                                    ),

                                    CustodianInfo(
                                      controller: tabController,
                                    ),

                                    //// Investment A
                                    InvestmentPortfolioACorporate(
                                      controller: tabController,
                                    ),

                                    //
                                    InvestmentPortfolioBCorporate(
                                      controller: tabController,
                                    ),

                                    //
                                    Fatqa(
                                      controller: tabController,
                                      textValue: '',
                                    ),

                                    //
                                    OtherTab(
                                      controller: tabController,
                                    ),
                                    //
                                    DocumentUploadCorporate(
                                      controller: tabController,
                                    ),

                                    ///
                                  ],
                                ),
                              ),
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
