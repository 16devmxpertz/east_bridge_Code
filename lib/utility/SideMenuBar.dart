// import 'package:east_bridge/Agreement%20Masters/FundSelecion.dart';

import 'package:east_bridge/ANBAccountAllocationIndividual.dart';
import 'package:east_bridge/Advisory/Advisory%20PDF%20UploadDownload/AgreementPdfDownloadUpload.dart';
import 'package:east_bridge/Advisory/Advisory%20Redeem/AdvisoryRedeem.dart';
import 'package:east_bridge/Advisory/Advisory%20Subscribe/AdvisorySubscribe.dart';
import 'package:east_bridge/Advisory/AdvisoryAgreementNew/tabOfAgreement.dart';
import 'package:east_bridge/Advisory/AssignAdvisoryManager.dart';
import 'package:east_bridge/Advisory/MileStoneScreenAdvisory.dart';
import 'package:east_bridge/Advisory/SubServiceCreation/tabOfSubServiceCreactionAdvisory.dart';
import 'package:east_bridge/Approval/approval.dart';
import 'package:east_bridge/Arranging/Arranging%20PDF%20UploadDownload/AgreementPdfDownloadUpload.dart';
import 'package:east_bridge/Arranging/Arranging%20Redeem/ArrangingRedeem.dart';
import 'package:east_bridge/Arranging/Arranging%20Subscribe/ArrangingSubscribe.dart';
import 'package:east_bridge/Arranging/ArrangingAgreementNew/tabOfAgreement.dart';
import 'package:east_bridge/Arranging/ArrangingCustomerAgreement/Customer%20Arranging%20Agreement/Customer%20Arranging%20Agreement/CustomerMilestoneArrangingFeesAgreement.dart';
import 'package:east_bridge/Arranging/AssignArrangingManager.dart';
import 'package:east_bridge/Arranging/SubServiceCreation/tabOfSubServiceCreactionArranging.dart';
import 'package:east_bridge/Arranging/mileStoneScreenArranging.dart';
import 'package:east_bridge/DPM/AssignPortfolioManager.dart';
import 'package:east_bridge/DPM/Buy.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/CustomerDPMAgreement.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/EditDPMAgreementSearch.dart';
import 'package:east_bridge/DPM/DPMAgreementDownload.dart/DPMPdfDownloadUpload.dart';
import 'package:east_bridge/DPM/PortfolioCreation/TabOfShareCreation.dart';
import 'package:east_bridge/DPM/Sell.dart';
import 'package:east_bridge/DPM/ShareCreation.dart/TabOfShareCreation.dart';
import 'package:east_bridge/Fund%20Creation/FundReports/ReportsDownload.dart';
import 'package:east_bridge/Fund%20Creation/FundReports/ReportsSearch.dart';
import 'package:east_bridge/Fund%20Creation/TabOfFundCreation.dart';
import 'package:east_bridge/Fund%20Reedem/FundReedem.dart';
import 'package:east_bridge/Fund%20Subscribe/FundSubscribe.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/AgreementPdfDownloadUpload.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/CustomerFundAgreement.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/POAClientList.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/POAKYC.dart';
import 'package:east_bridge/KYC/KYC%20Components/IndividualClientList.dart';
import 'package:east_bridge/KYC/KYC%20Components/KYC%20pdf%20Upload/KYCPdfUploadIND.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/RiskAssessmentFormCorporate.dart';
import 'package:east_bridge/RiskAssessmentFormInvidual.dart';
import 'package:east_bridge/RiskAssessmentFormPOA.dart';
import 'package:east_bridge/User%20Management/UserManagement.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';

