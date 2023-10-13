import 'dart:convert';

import 'package:east_bridge/CustomerSearchRiskCorporate.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Controller extends GetxController {
  // Rx<TextEditingController> _firstName = TextEditingController().obs;
  var count = 0;
  void increment() {
    count++;
    update();
  }
}

class RiskCorporateApproval extends StatefulWidget {
  RiskCorporateApproval({@required id}) {
    ClientId = id;
  }
  @override
  State<RiskCorporateApproval> createState() => _RiskFormCorporateState();
  static ValueNotifier<int> clientID = ValueNotifier(0);
  static ValueNotifier<String> clientName = ValueNotifier("");
  static ValueNotifier<bool> send = ValueNotifier(true);
  static ValueNotifier<String> enter = ValueNotifier("");
  static ValueNotifier<String> nationality = ValueNotifier("");
  static ValueNotifier<String> residency = ValueNotifier("");
  static ValueNotifier<String> client = ValueNotifier("");
  static ValueNotifier<String> account = ValueNotifier("");
  static ValueNotifier<String> investing = ValueNotifier("");
  static ValueNotifier<String> work = ValueNotifier("");
  static ValueNotifier<String> clientClassification = ValueNotifier("");
  static ValueNotifier<String> investmentExp = ValueNotifier("");
  static ValueNotifier<String> riskAbility = ValueNotifier("");
  static ValueNotifier<String> investmentObj = ValueNotifier("");
  static ValueNotifier<String> source = ValueNotifier("");
  static ValueNotifier<String> annualIncome = ValueNotifier("");
  static ValueNotifier<String> netWorth = ValueNotifier("");
  static ValueNotifier<String> boardDirector = ValueNotifier("");
  static ValueNotifier<String> pep = ValueNotifier("");
  static ValueNotifier<String> owner = ValueNotifier("");
}

String first = "";
int? ClientId;

class _RiskFormCorporateState extends State<RiskCorporateApproval> {
  Rx<TextEditingController> _firstName = TextEditingController().obs;
  final RiskCorporateApproval textControllers = Get.put(RiskCorporateApproval(
    id: ClientId,
  ));

  List<TextEditingController> controllers = [];

  // controller=pi.randomFun();
  double yOffset = 0;
  double xOffset = 0;
  bool sidBarOpen = false;
  bool _sidebarVisible = false;
  late Map<String, dynamic> permission = {};

  void a() async {
    var data = await GlobalPermission.formPermission("Risk Assessment");
    setState(() {
      permission = data;
    });
  }

  bool get sidebarVisible => _sidebarVisible;

  void toggleSidebar() {
    _sidebarVisible = !_sidebarVisible;
  }

  void setSideBarState() {
    setState(() {
      xOffset = sidBarOpen ? 250 : 0;
    });
  }

