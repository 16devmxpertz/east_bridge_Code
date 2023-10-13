import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:east_bridge/KYC/KYC%20Components/BankInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/CC2.dart';
import 'package:east_bridge/KYC/KYC%20Components/ClientClassification.dart';
import 'package:east_bridge/KYC/KYC%20Components/ClientDeclaration.dart';
import 'package:east_bridge/KYC/KYC%20Components/CustodianInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/DocumentUpload.dart';
import 'package:east_bridge/KYC/KYC%20Components/EmployerInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/FATCA.dart';
import 'package:east_bridge/KYC/KYC%20Components/GeneralInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/Income&NetWorth.dart';
import 'package:east_bridge/KYC/KYC%20Components/InvestmentPortfolioA.dart';
import 'package:east_bridge/KYC/KYC%20Components/InvestmentPortfolioB.dart';
import 'package:east_bridge/KYC/KYC%20Components/OtherInfoIndividual.dart';
import 'package:east_bridge/KYC/KYC%20Components/Personalnfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/PostalAddress.dart';
import 'package:east_bridge/KYC/KYC%20Components/ProfessionalExp.dart';
import 'package:east_bridge/User%20Management/Component/AddUser.dart';
import 'package:east_bridge/User%20Management/Component/Permission.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:east_bridge/utility/globalvariable.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/utility/responsive_layout.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../utility/SideMenuBar.dart';

//webKYC
class UserManagement extends StatefulWidget {
  UserManagement({Key? key}) : super(key: key);

  @override
  State<UserManagement> createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement>
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

    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
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
                                Center(
                                  child: Text(
                                    S.of(context).UserManagement,
                                    style: TextController.MainHeadingText,
                                  ),
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
                                        horizontal: 20),
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
                                                S.of(context).AddUser,
                                                style: TextController
                                                    .TabHeadingText,
                                              ),
                                            ),
                                            Tab(
                                                child: Text(
                                              S.of(context).Permission,
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
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2,
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.2)),
                                      ],
                                      color: Color(0xFFFFFFFF),
                                    ),
                                    child: TabBarView(
                                      controller: tabController,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: [
                                        //personalInfo
                                        AddUser(
                                          controller: tabController,
                                        ),

                                        Permission(
                                          controller: tabController,
                                        ),
                                      ],
                                    ),
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