import '../Advisory/AdvisoryCustomerAgreement/Customer Advisory Agreement/Customer Advisory Agreement/CustomerMilestoneArrangingFeesAgreement.dart';
import '../KYC/KYC Components (Corporate)/CorporateClientList.dart';
import '../KYC/corporate.dart';
import '../Log In/Login.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(0),
        height: 900,
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorSelect.east_grey,
          ),
        ),
        child: ListView(
          // scrollDirection: Axis.horizontal,
          children: [
            TreeView(
              treeController: TreeController(allNodesExpanded: false),
              nodes: [
                //Dashboard
                TreeNode(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: ColorSelect.bodytext,
                          size: 25,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          S.of(context).Dashboard,
                          style: TextController.SideMenuText,
                        ),
                      ],
                    ),
                    children: [
                      if (GlobalPermission.userType == "Admin")
                        TreeNode(
                          content: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UserManagement(),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).UserManagement,
                              style: TextController.SideMenuText,
                            ),
                          ),
                        ),
                      if (GlobalPermission.userType == "Admin")
                        TreeNode(
                          content: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Approval(),
                                ),
                              );
                            },
                            child: Text(
                              "Form Approval",
                              style: TextController.SideMenuText,
                            ),
                          ),
                        )
                    ]),

                //kyc
                TreeNode(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.people,
                          color: ColorSelect.bodytext,
                          size: 25,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          S.of(context).KYC,
                          style: TextController.SideMenuText,
                        ),
                      ],
                    ),
                    children: [
                      TreeNode(
                          content: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => IndividualClientList(),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).Individual,
                              style: TextController.SideMenuText,
                            ),
                          ),
                          children: [
                            TreeNode(
                              content: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RiskForm()));
                                },
                                child: Text(
                                  S.of(context).RiskAssessment,
                                  style: TextController.SideMenuText,
                                ),
                              ),
                            ),
                          ]),
                      TreeNode(
                          content: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      new CorporateClientList()));
                            },
                            child: Text(
                              S.of(context).Institutional,
                              style: TextController.SideMenuText,
                            ),
                          ),
                          children: [
                            TreeNode(
                              content: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          RiskFormCorporate()));
                                },
                                child: Text(
                                  S.of(context).RiskAssessment,
                                  style: TextController.SideMenuText,
                                ),
                              ),
                            ),
                          ]),
                      TreeNode(
                          content: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => POAClientList(),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).PowerOfAttorneyn,
                              style: TextController.SideMenuText,
                            ),
                          ),
                          children: [
                            TreeNode(
                              content: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RiskFormPOA()));
                                },
                                child: Text(
                                  S.of(context).RiskAssessment,
                                  style: TextController.SideMenuText,
                                ),
                              ),
                            ),
                          ]),
                      TreeNode(
                        content: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => KYCPdfUploadIND()));
                          },
                          child: Text(
                            S.of(context).KYCUpload,
                            style: TextController.SideMenuText,
                          ),
                        ),
                      ),
                      TreeNode(
                        content: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ANBAccountIndividual()));
                          },
                          child: Text(
                            S.of(context).ANBBankAccountAllocation,
                            style: TextController.SideMenuText,
                          ),
                        ),
                      ),
                    ]),

                //funds
                TreeNode(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'images/fund_icon.png',
                        height: 20,
                        width: 20,
                        color: ColorSelect.bodytext,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).Fund,
                        style: TextController.SideMenuText,
                      ),
                    ],
                  ),
                  children: [
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TabOfFundCreation()));
                        },
                        child: Text(
                          S.of(context).FundCreation,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CustomerFundAgreement()));
                        },
                        child: Text(
                          S.of(context).FundAgreement,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FundSubscribe()));
                        },
                        child: Text(
                          S.of(context).FundSubscribe,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FundReedem()));
                        },
                        child: Text(
                          S.of(context).FundReedem,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AgreementPdfDownloadUpload()));
                        },
                        child: Text(
                          S.of(context).AgreementUpload,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) =>
                          //         CorporateKYC("Insert")));
                        },
                        child: Text(
                          S.of(context).Reports,
                          style: TextController.SideMenuText,
                        ),
                      ),
                      children: [
                        TreeNode(
                          content: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ReportsDownload(
                                    type: 'Trading',
                                  ),
                                ),
                              );
                              ReportsSearch.type.value = 'Trading';
                            },
                            child: Text(
                              "Trading Movements",
                              style: TextController.SideMenuText,
                            ),
                          ),
                        ),
                        TreeNode(
                          content: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ReportsDownload(
                                    type: 'Realized',
                                  ),
                                ),
                              );
                              ReportsSearch.type.value = 'Realized';
                            },
                            child: Text(
                              "Realized P/L",
                              style: TextController.SideMenuText,
                            ),
                          ),
                        ),
                        TreeNode(
                          content: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ReportsDownload(
                                    type: 'OrderHistory',
                                  ),
                                ),
                              );
                              ReportsSearch.type.value = 'OrderHistory';
                            },
                            child: Text(
                              "Order History",
                              style: TextController.SideMenuText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                //DPM
                TreeNode(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.handshake,
                        color: ColorSelect.bodytext,
                        size: 25,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).DPM,
                        style: TextController.SideMenuText,
                      ),
                    ],
                  ),
                  children: [
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TabOfShareCreation(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).ShareCreation,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TabOfPortfolioCreationDPM(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).PortfolioCreation,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditDPMAgreementSearch(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).DPMAgreement,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CustomerDPMAgreement(),
                            ),
                          );
                        },
                        child: Text(
                          "Customer DPM Agreement",
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AssignPortfolioManager(),
                            ),
                          );
                        },
                        child: Text(
                          "Assign Portfolio Manager",
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DPMBuy(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).Buy,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DPMSell(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).Sell,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DPMPdfDownloadUpload(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).AgreementUpload,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    )
                  ],
                ),

                //NDPM
                // TreeNode(
                //     content: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Icon(
                //           Icons.contacts_outlined,
                //           color: ColorSelect.bodytext,
                //           size: 25,
                //         ),
                //         SizedBox(
                //           width: 30,
                //         ),
                //         Text(
                //           S.of(context).NDPM,
                //           style: TextController.SideMenuText,
                //         ),
                //       ],
                //     ),
                //     children: [
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) => TabOfShareCreationNDPM(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).ShareCreation,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) => EditDPMAgreementSearch(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).NDPMAgreement,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) => CustomerNDPMAgreement(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             "Customer NDPM\n\nAgreement",
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) =>
                //                     AssignPortfolioManagerNDPM(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).AssignPortfolioManager,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) => NDPMBuy(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).Buy,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) => NDPMSell(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).Sell,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) => NDPMPdfDownloadUpload(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).AgreementUpload,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       )
                //     ]),

                //ADVISORY
                TreeNode(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.transfer_within_a_station_outlined,
                        color: ColorSelect.bodytext,
                        size: 25,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).Advisory,
                        style: TextController.SideMenuText,
                      ),
                    ],
                  ),
                  children: [
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  tabOfSubServiceCreactionAdvisory(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).AdvisoryServiceCreation,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => TabOfAgreement()),
                          );
                        },
                        child: Text(
                          S.of(context).AgreementAddUpdateDelete,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdvisoryAgreement(),
                            ),
                          );
                        },
                        child: Text(
                          'Link Agreement with\nCustomer',
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AssignAdvisoryManagerNDPM(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).AssignAdvisoryManager,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MileStoneScreenAdvisory(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).ExpenseTracker,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdvisorySubscribes(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).ServiceInitiation,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AdvisoryRedeems(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).ActivityUpdate,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    TreeNode(
                      content: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdvisoryAgreementPdfDownloadUpload(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).AgreementUpload,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                  ],
                ),

                //ARRANGING
                // TreeNode(
                //     content: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         Icon(
                //           Icons.event_note_sharp,
                //           color: ColorSelect.bodytext,
                //           size: 25,
                //         ),
                //         SizedBox(
                //           width: 30,
                //         ),
                //         Text(
                //           S.of(context).Arranging,
                //           style: TextController.SideMenuText,
                //         ),
                //       ],
                //     ),
                //     children: [
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {},
                //           child: Text(
                //             S.of(context).ServiceCreation,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {},
                //           child: Text(
                //             "Arranging Agreement",
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) =>
                //                     tabOfSubServiceCreactionArranging(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).ArrangingServiceCreationa,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                   builder: (context) => TabOfArrangingss()),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).AgreementAddUpdateDelete,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) => ArrangingAgreementLink(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).LinkAgreementwithCustomera,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) =>
                //                     AssignArrangingManagerNDPM(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).AssignArrangingManagera,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) =>
                //                     MileStoneScreenArranging(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).ExpenseTracker,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) => ArrangingSubscribes(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).ServiceInitiation,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) => ArrangingRedeems(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).ActivityUpdate,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //       TreeNode(
                //         content: GestureDetector(
                //           onTap: () {
                //             Navigator.of(context).push(
                //               MaterialPageRoute(
                //                 builder: (context) =>
                //                     ArrangingAgreementPdfDownloadUpload(),
                //               ),
                //             );
                //           },
                //           child: Text(
                //             S.of(context).AgreementUpload,
                //             style: TextController.SideMenuText,
                //           ),
                //         ),
                //       ),
                //     ]),

                TreeNode(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.logout,
                        color: ColorSelect.bodytext,
                        size: 25,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Logins(),
                          ));
                        },
                        child: Text(
                          S.of(context).SignOut,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ],
                  ),
                ),

                //profile
              ],
            ),
          ],
        ),
      ),
    );
  }
}