  test(double i) {
    Future.delayed(Duration.zero, () {
      // Update the state after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          count += i;
        });
      });
    });
  }

  double total = 0;
  calulate() {
    print(RiskCorporateApproval.investmentObj.value);
    double x = 0;
    List<String> countryList1 = [
      'Korea',
      'Iran',
      'Myanmar',
      'Albania',
      'Barbados',
      'Burkina Faso',
      'Haiti',
      'South Sudan',
      'Mozambique',
      'Jamaica',
      'Gibraltar',
      'Jordan',
      'Mali',
      'Nigeria',
      'Panama',
      'Philippines',
      'Senegal',
      'South Africa',
      'Syria',
      'Tanzania',
      'United Arab Emirates (UAE)',
      'Uganda',
      'Yemen',
      'Democratic Republic of the Congo',
      'Cayman Islands',
      'China',
      'Russia',
    ];
    List<String> countryList2 = [
      'Egypt',
      'Ukraine',
      'Algeria',
      'Tunisia',
      'Pakistan',
      'Uzbekistan',
      'Thailand',
      'Indonesia',
      'Morocco',
    ];
    List<String> recidence1 = [
      'Korea',
      'Iran',
      'Myanmar',
      'Albania',
      'Barbados',
      'Burkina Faso',
      'Haiti',
      'South Sudan',
      'Mozambique',
      'Jamaica',
      'Gibraltar',
      'Jordan',
      'Mali',
      'Nigeria',
      'Panama',
      'Philippines',
      'Senegal',
      'South Africa',
      'Syria',
      'Tanzania',
      'United Arab Emirates (UAE)',
      'Uganda',
      'Yemen',
      'Democratic Republic of the Congo',
      'Cayman Islands',
      'China',
      'Russia',
    ];

    List<String> recidence2 = [
      'Egypt',
      'Ukraine',
      'Algeria',
      'Tunisia',
      'Pakistan',
      'Uzbekistan',
      'Thailand',
      'Indonesia',
      'Morocco',
    ];
    List<String> workList1 = [
      'Senior Political',
      'Ruling Family',
      'Judicial',
      'Military',
      'Minister',
      'Self Employed',
    ];
    List<String> workList2 = [
      'Lawyer',
    ];
    List<String> workList3 = [
      'Student',
      'Retired',
      'Employee',
    ];
    List<String> ct1 = ['Natural Person'];
    List<String> ct2 = ['Authorized Person'];
    List<String> at1 = ['Employee'];
    List<String> at2 = ['Minor'];
    List<String> at3 = ['Political'];
    List<String> clientClassification1 = ['Retail', 'Qualified'];
    List<String> clientClassification2 = ['Institutional'];
    List<String> Sources1 = [
      'Salary',
      'Real Estate',
      'Pension',
    ];
    List<String> sourceList2 = [
      'Personal Business',
      'Investment',
      'Inheritance',
      'Marketable Securities',
    ];
    List<String> invE = ['Low', 'Medium'];
    List<String> invE2 = ['High'];
    List<String> riskAbility = ['Low', 'Medium'];
    List<String> riskAbility2 = ['High'];
    List<String> annualInc1 = ['More Than 50,000,000'];
    List<String> netWorth1 = ['More Than 50,000,000'];
    List<String> invest1 = ['Less Than 5 Million'];
    List<String> invest2 = ['More Than 5 Million'];
    List<String> ans = ['Yes'];
    List<String> ans2 = ['No'];
    List<String> invobj = ['Protection Of Capital', 'Income', 'Balanced'];
    List<String> invobj2 = ['Growth Of Capital'];
    if (countryList1.contains(controllers[0].text)) {
      x += 7.5;
      print(controllers[0].text);
      print(7.5);
    } else if (countryList2.contains(controllers[0].text)) {
      x += 5;
      print(controllers[0].text);
      print(5);
    } else {
      x += 2.5;
      print(controllers[0].text);
      print(2.5);
    }
    if (recidence1.contains(controllers[1].text)) {
      x += 15;
      print(controllers[1].text);
      print(15);
    } else if (recidence2.contains(controllers[1].text)) {
      x += 7.5;
      print(controllers[1].text);
      print(7.5);
    } else {
      x += 5;
      print(controllers[1].text);
      print(5);
    }

    if (workList1.contains(controllers[2].text)) {
      x += 15;
      print(controllers[2].text);
      print(15);
    } else if (workList2.contains(controllers[2].text)) {
      x += 7.5;
      print(controllers[2].text);
      print(7.5);
    } else if (workList3.contains(controllers[2].text)) {
      x += 5;
      print(controllers[2].text);
      print(5);
    }
    if (clientClassification1.contains(controllers[4].text)) {
      x += 2.5;
      print(controllers[4].text);
      print(2.5);
    } else if (clientClassification2.contains(controllers[4].text)) {
      x += 5;
      print(controllers[4].text);
      print(5);
    }

    if (ct1.contains(controllers[9].text)) {
      x += 2.5;
      print(controllers[9].text);
      print(2.5);
    } else if (ct2.contains(controllers[9].text)) {
      x += 5;
      print(controllers[9].text);
      print(5);
    }
    if (at1.contains(controllers[3].text)) {
      x += 5;
      print(controllers[3].text);
      print(5);
    } else if (at2.contains(controllers[3].text)) {
      x += 7.5;
      print(controllers[3].text);
      print(7.5);
    } else if (at3.contains(controllers[3].text)) {
      x += 15;
      print(controllers[3].text);
      print(15);
    }
    if (Sources1.contains(controllers[5].text)) {
      x += 2.5;
      print(controllers[5].text);
      print(2.5);
    } else if (sourceList2.contains(controllers[5].text)) {
      x += 5;
      print(controllers[5].text);
      print(5);
    }
    if (invE.contains(controllers[6].text)) {
      x += 5;
      print(controllers[6].text);
      print(5);
    } else if (invE2.contains(controllers[6].text)) {
      x += 2.5;
      print(controllers[6].text);
      print(2.5);
    }
    if (riskAbility.contains(controllers[7].text)) {
      x += 5;
      print(controllers[7].text);
      print(5);
    } else if (riskAbility2.contains(controllers[7].text)) {
      x += 2.5;
      print(controllers[7].text);
      print(2.5);
    }

    for (int i = 0; i < controllers[8].text.length; i++) {
      print("LOOPPPPP");

      if (controllers[8].text[i] == "1") {
        setState(() {
          if (i == 0) {
            controllers[8].text = "Protection Of Capital";
          } else if (i == 1) {
            controllers[8].text = "Income";
          } else if (i == 2) {
            controllers[8].text = "Balanced";
          } else if (i == 3) {
            controllers[8].text = "Growth Of Capital";
          }
        });
        break; // Break out of the loop once a match is found
      } else {
        setState(() {
          controllers[8].text = "";
        });
      }
      print("Controllerrrr");
      String y = controllers[8].text;
      print(y);
    }
    if (invobj.contains(controllers[8].text)) {
      x += 2.5;
      print(controllers[8].text);
      print(2.5);
    } else if (invobj2.contains(controllers[8].text)) {
      x += 5;
      print(controllers[8].text);
      print(5);
    }
    if (annualInc1.contains(controllers[11].text)) {
      x += 2.5;
      print(controllers[11].text);
      print(2.5);
    } else {
      x += 5;
      print(controllers[11].text);
      print(5);
    }
    if (netWorth1.contains(controllers[12].text)) {
      x += 2.5;
      print(controllers[12].text);
      print(2.5);
    } else {
      x += 5;
      print(controllers[12].text);
      print(5);
    }
    if (invest1.contains(controllers[13].text)) {
      x += 2.5;
      print(controllers[13].text);
      print(2.5);
    } else if (invest2.contains(controllers[13].text)) {
      x += 5;
      print(controllers[13].text);
      print(5);
    }
    if (ans.contains(controllers[10].text)) {
      x += 5;
      print(controllers[13].text);
      print(5);
    } else if (ans2.contains(controllers[10].text)) {
      x += 2.5;
      print(controllers[10].text);
      print(2.5);
    }
    if (ans.contains(controllers[14].text)) {
      x += 2.5;
      print(controllers[14].text);
      print(2.5);
    } else if (ans2.contains(controllers[14].text)) {
      x += 5;
      print(controllers[14].text);
      print(5);
    }
    if (ans.contains(controllers[15].text)) {
      x += 2.5;
      print(controllers[15].text);
      print(2.5);
    } else if (ans2.contains(controllers[15].text)) {
      x += 5;
      print(controllers[15].text);
      print(5);
    }

    setState(() {
      total = x;
    });
  }

  double count = 0;
  double i = 0;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   test(i);
    // });
    //calulate();
    //   test(i);

    // });
    // calulate();
    print("RiskFormmmmmmm");

    // if (RiskCorporateApproval.clientID.value == 0) {
    setState(() {
      for (int j = 0; j < 16; j++) {
        // list.add("");
        TextEditingController z = new TextEditingController();
        z.text = "";
        controllers.add(z);
      }
    });
    // } else {
    //   get();
    // }
    // a();
    getdata(ClientId!);
  }

  late String dropdownvalue;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  List<String?> list = List<String?>.filled(16, null);

  void get(int id) async {
    print("clientid-------------");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/RiskAssessmentCorporate/${id}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("----------done");
        var responseData = jsonDecode(response.body);
        print(responseData);
        setState(() {
          int k = 0;
          for (String i in responseData) {
            list[k] = i;
            k++;
          }
          controllers.clear();

          for (int x = 0; x < 16; x++) {
            TextEditingController y = new TextEditingController();
            y.text = list[x]!;
            controllers.add(y);
          }
        });

        print(list);
        calulate();
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void register() async {
    print('${GlobalPermission.urlLink}/api/RiskAnaysisOfClient_s/InserRisk');
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/RiskAnaysisOfClient_s/InserRisk');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": ClientId,
        "nationality": controllers[0].text,
        "residency": controllers[1].text,
        "work": controllers[2].text,
        "accountType": controllers[3].text,
        "clientClassification": controllers[4].text,
        "soucrseOfWealth": controllers[5].text,
        "investmentKandE": controllers[6].text,
        "cosumersAbitlityToBreakRisk": controllers[7].text,
        "clientInvestmentObjectives": controllers[8].text,
        "clienttype": controllers[9].text,
        "isTheClientABoardMemberOrACommitteeMemberInAListedCompany":
            controllers[10].text,
        "investingWithEastBridgeCompany": controllers[11].text,
        "approximateNetWorthExcludingResidenceInSAR": controllers[12].text,
        "approximateAnnualIncomeInSAR": controllers[13].text,
        "isTheCustomerTheBeneficialOwnerOfTheAccount": controllers[14].text,
        "isThereAPowerOfAttorneyOnTheAccount": controllers[15].text,
        "total": total
      };

      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(response.body);
        Fluttertoast.showToast(
          msg: "Risk Saved Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  S.of(context).Status,
                  style: TextController.SubHeadingText,
                ),
                content: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).SomethingWentWrong + "!",
                        style: TextController.BodyText,
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void putData(int id) async {
    print(
        '${GlobalPermission.urlLink}/api/RiskAnaysisOfClient_s/UpdateRisk?id=2');
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/RiskAnaysisOfClient_s/UpdateRisk?id=${id}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": id,
        "nationality": controllers[0].text,
        "residency": controllers[1].text,
        "work": controllers[2].text,
        "accountType": controllers[3].text,
        "clientClassification": controllers[4].text,
        "soucrseOfWealth": controllers[5].text,
        "investmentKandE": controllers[6].text,
        "cosumersAbitlityToBreakRisk": controllers[7].text,
        "clientInvestmentObjectives": controllers[8].text,
        "clienttype": controllers[9].text,
        "isTheClientABoardMemberOrACommitteeMemberInAListedCompany":
            controllers[10].text,
        "investingWithEastBridgeCompany": controllers[11].text,
        "approximateNetWorthExcludingResidenceInSAR": controllers[12].text,
        "approximateAnnualIncomeInSAR": controllers[13].text,
        "isTheCustomerTheBeneficialOwnerOfTheAccount": controllers[14].text,
        "isThereAPowerOfAttorneyOnTheAccount": controllers[15].text,
        "total": total
      };

      print(body);
      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

     
        if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Risk Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print(response.body);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  S.of(context).Status,
                  style: TextController.SubHeadingText,
                ),
                content: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).SomethingWentWrong + "!",
                        style: TextController.BodyText,
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/RiskAnaysisOfClient_s/GetRisk?id=${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      controllers[0].text = data["nationality"];
      controllers[1].text = data["residency"];
      controllers[2].text = data["work"];
      controllers[3].text = data["accountType"];
      controllers[4].text = data["clientClassification"];
      controllers[5].text = data["soucrseOfWealth"];
      controllers[6].text = data["investmentKandE"];
      controllers[7].text = data["cosumersAbitlityToBreakRisk"];
      controllers[8].text = data["clientInvestmentObjectives"];
      controllers[9].text = data["clienttype"];
      controllers[10].text =
          data["isTheClientABoardMemberOrACommitteeMemberInAListedCompany"];
      controllers[11].text = data["investingWithEastBridgeCompany"];
      controllers[12].text = data["approximateNetWorthExcludingResidenceInSAR"];
      // citizenshipId.text = data["citizenship"];

      controllers[13].text = data["approximateAnnualIncomeInSAR"];
      controllers[14].text =
          data["isTheCustomerTheBeneficialOwnerOfTheAccount"];
      controllers[15].text = data["isThereAPowerOfAttorneyOnTheAccount"];

      setState(() {
        total = data["total"];
      });
      setState(() {});
      print("IDDDDDDDDD");
      print(data["idType"]);

      print("DOBBBBBBBBBBBBBBB");
      print(data["dob"]);
    } else {
      get(ClientId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Stack(
            children: [
              Container(
                // margin: EdgeInsets.only(top: 40),
                color: Colors.white,
                child: Column(
                  children: [
                    // Header(),

                    // HEADER START
                    // Column(
                    //   children: [
                    //     HeaderTop(),
                    //     Container(
                    //       margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                    //       width: double.infinity,
                    //       height: 40,
                    //       color: ColorSelect.east_blue,
                    //       child: Row(
                    //         children: [
                    //           Container(
                    //             width: 100,
                    //             height: 40,
                    //             child: Container(
                    //               height: 40,
                    //               child: Center(
                    //                 child: IconButton(
                    //                   color: Colors.white,
                    //                   icon: Icon(Icons.menu),
                    //                   onPressed: () {
                    //                     sidBarOpen = !sidBarOpen;
                    //                     setSideBarState();
                    //                     toggleSidebar();
                    //                   },
                    //                   // onPressed: () {

                    //                   // _globalKey.currentState?.openDrawer();
                    //                   // },
                    //                 ),
                    //               ),
                    //             ),
                    //           ),

                    //           if (permission['New'] == true)
                    //             Container(
                    //               // width: 100,
                    //               height: 44,
                    //               padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(color: Colors.white),
                    //               ),
                    //               child: TextButton(
                    //                 onPressed: () {
                    //                   Navigator.of(context)
                    //                       .push(MaterialPageRoute(
                    //                     builder: (context) =>
                    //                         RiskCorporateApproval(),
                    //                   ));
                    //                 },
                    //                 child: Container(
                    //                   //color: ColorSelect.east_blue,
                    //                   child: Row(
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(5.0),
                    //                         child: Icon(
                    //                           Icons.add_card_rounded,
                    //                           size: 15,
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10,
                    //                       ),
                    //                       Center(
                    //                         child: Text(
                    //                           S.of(context).New,
                    //                           style:
                    //                               TextController.ControllerText,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           // EDIT
                    //           if (permission['Edit'] == true)
                    //             Container(
                    //               // width: 100,
                    //               height: 44,
                    //               padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(color: Colors.white),
                    //               ),
                    //               child: TextButton(
                    //                 onPressed: () {},
                    //                 child: Container(
                    //                   //color: ColorSelect.east_blue,
                    //                   child: Row(
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(5.0),
                    //                         child: Icon(
                    //                           Icons.edit_calendar_outlined,
                    //                           size: 15,
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10,
                    //                       ),
                    //                       Center(
                    //                         child: Text(
                    //                           S.of(context).Edit,
                    //                           style:
                    //                               TextController.ControllerText,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           // view
                    //           if (permission['View'] == true)
                    //             Container(
                    //               // width: 100,
                    //               height: 44,
                    //               padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(color: Colors.white),
                    //               ),
                    //               child: TextButton(
                    //                 onPressed: () {},
                    //                 child: Container(
                    //                   //color: ColorSelect.east_blue,
                    //                   child: Row(
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(5.0),
                    //                         child: Icon(
                    //                           Icons.content_paste_search,
                    //                           size: 15,
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10,
                    //                       ),
                    //                       Center(
                    //                         child: Text(
                    //                           S.of(context).View,
                    //                           style:
                    //                               TextController.ControllerText,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           // cancel
                    //           if (permission['Delete'] == true)
                    //             Container(
                    //               // width: 100,
                    //               height: 44,
                    //               padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(color: Colors.white),
                    //               ),
                    //               child: TextButton(
                    //                 onPressed: () {},
                    //                 child: Container(
                    //                   //color: ColorSelect.east_blue,
                    //                   child: Row(
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(5.0),
                    //                         child: Icon(
                    //                           Icons.free_cancellation_outlined,
                    //                           size: 15,
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10,
                    //                       ),
                    //                       Center(
                    //                         child: Text(
                    //                           S.of(context).Cancel,
                    //                           style:
                    //                               TextController.ControllerText,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           // print
                    //           if (permission['Print'] == true)
                    //             Container(
                    //               // width: 100,
                    //               height: 44,
                    //               padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(color: Colors.white),
                    //               ),
                    //               child: TextButton(
                    //                 onPressed: () {
                    //                   // Navigator.of(context)
                    //                   //     .push(MaterialPageRoute(
                    //                   //   builder: (context) => KYCPdfUploadIND(),
                    //                   // ));
                    //                 },
                    //                 child: Container(
                    //                   //color: ColorSelect.east_blue,
                    //                   child: Row(
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(5.0),
                    //                         child: Icon(
                    //                           Icons.print,
                    //                           size: 15,
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10,
                    //                       ),
                    //                       Center(
                    //                         child: Text(
                    //                           S.of(context).Print,
                    //                           style:
                    //                               TextController.ControllerText,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           //
                    //           if (permission['Download'] == true)
                    //             Container(
                    //               // width: 100,
                    //               height: 44,
                    //               padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(color: Colors.white),
                    //               ),
                    //               child: TextButton(
                    //                 onPressed: () {},
                    //                 child: Container(
                    //                   //color: ColorSelect.east_blue,
                    //                   child: Row(
                    //                     children: [
                    //                       Padding(
                    //                         padding: const EdgeInsets.all(5.0),
                    //                         child: Icon(
                    //                           Icons.download,
                    //                           size: 15,
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         width: 10,
                    //                       ),
                    //                       Center(
                    //                         child: Text(
                    //                           S.of(context).Download,
                    //                           style:
                    //                               TextController.ControllerText,
                    //                         ),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           // saveDraft
                    //           Container(
                    //             // width: 100,
                    //             height: 44,
                    //             padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    //             decoration: BoxDecoration(
                    //               border: Border.all(color: Colors.white),
                    //             ),
                    //             child: TextButton(
                    //               onPressed: () {},
                    //               child: Container(
                    //                 //color: ColorSelect.east_blue,
                    //                 child: Row(
                    //                   children: [
                    //                     Padding(
                    //                       padding: const EdgeInsets.all(5.0),
                    //                       child: Icon(
                    //                         Icons.save_as_outlined,
                    //                         size: 15,
                    //                         color: Colors.white,
                    //                       ),
                    //                     ),
                    //                     SizedBox(
                    //                       width: 10,
                    //                     ),
                    //                     Center(
                    //                       child: Text(
                    //                         S.of(context).SaveDraft,
                    //                         style:
                    //                             TextController.ControllerText,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // HEADER END

                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                S.of(context).RiskAssessmentForm,
                                style: TextController.MainHeadingText,
                              )),
                              // Text(textControllers._firstName.value.text)
                            ],
                          ),

                          Column(
                            children: [
                              // Align(
                              //   alignment: Alignment.topLeft,
                              //   child: Text(
                              //     "Client Name : " +
                              //         RiskCorporateApproval.clientName.value,
                              //     style: TextController.BodyHeadingText,
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              Container(
                                child: Container(
                                  width: 900,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 50),
                                  child: Table(
                                    border: TableBorder.all(
                                        color: ColorSelect.tabBorderColor),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: {
                                      0: FlexColumnWidth(1.2),
                                      1: FlexColumnWidth(1),
                                      2: FlexColumnWidth(1),
                                      3: FlexColumnWidth(1),
                                    },
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 50,
                                          color: ColorSelect.east_grey,
                                          child: Center(
                                            child: Text(
                                              S.of(context).Attribute,
                                              style:
                                                  TextController.tableHeading,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: 50,
                                            color: ColorSelect.east_grey,
                                            child: Center(
                                                child: Text(
                                              S.of(context).Value,
                                              style:
                                                  TextController.tableHeading,
                                            ))),
                                        Container(
                                            height: 50,
                                            color: ColorSelect.east_grey,
                                            child: Center(
                                                child: Text(
                                              S.of(context).Weightage,
                                              style:
                                                  TextController.tableHeading,
                                            ))),
                                        Container(
                                            height: 50,
                                            color: ColorSelect.east_grey,
                                            child: Center(
                                                child: Text(
                                              S.of(context).ColorCode,
                                              style:
                                                  TextController.tableHeading,
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).Nationality,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[0],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .nationality.value =
                                                      controllers[0].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.nationality
                                                .value = controllers[0].text;
                                            if (RiskCorporateApproval.nationality.value == 'Korea' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Iran' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Myanmar' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Albania' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Barbados' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Burkina Faso' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Haiti' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'South Sudan' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Mozambique' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Jamaica' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Gibraltar' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Jordan' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Mali' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Nigeria' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Panama' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Philippines' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Senegal' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'South Africa' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Syria' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Tanzania' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'United Arab Emirates (UAE)' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Uganda' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Yemen' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Democratic Republic of the Congo' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Cayman Islands' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'China' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Russia') {
                                              return Center(child: Text("7.5"));
                                            } else if (RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Egypt' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Ukraine' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Algeria' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Tunisia' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Pakistan' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Uzbekistan' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Thailand' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Indonesia' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Morocco') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text("2.5"));
                                            }

                                            return Text("");
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.nationality
                                                .value = controllers[0].text;
                                            if (RiskCorporateApproval.nationality.value == 'Korea' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Iran' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Myanmar' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Albania' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Barbados' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Burkina Faso' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Haiti' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'South Sudan' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Mozambique' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Jamaica' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Gibraltar' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Jordan' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Mali' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Nigeria' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Panama' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Philippines' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Senegal' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'South Africa' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Syria' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Tanzania' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'United Arab Emirates (UAE)' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Uganda' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Yemen' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Democratic Republic of the Congo' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Cayman Islands' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'China' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Russia') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Egypt' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Ukraine' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Algeria' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Tunisia' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Pakistan' ||
                                                RiskCorporateApproval.nationality
                                                        .value ==
                                                    'Uzbekistan' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Thailand' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Indonesia' ||
                                                RiskCorporateApproval
                                                        .nationality.value ==
                                                    'Morocco') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).Residency,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[1],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .residency.value =
                                                      controllers[1].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.residency
                                                .value = controllers[1].text;
                                            if (RiskCorporateApproval.residency.value == 'Korea' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Iran' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Myanmar' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Albania' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Barbados' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Burkina Faso' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Haiti' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'South Sudan' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Mozambique' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Jamaica' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Gibraltar' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Jordan' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Mali' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Nigeria' ||
                                                RiskCorporateApproval
                                                        .nationality ==
                                                    'Panama' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Philippines' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Senegal' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'South Africa' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Syria' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Tanzania' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'United Arab Emirates (UAE)' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Uganda' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Yemen' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Democratic Republic of the Congo' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Cayman Islands' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'China' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Russia') {
                                              return Center(child: Text("15"));
                                            } else if (RiskCorporateApproval.residency
                                                        .value ==
                                                    'Egypt' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Ukraine' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Algeria' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Tunisia' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Pakistan' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Uzbekistan' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Thailand' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Indonesia' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Morocco') {
                                              return Center(child: Text("7.5"));
                                            } else {
                                              return Center(child: Text("5"));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval.residency.value == 'Korea' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Iran' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Myanmar' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Albania' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Barbados' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Burkina Faso' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Haiti' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'South Sudan' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Mozambique' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Jamaica' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Gibraltar' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Jordan' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Mali' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Nigeria' ||
                                                RiskCorporateApproval
                                                        .nationality ==
                                                    'Panama' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Philippines' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Senegal' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'South Africa' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Syria' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Tanzania' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'United Arab Emirates (UAE)' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Uganda' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Yemen' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Democratic Republic of the Congo' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Cayman Islands' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'China' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Russia') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval.residency
                                                        .value ==
                                                    'Egypt' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Ukraine' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Algeria' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Tunisia' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Pakistan' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Uzbekistan' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Thailand' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Indonesia' ||
                                                RiskCorporateApproval
                                                        .residency.value ==
                                                    'Morocco') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).Work,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[2],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .work.value =
                                                      controllers[2].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.work.value =
                                                controllers[2].text;
                                            if (RiskCorporateApproval
                                                        .work.value ==
                                                    'Senior Political' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Ruling Family' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Judicial' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Military' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Minister' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Self Employed') {
                                              return Center(child: Text("15"));
                                            } else if (RiskCorporateApproval
                                                    .work.value ==
                                                'Lawyer') {
                                              return Center(child: Text("7.5"));
                                            } else if (RiskCorporateApproval
                                                        .work.value ==
                                                    'Student' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Retired' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Employee') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Text("");
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                        .work.value ==
                                                    'Senior Political' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Ruling Family' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Judicial' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Military' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Minister' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Self Employed') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                    .work.value ==
                                                'Lawyer') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                        .work.value ==
                                                    'Student' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Retired' ||
                                                RiskCorporateApproval
                                                        .work.value ==
                                                    'Employee') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Text("");
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).AccountType,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              // readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[3],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .account.value =
                                                      controllers[3].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.account
                                                .value = controllers[3].text;
                                            if (RiskCorporateApproval
                                                    .account.value ==
                                                'Political') {
                                              return Center(child: Text("15"));
                                            } else if (RiskCorporateApproval
                                                    .account.value ==
                                                'Minor') {
                                              return Center(child: Text("7.5"));
                                            } else if (RiskCorporateApproval
                                                    .account.value ==
                                                'Employee') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Text("");
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .account.value ==
                                                'Political') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                    .account.value ==
                                                'Minor') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                    .account.value ==
                                                'Employee') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .ClientClassification,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[4],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .clientClassification
                                                          .value =
                                                      controllers[4].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval
                                                .clientClassification
                                                .value = controllers[4].text;
                                            if (RiskCorporateApproval
                                                        .clientClassification
                                                        .value ==
                                                    'Retail' ||
                                                RiskCorporateApproval
                                                        .clientClassification
                                                        .value ==
                                                    'Qualified') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskCorporateApproval
                                                    .clientClassification
                                                    .value ==
                                                'Institutional') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text(""));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                        .clientClassification
                                                        .value ==
                                                    'Retail' ||
                                                RiskCorporateApproval
                                                        .clientClassification
                                                        .value ==
                                                    'Qualified') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                    .clientClassification
                                                    .value ==
                                                'Institutional') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .SourceOfWealth,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[5],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .source.value =
                                                      controllers[5].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.source.value =
                                                controllers[5].text;
                                            if (RiskCorporateApproval
                                                        .source.value ==
                                                    'Salary' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Real Estate' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Pension') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskCorporateApproval
                                                        .source.value ==
                                                    'Personal Business' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Investment' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Inheritance' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Marketable Securities') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text(""));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                        .source.value ==
                                                    'Salary' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Real Estate' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Pension') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                        .source.value ==
                                                    'Personal Business' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Investment' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Inheritance' ||
                                                RiskCorporateApproval
                                                        .source.value ==
                                                    'Marketable Securities') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .InvestmentKnowledgeAndExperience,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            readOnly: true,
                                            textAlign: TextAlign.center,
                                            controller: controllers[6],
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                            onChanged: (value) {
                                              setState(() {
                                                RiskCorporateApproval
                                                        .investmentExp.value =
                                                    controllers[6].text;
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.investmentExp
                                                .value = controllers[6].text;
                                            if (RiskCorporateApproval
                                                    .investmentExp.value ==
                                                'High') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskCorporateApproval
                                                        .investmentExp.value ==
                                                    'Low' ||
                                                RiskCorporateApproval
                                                        .investmentExp.value ==
                                                    'Medium') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text(""));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .investmentExp.value ==
                                                'High') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                        .investmentExp.value ==
                                                    'Low' ||
                                                RiskCorporateApproval
                                                        .investmentExp.value ==
                                                    'Medium') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .CustomerAbility,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[7],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .riskAbility.value =
                                                      controllers[7].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.riskAbility
                                                .value = controllers[7].text;
                                            if (RiskCorporateApproval
                                                    .riskAbility.value ==
                                                'High') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskCorporateApproval
                                                        .riskAbility.value ==
                                                    'Low' ||
                                                RiskCorporateApproval
                                                        .riskAbility.value ==
                                                    'Medium') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text(""));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .riskAbility.value ==
                                                'High') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                        .riskAbility.value ==
                                                    'Low' ||
                                                RiskCorporateApproval
                                                        .riskAbility.value ==
                                                    'Medium') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Client\'s Investment Objectives",
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[8],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .investmentObj.value =
                                                      controllers[8].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.investmentObj
                                                .value = controllers[8].text;
                                            if (RiskCorporateApproval.investmentObj
                                                        .value ==
                                                    'Protection Of Capital' ||
                                                RiskCorporateApproval
                                                        .investmentObj.value ==
                                                    'Income' ||
                                                RiskCorporateApproval
                                                        .investmentObj.value ==
                                                    'Balanced') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskCorporateApproval
                                                    .investmentObj.value ==
                                                'Growth Of Capital') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text("0"));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval.investmentObj
                                                        .value ==
                                                    'Protection Of Capital' ||
                                                RiskCorporateApproval
                                                        .investmentObj.value ==
                                                    'Income' ||
                                                RiskCorporateApproval
                                                        .investmentObj.value ==
                                                    'Balanced') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                    .investmentObj.value ==
                                                'Growth Of Capital') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).ClientType,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[9],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .client.value =
                                                      controllers[9].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.client.value =
                                                controllers[9].text;
                                            if (RiskCorporateApproval
                                                    .client.value ==
                                                'Natural Person') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskCorporateApproval
                                                    .client.value ==
                                                'Authorized Person') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text(""));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .client.value ==
                                                'Natural Person') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                    .client.value ==
                                                'Authorized Person') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).RiskTable11,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[10],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .boardDirector.value =
                                                      controllers[10].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.boardDirector
                                                .value = controllers[10].text;
                                            if (RiskCorporateApproval
                                                    .boardDirector.value ==
                                                'Yes') {
                                              return Center(child: Text("5"));
                                            } else if (RiskCorporateApproval
                                                    .boardDirector.value ==
                                                'No') {
                                              return Center(child: Text("2.5"));
                                            } else {
                                              return Center(child: Text(""));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .boardDirector.value ==
                                                'Yes') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .ApproximateAnnualIncome,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[11],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .annualIncome.value =
                                                      controllers[11].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.annualIncome
                                                .value = controllers[11].text;
                                            if (RiskCorporateApproval
                                                    .annualIncome.value ==
                                                'More Than 50,000,000') {
                                              return Center(child: Text("2.5"));
                                            } else {
                                              return Center(child: Text("5"));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .annualIncome.value ==
                                                'More Than 50,000,000') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .ApproximateNetWorth,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[12],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .netWorth.value =
                                                      controllers[12].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.netWorth
                                                .value = controllers[12].text;
                                            if (RiskCorporateApproval
                                                    .netWorth.value ==
                                                'More Than 50,000,000') {
                                              return Center(child: Text("2.5"));
                                            } else {
                                              return Center(child: Text("5"));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .netWorth.value ==
                                                'More Than 50,000,000') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).RiskTable14,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[13],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .investing.value =
                                                      controllers[13].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.investing
                                                .value = controllers[13].text;
                                            if (RiskCorporateApproval
                                                    .investing.value ==
                                                'Less Than 5 Million') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskCorporateApproval
                                                    .investing.value ==
                                                'More Than 5 Million') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text(""));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .investing.value ==
                                                'Less Than 5 Million') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                    .investing.value ==
                                                'More Than 5 Million') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).RiskTable15,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[14],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .owner.value =
                                                      controllers[14].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.owner.value =
                                                controllers[14].text;
                                            if (RiskCorporateApproval
                                                    .owner.value ==
                                                'Yes') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskCorporateApproval
                                                    .owner.value ==
                                                'No') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text(""));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .owner.value ==
                                                'Yes') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                    .owner.value ==
                                                'No') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).RiskTable16,
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          height: 40,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                              readOnly: true,
                                              textAlign: TextAlign.center,
                                              controller: controllers[15],
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none),
                                              onChanged: (value) {
                                                setState(() {
                                                  RiskCorporateApproval
                                                          .pep.value =
                                                      controllers[15].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskCorporateApproval.pep.value =
                                                controllers[15].text;
                                            if (RiskCorporateApproval
                                                    .pep.value ==
                                                'Yes') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskCorporateApproval
                                                    .pep.value ==
                                                'No') {
                                              return Center(child: Text("5"));
                                            } else {
                                              return Center(child: Text(""));
                                            }
                                          }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (RiskCorporateApproval
                                                    .pep.value ==
                                                'Yes') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else if (RiskCorporateApproval
                                                    .pep.value ==
                                                'No') {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              height: 40,
                                              child: Center(
                                                  child: GestureDetector(
                                                onTap: () {
                                                  calulate();
                                                },
                                                child: Text(
                                                  S.of(context).Total,
                                                  style: TextController
                                                      .BodyHeadingText,
                                                ),
                                              ))),
                                        ),
                                        Container(
                                          height: 40,
                                        ),
                                        Container(
                                          height: 40,
                                          child: Center(child: Text('$total')),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            if (total < 65) {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                                child: Center(
                                                  child: Text(
                                                    "Low Risk",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ));
                                            } else if (total > 66 &&
                                                total < 74) {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                                child: Center(
                                                  child: Text(
                                                    "Medium Risk",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ));
                                            } else {
                                              return Center(
                                                  child: Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)
                                                    //more than 50% of width makes circle
                                                    ),
                                                child: Center(
                                                  child: Text(
                                                    "High Risk",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ));
                                            }
                                          }),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 35,
                                width: 140,
                                decoration: BoxDecoration(
                                    color: ColorSelect.east_blue,
                                    border: Border.all(
                                        color: ColorSelect.tabBorderColor)),
                                child: TextButton(
                                  onPressed: () {
                                    putData(ClientId!);
                                  }, // Switch tabs
                                  child: Text(
                                    "Update",
                                    style: TextController.btnText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 100,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(right: 50),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                          //       Container(
                          //         height: 35,
                          //         width: 140,
                          //         decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             border: Border.all(
                          //                 color: ColorSelect
                          //                     .tabBorderColor)),
                          //         child: TextButton(
                          //           onPressed: () {}, // Switch tabs
                          //           child: Text(
                          //             S.of(context).Reject,
                          //             style: TextController.SideMenuText,
                          //           ),
                          //         ),
                          //       ),
                          //       SizedBox(
                          //         width: 20,
                          //       ),
                          //       Container(
                          //         height: 35,
                          //         width: 140,
                          //         decoration: BoxDecoration(
                          //             color: ColorSelect.east_blue,
                          //             border: Border.all(
                          //                 color: ColorSelect
                          //                     .tabBorderColor)),
                          //         child: TextButton(
                          //           onPressed: () async {
                          //             if (RiskCorporateApproval.send.value ==
                          //                 false) {
                          //               var color = "Green";
                          //               if (total > 66 && total < 75) {
                          //                 color = "Yellow";
                          //               } else if (total >= 75) {
                          //                 color = "Red";
                          //               }
                          //               bool x = await GlobalPermission
                          //                   .formApproval(
                          //                       "Risk Assesment",
                          //                       RiskCorporateApproval
                          //                           .clientID.value,
                          //                       RiskCorporateApproval
                          //                               .clientName
                          //                               .value +
                          //                           "-" +
                          //                           total.toString() +
                          //                           "-" +
                          //                           color,
                          //                       0);
                          //               if (x == true) {
                          //                 Fluttertoast.showToast(
                          //                     msg: "Sent For Approval",
                          //                     toastLength:
                          //                         Toast.LENGTH_SHORT,
                          //                     gravity:
                          //                         ToastGravity.CENTER,
                          //                     timeInSecForIosWeb: 3,
                          //                     backgroundColor: Colors.red,
                          //                     textColor: Colors.white,
                          //                     fontSize: 16.0);
                          //               }
                          //               RiskCorporateApproval.send.value =
                          //                   true;
                          //             }
                          //           }, // Switch tabs
                          //           child: Text(
                          //             S.of(context).Approve,
                          //             style: TextController.btnText,
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Navigation(),
            ],
          ),
        ),
      ),
    );
  }
}
