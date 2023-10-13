import 'package:east_bridge/ANBAccountAllocationIndividual.dart';
import 'package:east_bridge/Advisory/Advisory%20Invoice/AdvisoryInvoiceNew.dart';
import 'package:east_bridge/Advisory/Advisory%20Redeem/AdvisoryRedeem.dart';
import 'package:east_bridge/Advisory/Advisory%20Subscribe/AdvisorySubscribe.dart';
import 'package:east_bridge/Advisory/AdvisoryAgreementNew/tabOfAgreement.dart';
import 'package:east_bridge/Advisory/SubServiceCreation/tabOfSubServiceCreactionAdvisory.dart';
import 'package:east_bridge/Advisory/expenseTrackerAdvisory.dart';
import 'package:east_bridge/Approval/approval.dart';
import 'package:east_bridge/DPM/AssignPortfolioManager.dart';
import 'package:east_bridge/DPM/Buy.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/CustomerDPMAgreement.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/EditDPMAgreementSearch.dart';
import 'package:east_bridge/DPM/DPMAgreementDownload.dart/DPMPdfDownloadUpload.dart';
import 'package:east_bridge/DPM/PortfolioCreation/TabOfShareCreation.dart';
import 'package:east_bridge/DPM/Sell.dart';
import 'package:east_bridge/DPM/ShareCreation.dart/TabOfShareCreation.dart';
import 'package:east_bridge/Forgot%20Password/ForgotPassword.dart';
import 'package:east_bridge/Fund%20Creation/FundList.dart';
import 'package:east_bridge/Fund%20Creation/FundReports/ReportsDownload.dart';
import 'package:east_bridge/Fund%20Creation/FundReports/ReportsSearch.dart';
import 'package:east_bridge/Fund%20Creation/FundReports/ReportsView.dart';
import 'package:east_bridge/Fund%20Creation/TabOfFundCreation.dart';
import 'package:east_bridge/Fund%20Invoice/fundInvoiceList.dart';
import 'package:east_bridge/Fund%20Reedem/FundReedem.dart';
import 'package:east_bridge/Fund%20Subscribe/FundSubscribe.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/AgreementPdfDownloadUpload.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/CustomerFundAgreement.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/CorporateClientList.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/POAClientList.dart';
import 'package:east_bridge/KYC/KYC%20Components/IndividualClientList.dart';
import 'package:east_bridge/KYC/KYC%20Components/KYC%20pdf%20Upload/KYCPdfUploadIND.dart';
import 'package:east_bridge/RiskAssessmentFormCorporate.dart';
import 'package:east_bridge/RiskAssessmentFormInvidual.dart';
import 'package:east_bridge/RiskAssessmentFormPOA.dart';
import 'package:east_bridge/Setup/Master/masterMain.dart';
import 'package:east_bridge/Setup/Organizational%20Setting/companyDetailsNew.dart';
import 'package:east_bridge/User%20Management/UserManagement.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Advisory/AdvisoryCustomerAgreement/Customer Advisory Agreement/Customer Advisory Agreement/CustomerMilestoneArrangingFeesAgreement.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  bool isSetupHovered = false;
  bool isKycHovered = false;
  bool isFundHovered = false;
  bool isDPMHovered = false;
  bool isNDPmHovered = false;
  bool isAdvisoryHovered = false;
  bool isReportHovered = false;
  bool isOperationHovered = false;
  bool isArrangingHovered = false;
  bool isIndividualHovered = false;
  bool isfundlistHovered = false;
  bool isUAlistHovered = false;
  bool isMasterlistHovered = false;
  bool isComplilistHovered = false;
  bool isDPMReportHoverd = false;
  bool isClientReportHoverd = false;
  bool isFundReportHovered = false;

  bool isInstiHovered = false;
  bool isPOAHovered = false;
  bool isDraftHovered = false;

  static _launchUrl(String formname) async {
    // formname = formname.split('~')[1];

    // Replace 'your_username' and 'your_password' with your actual credentials
    var username = 'Administrator';
    var password = 'hX9b7aBd\$2Z';
    var url = Uri.parse(
        "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${formname}&rs:Command=Render");

    //   if (await canLaunchUrl(url)) {
    //     await launchUrl(url);
    //   } else {
    //     print("error can' ssrs launch");
    //   }
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
            height: 40,
            width: double.infinity,
            color: ColorSelect.east_blue,
          ),
          Container(
            width: double.infinity,
            color: Colors.transparent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dashboard
                MouseRegion(
                  onEnter: (isHovered) {
                    setState(() {
                      isSetupHovered = true;
                    });
                  },
                  onExit: (isHovered) {
                    setState(() {
                      isSetupHovered = false;
                    });
                  },
                  child: Stack(
                    children: [
                      // DashboardDropdown
                      if (isSetupHovered)
                        Container(
                          width: 150,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromRGBO(0, 0, 0, 0.363),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CompanyDetailsNew(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      S.of(context).OrganizationalSetting,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MasterMain(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      S.of(context).Master,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 30,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            isUAlistHovered = !isUAlistHovered;
                                          },
                                        );
                                      },
                                      child: Icon(
                                        (isUAlistHovered)
                                            ? Icons.expand_more
                                            : Icons.arrow_forward_ios_rounded,
                                        color: ColorSelect.tabTextColor,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         newInd("Insert"),
                                      //   ),
                                      // );
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "User\nAuthentication",
                                        style: NavTextController.ControllerText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (isUAlistHovered)
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserManagement(),
                                            ),
                                          );
                                          // ReportsSearch.type.value =
                                          //     'Order History';
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "User Management",
                                              style: NavTextController
                                                  .ControllerText,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: ColorSelect.tabBorderColor,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => Approval(),
                                            ),
                                          );
                                          // ReportsSearch.type.value =
                                          //     'Cash Statement';
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Approval",
                                              style: NavTextController
                                                  .ControllerText,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: ColorSelect.tabBorderColor,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgotPasswordNew(),
                                            ),
                                          );
                                          // ReportsSearch.type.value =
                                          //     'Cash Statement';
                                        },
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Forgot Password",
                                              style: NavTextController
                                                  .ControllerText,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: isSetupHovered
                              ? ColorSelect.east_dark_blue
                              : ColorSelect.east_blue,
                          border: Border(
                            left: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.settings_outlined,
                                size: 20,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  S.of(context).Setup,
                                  style: TextController.ControllerText,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // KYC
                MouseRegion(
                  onEnter: (isHovered) {
                    setState(() {
                      isKycHovered = true;
                    });
                  },
                  onExit: (isHovered) {
                    setState(() {
                      isKycHovered = false;
                    });
                  },
                  child: Stack(
                    children: [
                      // Kyc Dropdown
                      if (isKycHovered)
                        Container(
                          width: 150,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromRGBO(0, 0, 0, 0.363),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: TextButton(
                              //     onPressed: () {},
                              //     child: Container(
                              //       padding:
                              //           EdgeInsets.symmetric(vertical: 15),
                              //       child: Text(
                              //         S.of(context).KYCForm,
                              //         style:
                              //             NavTextController.ControllerText,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  isIndividualHovered =
                                                      !isIndividualHovered;
                                                });
                                              },
                                              child: Icon(
                                                (isIndividualHovered)
                                                    ? Icons.expand_more
                                                    : Icons
                                                        .arrow_forward_ios_rounded,
                                                color: ColorSelect.tabTextColor,
                                                size: 14,
                                              )),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    IndividualClientList(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Text(
                                              S.of(context).Individual,
                                              style: NavTextController
                                                  .ControllerText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isIndividualHovered)
                                      Container(
                                        width: double.infinity,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RiskForm(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                S.of(context).RiskAssessment,
                                                style: NavTextController
                                                    .ControllerText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  isInstiHovered =
                                                      !isInstiHovered;
                                                });
                                              },
                                              child: Icon(
                                                (isInstiHovered)
                                                    ? Icons.expand_more
                                                    : Icons
                                                        .arrow_forward_ios_rounded,
                                                color: ColorSelect.tabTextColor,
                                                size: 14,
                                              )),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        new CorporateClientList()));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Text(
                                              S.of(context).Institutional,
                                              style: NavTextController
                                                  .ControllerText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isInstiHovered)
                                      Container(
                                        width: double.infinity,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RiskFormCorporate(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                S.of(context).RiskAssessment,
                                                style: NavTextController
                                                    .ControllerText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  isPOAHovered = !isPOAHovered;
                                                });
                                              },
                                              child: Icon(
                                                (isPOAHovered)
                                                    ? Icons.expand_more
                                                    : Icons
                                                        .arrow_forward_ios_rounded,
                                                color: ColorSelect.tabTextColor,
                                                size: 14,
                                              )),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    POAClientList(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Text(
                                              "POA",
                                              style: NavTextController
                                                  .ControllerText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isPOAHovered)
                                      Container(
                                        width: double.infinity,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RiskFormPOA(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                S.of(context).RiskAssessment,
                                                style: NavTextController
                                                    .ControllerText,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               CorporateKYC("Insert"),
                              //         ),
                              //       );
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text(
                              //         S.of(context).Institutional,
                              //         style: NavTextController.ControllerText,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (context) => POAKYC("Insert"),
                              //         ),
                              //       );
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text(
                              //         S.of(context).PowerOfAttorney,
                              //         style: NavTextController.ControllerText,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => KYCPdfUploadIND(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).KYCUpload,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ANBAccountIndividual(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      S.of(context).ANBBankAccountAllocation,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: Column(
                              //     children: [
                              //       Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         children: [
                              //           Container(
                              //             width: 30,
                              //             child: TextButton(
                              //                 onPressed: () {
                              //                   setState(() {
                              //                     isDraftHovered =
                              //                         !isDraftHovered;
                              //                   });
                              //                 },
                              //                 child: Icon(
                              //                   (isDraftHovered)
                              //                       ? Icons.expand_more
                              //                       : Icons
                              //                           .arrow_forward_ios_rounded,
                              //                   color: ColorSelect.tabTextColor,
                              //                   size: 14,
                              //                 )),
                              //           ),
                              //           TextButton(
                              //             onPressed: () {},
                              //             child: Container(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 15),
                              //               child: Text(
                              //                 S.of(context).Drafts,
                              //                 style: NavTextController
                              //                     .ControllerText,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       if (isDraftHovered)
                              //         Container(
                              //           width: double.infinity,
                              //           child: TextButton(
                              //             onPressed: () {
                              //               Navigator.of(context).push(
                              //                 MaterialPageRoute(
                              //                   builder: (context) =>
                              //                       IndividualDraftList(),
                              //                 ),
                              //               );
                              //             },
                              //             child: Container(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 5),
                              //               child: Align(
                              //                 alignment: Alignment.centerRight,
                              //                 child: Text(
                              //                   "Individual",
                              //                   style: NavTextController
                              //                       .ControllerText,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: isKycHovered
                              ? ColorSelect.east_dark_blue
                              : ColorSelect.east_blue,
                          border: Border(
                            left: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.people,
                                size: 20,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  S.of(context).KYC,
                                  style: TextController.ControllerText,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Fund
                MouseRegion(
                  onEnter: (isHovered) {
                    setState(() {
                      isFundHovered = true;
                    });
                  },
                  onExit: (isHovered) {
                    setState(() {
                      isFundHovered = false;
                    });
                  },
                  child: Stack(
                    children: [
                      // fund Dropdown
                      if (isFundHovered)
                        Container(
                          width: 150,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromRGBO(0, 0, 0, 0.363),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => fundList(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).FundCreation,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerFundAgreement(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).FundAgreement,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FundSubscribe(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).FundSubscribe,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FundReedem(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).FundReedem,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AgreementPdfDownloadUpload(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).AgreementUpload,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (context) => AgreementSearch(),
                              //         ),
                              //       );
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text(
                              //         S.of(context).AgreementSearch,
                              //         style: NavTextController.ControllerText,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FundInvoiceList(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).Invoice,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: Column(
                              //     children: [
                              //       Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         children: [
                              //           Container(
                              //             width: 30,
                              //             child: TextButton(
                              //                 onPressed: () {
                              //                   setState(() {
                              //                     isfundlistHovered =
                              //                         !isfundlistHovered;
                              //                   });
                              //                 },
                              //                 child: Icon(
                              //                   (isfundlistHovered)
                              //                       ? Icons.expand_more
                              //                       : Icons
                              //                           .arrow_forward_ios_rounded,
                              //                   color: ColorSelect.tabTextColor,
                              //                   size: 14,
                              //                 )),
                              //           ),
                              //           TextButton(
                              //             onPressed: () {
                              //               // Navigator.of(context).push(
                              //               //   MaterialPageRoute(
                              //               //     builder: (context) =>
                              //               //         newInd("Insert"),
                              //               //   ),
                              //               // );
                              //             },
                              //             child: Container(
                              //               padding: EdgeInsets.symmetric(
                              //                   vertical: 15),
                              //               child: Text(
                              //                 S.of(context).Reports,
                              //                 style: NavTextController
                              //                     .ControllerText,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       Container(
                              //         width: double.infinity,
                              //         decoration: BoxDecoration(
                              //           border: Border(
                              //             bottom: BorderSide(
                              //               color: ColorSelect.tabBorderColor,
                              //               width: 1.0,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       if (isfundlistHovered)
                              //         Column(
                              //           children: [
                              //             Container(
                              //               width: double.infinity,
                              //               child: TextButton(
                              //                 onPressed: () {
                              //                   Navigator.of(context).push(
                              //                     MaterialPageRoute(
                              //                       builder: (context) =>
                              //                           ReportsDownload(
                              //                         type: 'Trading',
                              //                       ),
                              //                     ),
                              //                   );
                              //                   ReportsSearch.type.value =
                              //                       'Trading';
                              //                 },
                              //                 child: Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 5),
                              //                   child: Align(
                              //                     alignment:
                              //                         Alignment.centerRight,
                              //                     child: Text(
                              //                       "Trading Movements",
                              //                       style: NavTextController
                              //                           .ControllerText,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //             Container(
                              //               width: double.infinity,
                              //               decoration: BoxDecoration(
                              //                 border: Border(
                              //                   bottom: BorderSide(
                              //                     color: ColorSelect
                              //                         .tabBorderColor,
                              //                     width: 1.0,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //             Container(
                              //               width: double.infinity,
                              //               child: TextButton(
                              //                 onPressed: () {
                              //                   Navigator.of(context).push(
                              //                     MaterialPageRoute(
                              //                       builder: (context) =>
                              //                           ReportsDownload(
                              //                         type: 'Realized',
                              //                       ),
                              //                     ),
                              //                   );
                              //                   ReportsSearch.type.value =
                              //                       'Realized';
                              //                 },
                              //                 child: Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 5),
                              //                   child: Align(
                              //                     alignment:
                              //                         Alignment.centerRight,
                              //                     child: Text(
                              //                       "Realized P/L",
                              //                       style: NavTextController
                              //                           .ControllerText,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //             Container(
                              //               width: double.infinity,
                              //               decoration: BoxDecoration(
                              //                 border: Border(
                              //                   bottom: BorderSide(
                              //                     color: ColorSelect
                              //                         .tabBorderColor,
                              //                     width: 1.0,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //             Container(
                              //               width: double.infinity,
                              //               child: TextButton(
                              //                 onPressed: () {
                              //                   Navigator.of(context).push(
                              //                     MaterialPageRoute(
                              //                       builder: (context) =>
                              //                           ReportsDownload(
                              //                         type: 'OrderHistory',
                              //                       ),
                              //                     ),
                              //                   );
                              //                   ReportsSearch.type.value =
                              //                       'OrderHistory';
                              //                 },
                              //                 child: Container(
                              //                   padding: EdgeInsets.symmetric(
                              //                       vertical: 5),
                              //                   child: Align(
                              //                     alignment:
                              //                         Alignment.centerRight,
                              //                     child: Text(
                              //                       "Order History",
                              //                       style: NavTextController
                              //                           .ControllerText,
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //             Container(
                              //               width: double.infinity,
                              //               decoration: BoxDecoration(
                              //                 border: Border(
                              //                   bottom: BorderSide(
                              //                     color: ColorSelect
                              //                         .tabBorderColor,
                              //                     width: 1.0,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: isFundHovered
                              ? ColorSelect.east_dark_blue
                              : ColorSelect.east_blue,
                          border: Border(
                            left: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'images/fund_icon.png',
                                height: 20,
                                width: 20,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  S.of(context).Fund,
                                  style: TextController.ControllerText,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // DPM
                MouseRegion(
                  onEnter: (isHovered) {
                    setState(() {
                      isDPMHovered = true;
                    });
                  },
                  onExit: (isHovered) {
                    setState(() {
                      isDPMHovered = false;
                    });
                  },
                  child: Stack(
                    children: [
                      if (isDPMHovered)
                        Container(
                          width: 150,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromRGBO(0, 0, 0, 0.363),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TabOfShareCreation(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).ShareCreation,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TabOfPortfolioCreationDPM(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).PortfolioCreation,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditDPMAgreementSearch(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).DPMAgreement,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerDPMAgreement(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Customer DPM\n\nAgreement",
                                      textAlign: TextAlign.center,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AssignPortfolioManager(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Assign Portfolio\n\nManager",
                                      textAlign: TextAlign.center,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DPMBuy(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).Buy,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DPMSell(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).Sell,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DPMPdfDownloadUpload(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).AgreementUpload,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (context) => DPMInvoiceMain(),
                              //         ),
                              //       );
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text(
                              //         S.of(context).Invoice,
                              //         style: NavTextController.ControllerText,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: isDPMHovered
                              ? ColorSelect.east_dark_blue
                              : ColorSelect.east_blue,
                          border: Border(
                            left: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 0.5,
                            ),
                            right: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.handshake,
                                size: 20,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  S.of(context).DPM,
                                  style: TextController.ControllerText,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // NDPM
                // MouseRegion(
                //   onEnter: (isHovered) {
                //     setState(() {
                //       isNDPmHovered = true;
                //     });
                //   },
                //   onExit: (isHovered) {
                //     setState(() {
                //       isNDPmHovered = false;
                //     });
                //   },
                //   child: Stack(
                //     children: [
                //       if (isNDPmHovered)
                //         Container(
                //           width: 150,
                //           margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             boxShadow: [
                //               BoxShadow(
                //                 blurRadius: 3,
                //                 color: Color.fromRGBO(0, 0, 0, 0.363),
                //               ),
                //             ],
                //           ),
                //           child: Column(
                //             children: [
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             TabOfShareCreationNDPM(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).ShareCreation,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             TabOfPortfolioCreationNDPM(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).PortfolioCreation,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             EditDPMAgreementSearch(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).NDPMAgreement,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             CustomerNDPMAgreement(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     alignment: Alignment.center,
                //                     padding: EdgeInsets.symmetric(vertical: 10),
                //                     child: Text(
                //                       textAlign: TextAlign.center,
                //                       "Customer NDPM\n\nAgreement",
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             AssignPortfolioManagerNDPM(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     alignment: Alignment.center,
                //                     padding: EdgeInsets.symmetric(vertical: 10),
                //                     child: Text(
                //                       "Assign Portfolio\n\nManager",
                //                       textAlign: TextAlign.center,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) => NDPMBuy(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).Buy,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) => NDPMSell(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).Sell,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             NDPMPdfDownloadUpload(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).AgreementUpload,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       Container(
                //         height: 40,
                //         width: 150,
                //         decoration: BoxDecoration(
                //           color: isNDPmHovered
                //               ? ColorSelect.east_dark_blue
                //               : ColorSelect.east_blue,
                //           border: Border(
                //             left: BorderSide(
                //               color: ColorSelect.east_grey,
                //               width: 0.5,
                //             ),
                //             right: BorderSide(
                //               color: ColorSelect.east_grey,
                //               width: 0.5,
                //             ),
                //           ),
                //         ),
                //         child: TextButton(
                //           onPressed: () {},
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Icon(
                //                 Icons.contacts_outlined,
                //                 size: 20,
                //                 color: Colors.white,
                //               ),
                //               Container(
                //                 margin: EdgeInsets.symmetric(horizontal: 5),
                //                 child: Text(
                //                   S.of(context).NDPM,
                //                   style: TextController.ControllerText,
                //                 ),
                //               ),
                //               Icon(
                //                 Icons.arrow_drop_down,
                //                 size: 20,
                //                 color: Colors.white,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                // Advisory
                MouseRegion(
                  onEnter: (isHovered) {
                    setState(() {
                      isAdvisoryHovered = true;
                    });
                  },
                  onExit: (isHovered) {
                    setState(() {
                      isAdvisoryHovered = false;
                    });
                  },
                  child: Stack(
                    children: [
                      if (isAdvisoryHovered)
                        Container(
                          width: 150,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromRGBO(0, 0, 0, 0.363),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (context) => TabOffAdvisory(),
                              //         ),
                              //       );
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text(
                              //         S.of(context).Creation,
                              //         style: NavTextController.ControllerText,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            tabOfSubServiceCreactionAdvisory(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      S.of(context).AdvisoryServiceCreation,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TabOfAgreement()),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).AgreementAddUpdateDelete,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdvisoryAgreement(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      S.of(context).LinkAgreementwithCustomer,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               AdvisoryApprovalRequest(),
                              //         ),
                              //       );
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text(
                              //         S.of(context).ApprovalScreen,
                              //         style: NavTextController.ControllerText,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       bottom: BorderSide(
                              //         color: ColorSelect.tabBorderColor,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //   ),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               AssignAdvisoryManagerNDPM(),
                              //         ),
                              //       );
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text(
                              //         textAlign: TextAlign.center,
                              //         S.of(context).AssignAdvisoryManager,
                              //         style: NavTextController.ControllerText,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ExpenseTrackerAdvisory(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).ExpenseTracker,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdvisorySubscribes(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).ServiceInitiation,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => AdvisoryRedeems(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).ActivityUpdate,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdvisoryInvoiceList(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    child: Text(
                                      S.of(context).Invoice,
                                      style: NavTextController.ControllerText,
                                    ),
                                  ),
                                ),
                              )

                              // Container(
                              //   width: double.infinity,
                              //   decoration: BoxDecoration(),
                              //   child: TextButton(
                              //     onPressed: () {
                              //       Navigator.of(context).push(
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               KYCPdfUploadIND(),
                              //         ),
                              //       );
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.symmetric(vertical: 15),
                              //       child: Text(
                              //         S.of(context).AgreementUpload,
                              //         style: NavTextController.ControllerText,
                              //       ),
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: isAdvisoryHovered
                              ? ColorSelect.east_dark_blue
                              : ColorSelect.east_blue,
                          border: Border(
                            left: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 0.5,
                            ),
                            right: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.transfer_within_a_station_outlined,
                                size: 20,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  S.of(context).Advisory,
                                  style: TextController.ControllerText,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MouseRegion(
                  onEnter: (isHovered) {
                    setState(() {
                      isOperationHovered = true;
                    });
                  },
                  onExit: (isHovered) {
                    setState(() {
                      isOperationHovered = false;
                    });
                  },
                  child: Stack(
                    children: [
                      if (isOperationHovered)
                        Container(
                          width: 150,
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                color: Color.fromRGBO(0, 0, 0, 0.363),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  isfundlistHovered =
                                                      !isfundlistHovered;
                                                },
                                              );
                                            },
                                            child: Icon(
                                              (isfundlistHovered)
                                                  ? Icons.expand_more
                                                  : Icons
                                                      .arrow_forward_ios_rounded,
                                              color: ColorSelect.tabTextColor,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Navigator.of(context).push(
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         newInd("Insert"),
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Text(
                                              S.of(context).Operation,
                                              style: NavTextController
                                                  .ControllerText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isfundlistHovered)
                                      Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReportsDownload(
                                                      type: 'Trading Movements',
                                                    ),
                                                  ),
                                                );
                                                ReportsSearch.type.value =
                                                    'Trading Movements';
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Trading Movements",
                                                    style: NavTextController
                                                        .ControllerText,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ColorSelect
                                                      .tabBorderColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReportsDownload(
                                                      type: 'Realized P/L',
                                                    ),
                                                  ),
                                                );
                                                ReportsSearch.type.value =
                                                    'Realized P/L';
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Realized P/L",
                                                    style: NavTextController
                                                        .ControllerText,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ColorSelect
                                                      .tabBorderColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReportsDownload(
                                                      type: 'Order History',
                                                    ),
                                                  ),
                                                );
                                                ReportsSearch.type.value =
                                                    'Order History';
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Order History",
                                                    style: NavTextController
                                                        .ControllerText,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ColorSelect
                                                      .tabBorderColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReportsDownload(
                                                      type: 'Transfer Inquiry',
                                                    ),
                                                  ),
                                                );
                                                ReportsSearch.type.value =
                                                    'Transfer Inquiry';
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Transfer Inquiry",
                                                    style: NavTextController
                                                        .ControllerText,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ColorSelect
                                                      .tabBorderColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReportsDownload(
                                                      type: 'Cash Statement',
                                                    ),
                                                  ),
                                                );
                                                ReportsSearch.type.value =
                                                    'Cash Statement';
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Cash Statement",
                                                    style: NavTextController
                                                        .ControllerText,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: ColorSelect.tabBorderColor,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          child: TextButton(
                                            onPressed: () {
                                              setState(
                                                () {
                                                  isComplilistHovered =
                                                      !isComplilistHovered;
                                                },
                                              );
                                            },
                                            child: Icon(
                                              (isComplilistHovered)
                                                  ? Icons.expand_more
                                                  : Icons
                                                      .arrow_forward_ios_rounded,
                                              color: ColorSelect.tabTextColor,
                                              size: 14,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Navigator.of(context).push(
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         newInd("Insert"),
                                            //   ),
                                            // );
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Text(
                                              S.of(context).Compliance,
                                              style: NavTextController
                                                  .ControllerText,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (isComplilistHovered)
                                      Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ColorSelect
                                                      .tabBorderColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 30,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(
                                                            () {
                                                              isDPMReportHoverd =
                                                                  !isDPMReportHoverd;
                                                            },
                                                          );
                                                        },
                                                        child: Icon(
                                                          (isDPMReportHoverd)
                                                              ? Icons
                                                                  .expand_more
                                                              : Icons
                                                                  .arrow_forward_ios_rounded,
                                                          color: ColorSelect
                                                              .tabTextColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        // Navigator.of(context).push(
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         newInd("Insert"),
                                                        //   ),
                                                        // );
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          "DPM Report",
                                                          style: NavTextController
                                                              .ControllerText,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                if (isDPMReportHoverd)
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type: 'DPM',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //     .value = 'DPM';
                                                            _launchUrl(
                                                                "DPMReport");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Contents and Value of Portfolio ",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: ColorSelect
                                                                  .tabBorderColor,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type:
                                                            //           'Client',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //         .value =
                                                            //     'Client';
                                                            _launchUrl(
                                                                "BasisOfValuation");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Basis of Valuation",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: ColorSelect
                                                                  .tabBorderColor,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type:
                                                            //           'Client',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //         .value =
                                                            //     'Client';
                                                            _launchUrl(
                                                                "PortfolioTransactionsReport");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Transactions and Changes in Portfolio",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: ColorSelect
                                                                  .tabBorderColor,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type:
                                                            //           'Client',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //         .value =
                                                            //     'Client';
                                                            _launchUrl(
                                                                "ChargesandRemuneration");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Charges and Remuneration ",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: ColorSelect
                                                                  .tabBorderColor,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type:
                                                            //           'Client',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //         .value =
                                                            //     'Client';
                                                            _launchUrl(
                                                                "Securities Pledged or Charged");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Securities Pledged or Charged",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: ColorSelect
                                                                  .tabBorderColor,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type:
                                                            //           'Client',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //         .value =
                                                            //     'Client';
                                                            _launchUrl(
                                                                "DerivativesReport");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Derivatives Positions",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: ColorSelect
                                                                  .tabBorderColor,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type:
                                                            //           'Client',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //         .value =
                                                            //     'Client';
                                                            _launchUrl(
                                                                "PeriodicReport");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Periodic Reporting",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ColorSelect
                                                      .tabBorderColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 30,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(
                                                            () {
                                                              isClientReportHoverd =
                                                                  !isClientReportHoverd;
                                                            },
                                                          );
                                                        },
                                                        child: Icon(
                                                          (isClientReportHoverd)
                                                              ? Icons
                                                                  .expand_more
                                                              : Icons
                                                                  .arrow_forward_ios_rounded,
                                                          color: ColorSelect
                                                              .tabTextColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        // Navigator.of(context).push(
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         newInd("Insert"),
                                                        //   ),
                                                        // );
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          "Client Report",
                                                          style: NavTextController
                                                              .ControllerText,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                if (isClientReportHoverd)
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type: 'DPM',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //     .value = 'DPM';
                                                            _launchUrl(
                                                                "ClientDetailsReport");
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsView(),
                                                            //   ),
                                                            // );
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Client Details",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: ColorSelect
                                                                  .tabBorderColor,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type: 'DPM',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //     .value = 'DPM';
                                                            _launchUrl(
                                                                "ClientStatementReport");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Client Statement",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            ),
                                          ),

                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: ColorSelect
                                                      .tabBorderColor,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 30,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(
                                                            () {
                                                              isFundReportHovered =
                                                                  !isFundReportHovered;
                                                            },
                                                          );
                                                        },
                                                        child: Icon(
                                                          (isFundReportHovered)
                                                              ? Icons
                                                                  .expand_more
                                                              : Icons
                                                                  .arrow_forward_ios_rounded,
                                                          color: ColorSelect
                                                              .tabTextColor,
                                                          size: 14,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        // Navigator.of(context).push(
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) =>
                                                        //         newInd("Insert"),
                                                        //   ),
                                                        // );
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Text(
                                                          "Fund Report",
                                                          style: NavTextController
                                                              .ControllerText,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                if (isFundReportHovered)
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type: 'DPM',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //     .value = 'DPM';
                                                            _launchUrl(
                                                                "InvestmentFundAnnualReport");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Fund Annual",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                              color: ColorSelect
                                                                  .tabBorderColor,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        child: TextButton(
                                                          onPressed: () {
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //   MaterialPageRoute(
                                                            //     builder:
                                                            //         (context) =>
                                                            //             ReportsDownload(
                                                            //       type: 'DPM',
                                                            //     ),
                                                            //   ),
                                                            // );
                                                            // ReportsSearch.type
                                                            //     .value = 'DPM';
                                                            _launchUrl(
                                                                "PublicFundQuarterlyReport");
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                "Fund Quarterly",
                                                                style: NavTextController
                                                                    .ControllerText,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ],
                                            ),
                                          ),

                                          // Container(
                                          //   width: double.infinity,
                                          //   child: TextButton(
                                          //     onPressed: () {
                                          //       Navigator.of(context).push(
                                          //         MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               ReportsDownload(
                                          //             type: 'DPM',
                                          //           ),
                                          //         ),
                                          //       );
                                          //       ReportsSearch.type.value =
                                          //           'DPM';
                                          //     },
                                          //     child: Container(
                                          //       padding: EdgeInsets.symmetric(
                                          //           vertical: 5),
                                          //       child: Align(
                                          //         alignment:
                                          //             Alignment.centerRight,
                                          //         child: Text(
                                          //           "DPM Report",
                                          //           style: NavTextController
                                          //               .ControllerText,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: double.infinity,
                                          //   decoration: BoxDecoration(
                                          //     border: Border(
                                          //       bottom: BorderSide(
                                          //         color: ColorSelect
                                          //             .tabBorderColor,
                                          //         width: 1.0,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: double.infinity,
                                          //   child: TextButton(
                                          //     onPressed: () {
                                          //       Navigator.of(context).push(
                                          //         MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               ReportsDownload(
                                          //             type: 'Client',
                                          //           ),
                                          //         ),
                                          //       );
                                          //       ReportsSearch.type.value =
                                          //           'Client';
                                          //     },
                                          //     child: Container(
                                          //       padding: EdgeInsets.symmetric(
                                          //           vertical: 5),
                                          //       child: Align(
                                          //         alignment:
                                          //             Alignment.centerRight,
                                          //         child: Text(
                                          //           "Client Record",
                                          //           style: NavTextController
                                          //               .ControllerText,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),

                                          // Container(
                                          //   width: double.infinity,
                                          //   decoration: BoxDecoration(
                                          //     border: Border(
                                          //       bottom: BorderSide(
                                          //         color: ColorSelect
                                          //             .tabBorderColor,
                                          //         width: 1.0,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: double.infinity,
                                          //   child: TextButton(
                                          //     onPressed: () {
                                          //       Navigator.of(context).push(
                                          //         MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               ReportsDownload(
                                          //             type: 'Fund',
                                          //           ),
                                          //         ),
                                          //       );
                                          //       ReportsSearch.type.value =
                                          //           'Fund';
                                          //     },
                                          //     child: Container(
                                          //       padding: EdgeInsets.symmetric(
                                          //           vertical: 5),
                                          //       child: Align(
                                          //         alignment:
                                          //             Alignment.centerRight,
                                          //         child: Text(
                                          //           "Fund Report",
                                          //           style: NavTextController
                                          //               .ControllerText,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: double.infinity,
                                          //   decoration: BoxDecoration(
                                          //     border: Border(
                                          //       bottom: BorderSide(
                                          //         color: ColorSelect
                                          //             .tabBorderColor,
                                          //         width: 1.0,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: double.infinity,
                                          //   child: TextButton(
                                          //     onPressed: () {
                                          //       Navigator.of(context).push(
                                          //         MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               ReportsDownload(
                                          //             type: 'Fund Annual',
                                          //           ),
                                          //         ),
                                          //       );
                                          //       ReportsSearch.type.value =
                                          //           'Fund Annual';
                                          //     },
                                          //     child: Container(
                                          //       padding: EdgeInsets.symmetric(
                                          //           vertical: 5),
                                          //       child: Align(
                                          //         alignment:
                                          //             Alignment.centerRight,
                                          //         child: Text(
                                          //           "Fund Annual Report",
                                          //           style: NavTextController
                                          //               .ControllerText,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   width: double.infinity,
                                          //   decoration: BoxDecoration(
                                          //     border: Border(
                                          //       bottom: BorderSide(
                                          //         color: ColorSelect
                                          //             .tabBorderColor,
                                          //         width: 1.0,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),

                                          // ===================================== //

                                          // Container(
                                          //   width: double.infinity,
                                          //   child: TextButton(
                                          //     onPressed: () {
                                          //       Navigator.of(context).push(
                                          //         MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               ReportsDownload(
                                          //             type: 'Cash Statement',
                                          //           ),
                                          //         ),
                                          //       );
                                          //       ReportsSearch.type.value =
                                          //           'Cash Statement';
                                          //     },
                                          //     child: Container(
                                          //       padding: EdgeInsets.symmetric(
                                          //           vertical: 5),
                                          //       child: Align(
                                          //         alignment:
                                          //             Alignment.centerRight,
                                          //         child: Text(
                                          //           textAlign: TextAlign.end,
                                          //           "Fund Quartaly Report",
                                          //           style: NavTextController
                                          //               .ControllerText,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: isReportHovered
                              ? ColorSelect.east_dark_blue
                              : ColorSelect.east_blue,
                          border: Border(
                            left: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 0.5,
                            ),
                            right: BorderSide(
                              color: ColorSelect.east_grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.edit_document,
                                size: 20,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  S.of(context).Reports,
                                  style: TextController.ControllerText,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Arranging
                // MouseRegion(
                //   onEnter: (isHovered) {
                //     setState(() {
                //       isArrangingHovered = true;
                //     });
                //   },
                //   onExit: (isHovered) {
                //     setState(() {
                //       isArrangingHovered = false;
                //     });
                //   },
                //   child: Stack(
                //     children: [
                //       if (isArrangingHovered)
                //         Container(
                //           width: 150,
                //           margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             boxShadow: [
                //               BoxShadow(
                //                 blurRadius: 3,
                //                 color: Color.fromRGBO(0, 0, 0, 0.363),
                //               ),
                //             ],
                //           ),
                //           child: Column(
                //             children: [
                //               // Container(
                //               //   width: double.infinity,
                //               //   decoration: BoxDecoration(
                //               //     border: Border(
                //               //       bottom: BorderSide(
                //               //         color: ColorSelect.tabBorderColor,
                //               //         width: 1.0,
                //               //       ),
                //               //     ),
                //               //   ),
                //               //   child: TextButton(
                //               //     onPressed: () {
                //               //       Navigator.of(context).push(
                //               //         MaterialPageRoute(
                //               //           builder: (context) => TabOffArranging(),
                //               //         ),
                //               //       );
                //               //     },
                //               //     child: Container(
                //               //       padding: EdgeInsets.symmetric(vertical: 15),
                //               //       child: Text(
                //               //         S.of(context).Creation,
                //               //         style: NavTextController.ControllerText,
                //               //       ),
                //               //     ),
                //               //   ),
                //               // ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             tabOfSubServiceCreactionArranging(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       textAlign: TextAlign.center,
                //                       S.of(context).ArrangingServiceCreation,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                           builder: (context) =>
                //                               TabOfArrangingss()),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).AgreementAddUpdateDelete,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             ArrangingAgreementLink(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       textAlign: TextAlign.center,
                //                       S.of(context).LinkAgreementwithCustomer,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               // Container(
                //               //   width: double.infinity,
                //               //   decoration: BoxDecoration(
                //               //     border: Border(
                //               //       bottom: BorderSide(
                //               //         color: ColorSelect.tabBorderColor,
                //               //         width: 1.0,
                //               //       ),
                //               //     ),
                //               //   ),
                //               //   child: TextButton(
                //               //     onPressed: () {
                //               //       Navigator.of(context).push(
                //               //         MaterialPageRoute(
                //               //           builder: (context) =>
                //               //               ArrangingApprovalRequest(),
                //               //         ),
                //               //       );
                //               //     },
                //               //     child: Container(
                //               //       padding: EdgeInsets.symmetric(vertical: 15),
                //               //       child: Text(
                //               //         S.of(context).ApprovalScreen,
                //               //         style: NavTextController.ControllerText,
                //               //       ),
                //               //     ),
                //               //   ),
                //               // ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             AssignArrangingManagerNDPM(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       textAlign: TextAlign.center,
                //                       S.of(context).AssignArrangingManager,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             MileStoneScreenArranging(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).ExpenseTracker,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             ArrangingSubscribes(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).ServiceInitiation,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(
                //                   border: Border(
                //                     bottom: BorderSide(
                //                       color: ColorSelect.tabBorderColor,
                //                       width: 1.0,
                //                     ),
                //                   ),
                //                 ),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             ArrangingRedeems(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).ActivityUpdate,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               ),

                //               Container(
                //                 width: double.infinity,
                //                 decoration: BoxDecoration(),
                //                 child: TextButton(
                //                   onPressed: () {
                //                     Navigator.of(context).push(
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             ArrangingAgreementPdfDownloadUpload(),
                //                       ),
                //                     );
                //                   },
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(vertical: 15),
                //                     child: Text(
                //                       S.of(context).AgreementUpload,
                //                       style: NavTextController.ControllerText,
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       Container(
                //         height: 40,
                //         width: 150,
                //         decoration: BoxDecoration(
                //           color: isArrangingHovered
                //               ? ColorSelect.east_dark_blue
                //               : ColorSelect.east_blue,
                //           border: Border(
                //             left: BorderSide(
                //               color: ColorSelect.east_grey,
                //               width: 0.5,
                //             ),
                //             right: BorderSide(
                //               color: ColorSelect.east_grey,
                //               width: 0.5,
                //             ),
                //           ),
                //         ),
                //         child: TextButton(
                //           onPressed: () {},
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Icon(
                //                 Icons.transfer_within_a_station_outlined,
                //                 size: 20,
                //                 color: Colors.white,
                //               ),
                //               Container(
                //                 margin: EdgeInsets.symmetric(horizontal: 5),
                //                 child: Text(
                //                   S.of(context).Arranging,
                //                   style: TextController.ControllerText,
                //                 ),
                //               ),
                //               Icon(
                //                 Icons.arrow_drop_down,
                //                 size: 20,
                //                 color: Colors.white,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
