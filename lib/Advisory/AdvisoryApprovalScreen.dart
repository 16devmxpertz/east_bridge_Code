import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:east_bridge/Advisory/AdvisoryBankDetails.dart';
import 'package:east_bridge/Advisory/AdvisoryCreation.dart';
import 'package:east_bridge/Advisory/AdvisoryDetails.dart';
import 'package:east_bridge/Advisory/AdvisoryFees.dart';

import 'package:east_bridge/Fund%20Creation/Fees.dart';
import 'package:east_bridge/Fund%20Creation/FundBankDetails.dart';
import 'package:east_bridge/Fund%20Creation/FundCreation.dart';
import 'package:east_bridge/Fund%20Creation/FundFinancialDetails.dart';
import 'package:east_bridge/KYC/KYC%20Components/ClientDeclaration.dart';
import 'package:east_bridge/KYC/KYC%20Components/DocumentUpload.dart';

import 'package:east_bridge/KYC/KYC Components/InvestmentPortfolioA.dart';
import 'package:east_bridge/KYC/KYC Components/InvestmentPortfolioB.dart';
import 'package:east_bridge/KYC/KYC%20Components/BankInfo.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/KYC/KYC%20Components/CustodianInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/GeneralInfo.dart';

import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';

import 'package:east_bridge/utility/responsive_layout.dart';
import 'package:east_bridge/generated/l10n.dart';

import '../Agreement Masters/CustomerAddAgreement.dart';

class TabOfAdvisory extends StatelessWidget {
  const TabOfAdvisory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      largeScreen: AdvisoryApprovalRequest(),
      //mediumScreen: MediumChild(),
      smallScreen: TabOfAdvisoryMob(),
    );
  }
}

//webKYC
class AdvisoryApprovalRequest extends StatefulWidget {
  const AdvisoryApprovalRequest({Key? key}) : super(key: key);

  @override
  State<AdvisoryApprovalRequest> createState() =>
      AdvisoryApprovalRequestState();
}

class AdvisoryApprovalRequestState extends State<AdvisoryApprovalRequest>
    with TickerProviderStateMixin {
  double yOffset = 0;
  double xOffset = 0;
  bool sidBarOpen = false;
  bool _sidebarVisible = false;

  bool _UsEntityUsSpecified = true;

  bool get sidebarVisible => _sidebarVisible;

  void toggleSidebar() {
    _sidebarVisible = !_sidebarVisible;
  }

  void setSideBarState() {
    setState(() {
      xOffset = sidBarOpen ? 250 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    int? selectedValue = 1;
    int _tabIndex = 0;

    TextEditingController _firstName = new TextEditingController();

    TabController tabController = TabController(length: 5, vsync: this);

    @override
    void initState() {
      super.initState();
      tabController = TabController(vsync: this, length: 4);
    }

    void _toggleTab() {
      _tabIndex = tabController.index + 1;
      tabController.animateTo(_tabIndex);
    }

    void _back() {
      _tabIndex = tabController.index - 1;
      tabController.animateTo(_tabIndex);
    }

    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
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
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Approved By",
                                          style: TextController.MainHeadingText
                                              .copyWith(fontSize: 20),
                                          selectionColor: ColorSelect.textField,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Table(
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                  height: 70,
                                                  color: ColorSelect.east_grey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Center(
                                                        child: Text(
                                                      "Complaince Approval",
                                                      style: TextController
                                                          .tableHeading,
                                                      maxLines: 3,
                                                    )),
                                                  )),
                                               Container(
                                                  height: 70,
                                                  color: ColorSelect.east_grey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Center(
                                                        child: Text(
                                                      "Approved",
                                                      style: TextController
                                                          .tableHeading,
                                                      maxLines: 3,
                                                    )),
                                                  )),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                  height: 70,
                                                  color: ColorSelect.east_grey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Center(
                                                        child: Text(
                                                      "Verification By Operation",
                                                      style: TextController
                                                          .tableHeading,
                                                      maxLines: 3,
                                                    )),
                                                  )),
                                              Container(
                                                  height: 70,
                                                  color: ColorSelect.east_grey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Center(
                                                        child: Text(
                                                      "Not Approved",
                                                      style: TextController
                                                          .tableHeading,
                                                      maxLines: 3,
                                                    )),
                                                  )),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                  height: 70,
                                                  color: ColorSelect.east_grey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Center(
                                                        child: Text(
                                                      "Finance Approved",
                                                      style: TextController
                                                          .tableHeading,
                                                      maxLines: 3,
                                                    )),
                                                  )),
                                              Container(
                                                  height: 70,
                                                  color: ColorSelect.east_grey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Center(
                                                        child: Text(
                                                      "Not Approved",
                                                      style: TextController
                                                          .tableHeading,
                                                      maxLines: 3,
                                                    )),
                                                  )),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                  height: 70,
                                                  color: ColorSelect.east_grey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Center(
                                                        child: Text(
                                                      "Is Sensitive Information",
                                                      style: TextController
                                                          .tableHeading,
                                                      maxLines: 3,
                                                    )),
                                                  )),
                                               Container(
                                                  height: 70,
                                                  color: ColorSelect.east_grey,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Center(
                                                        child: Text(
                                                      "Approved",
                                                      style: TextController
                                                          .tableHeading,
                                                      maxLines: 3,
                                                    )),
                                                  )),
                                            ]),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            height: 35,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              color: ColorSelect.east_blue,
                                            ),
                                            child: TextButton(
                                              onPressed: () {}, // Switch tabs
                                              child: Text(
                                                S.of(context).Next,
                                                style: TextController.btnText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
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
class TabOfAdvisoryMob extends StatefulWidget {
  const TabOfAdvisoryMob({Key? key}) : super(key: key);

  @override
  State<TabOfAdvisoryMob> createState() => _TabOfAdvisoryMobState();
}

class _TabOfAdvisoryMobState extends State<TabOfAdvisoryMob> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
