import 'package:east_bridge/Advisory/Advisory%20Agreement%20Search/AdvisoryTemlpateSearch.dart';
import 'package:east_bridge/Advisory/MileStoneSearchAdvisory.dart';
import 'package:east_bridge/Advisory/expenseTrackerAdvisory.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/CustomerDPMAgreementSearch.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/ClientFundAgreementSearch.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/AgreementCustomerSearchComponent.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/CustomerAgreement.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/CustomerAgreementTemplate.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/CustomerDetails.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/CustomerListSearch.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/FundDetailsA.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/FundDetailsB.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/FundTemlpateSearch.dart';
import 'package:east_bridge/KYC/KYC%20Components/CC2.dart';
import 'package:east_bridge/KYC/KYC%20Components/Income&NetWorth.dart';
import 'package:east_bridge/KYC/KYC%20Components/Personalnfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/PostalAddress.dart';
import 'package:east_bridge/Search/CustomerSearchComponent.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';

//webKYC
class MileStoneScreenAdvisory extends StatefulWidget {
  MileStoneScreenAdvisory({Key? key}) : super(key: key);

  @override
  State<MileStoneScreenAdvisory> createState() =>
      _MileStoneScreenAdvisoryState();
}

class _MileStoneScreenAdvisoryState extends State<MileStoneScreenAdvisory>
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
  @override
  void initState() {
    tabController = TabController(
      vsync: this,
      length: 2,
    );

    super.initState();
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
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                color: Colors.white,
                child: SingleChildScrollView(
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
                            transform: Matrix4.translationValues(
                                xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Text(
                                      S.of(context).ExpenseTracker,
                                      style: TextController.MainHeadingText,
                                    )),
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
                                            // Tab(
                                            //   child: Text(
                                            //     S.of(context).search,
                                            //     style:
                                            //         TextController.TabHeadingText,
                                            //   ),
                                            // ),
                                            Tab(
                                              child: Text(
                                                S.of(context).CustomerSearch,
                                                style: TextController
                                                    .TabHeadingText,
                                              ),
                                            ),
                                            Tab(
                                              child: Text(
                                                S.of(context).expenseTracker,
                                                style: TextController
                                                    .TabHeadingText,
                                              ),
                                            ),
                                            // Tab(
                                            //   child: Text(
                                            //     S.of(context).AgreementSearch,
                                            //     style: TextController
                                            //         .TabHeadingText,
                                            //   ),
                                            // ),
                                            // Tab(
                                            //     child: Text(
                                            //   S.of(context).FundDetails,
                                            //   style:
                                            //       TextController.TabHeadingText,
                                            // )),
                                            // Tab(
                                            //     child: Text(
                                            //   S.of(context).FundDetails,
                                            //   style:
                                            //       TextController.TabHeadingText,
                                            // )),
                                            // Tab(
                                            //     child: Text(
                                            //   S
                                            //       .of(context)
                                            //       .MileStone,
                                            //   style:
                                            //       TextController.TabHeadingText,
                                            // )),
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
                                      // FundTemplateSearch(
                                      //   controller: tabController,
                                      // ),

                                      MileStoneSearchAdvisory(
                                        controller: tabController,
                                      ),
                                      ExpenseTrackerAdvisory(
                                        controller: tabController,
                                      ),

                                      // EditAdvisorygreementSearch(
                                      //   controller: tabController,
                                      // ),

                                      // //income&netWorth
                                      // AdvisoryDefaultdatalanaAgreement(
                                      //   controller: tabController,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (sidebarVisible) SideBar() else Container(),
                          // Consumer<SideBarProvider>(
                          //   builder: (_, provider, __) {
                          //     if (provider.sidebarVisible) {
                          //       return SideBar();
                          //     } else {
                          //       return Container();
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    ],
                  ),
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
class CustomerFundAgreementMob extends StatefulWidget {
  const CustomerFundAgreementMob({Key? key}) : super(key: key);

  @override
  State<CustomerFundAgreementMob> createState() =>
      _CustomerFundAgreementMobState();
}

class _CustomerFundAgreementMobState extends State<CustomerFundAgreementMob> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
