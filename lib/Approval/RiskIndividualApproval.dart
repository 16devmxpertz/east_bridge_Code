import 'dart:convert';

import 'package:east_bridge/CustomerSearchRiskIndividual.dart';
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
import 'package:pinput/pinput.dart';

class Controller extends GetxController {
  // Rx<TextEditingController> _firstName = TextEditingController().obs;
  var count = 0;
  void increment() {
    count++;
    update();
  }
}

class RiskIndividualApproval extends StatefulWidget {
  RiskIndividualApproval({@required id}) {
    ClientId = id;
  }
  @override
  State<RiskIndividualApproval> createState() => _RiskFormState();
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

class _RiskFormState extends State<RiskIndividualApproval> {
  Rx<TextEditingController> _firstName = TextEditingController().obs;
  final RiskIndividualApproval textControllers = Get.put(RiskIndividualApproval(
    id: ClientId,
  ));

  List<TextEditingController> controllers = [];
  // RiskIndividualApproval({@required id}) {
  //   ClientId = id;
  // }

  // controller=pi.randomFun();
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

  void a() async {
    var data = await GlobalPermission.formPermission("Risk Assessment");
    setState(() {
      permission = data;
    });
  }

  // test(double i) {
  //   Future.delayed(Duration.zero, () {
  //     // Update the state after the build phase
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       setState(() {
  //         count += i;
  //       });
  //     });
  //   });
  // }

  double total = 0;
  calulate() {
    print(RiskIndividualApproval.investmentObj.value);
    // setState(() {
    //   RiskIndividualApproval.nationality.value = controllers[0].text;
    //   RiskIndividualApproval.residency.value = controllers[1].text;
    //   RiskIndividualApproval.work.value = controllers[2].text;
    //   RiskIndividualApproval.account.value = controllers[3].text;
    // });
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
      print(RiskIndividualApproval.nationality.value);
      print(7.5);
    } else if (countryList2.contains(controllers[0].text)) {
      x += 5;
      print(RiskIndividualApproval.nationality.value);
      print(5);
    } else {
      x += 2.5;
      print(RiskIndividualApproval.nationality.value);
      print(2.5);
    }
    if (recidence1.contains(controllers[1].text)) {
      x += 15;
      print(RiskIndividualApproval.residency.value);
      print(15);
    } else if (recidence2.contains(controllers[1].text)) {
      x += 7.5;
      print(RiskIndividualApproval.residency.value);
      print(7.5);
    } else {
      x += 5;
      print(RiskIndividualApproval.residency.value);
      print(5);
    }

    if (workList1.contains(controllers[2].text)) {
      x += 15;
      print(RiskIndividualApproval.work.value);
      print(15);
    } else if (workList2.contains(controllers[2].text)) {
      x += 7.5;
      print(RiskIndividualApproval.work.value);
      print(7.5);
    } else if (workList3.contains(controllers[2].text)) {
      x += 5;
      print(RiskIndividualApproval.work.value);
      print(5);
    }
    if (at1.contains(controllers[3].text)) {
      x += 5;
      print(RiskIndividualApproval.account.value);
      print(5);
    } else if (at2.contains(controllers[3].text)) {
      x += 7.5;
      print(RiskIndividualApproval.account.value);
      print(7.5);
    } else if (at3.contains(controllers[3].text)) {
      x += 15;
      print(RiskIndividualApproval.account.value);
      print(15);
    }
    if (clientClassification1.contains(controllers[4].text)) {
      x += 2.5;
      print(RiskIndividualApproval.clientClassification.value);
      print(2.5);
    } else if (clientClassification2.contains(controllers[4].text)) {
      x += 5;
      print(RiskIndividualApproval.clientClassification.value);
      print(5);
    }
    if (Sources1.contains(controllers[5].text)) {
      x += 2.5;
      print(RiskIndividualApproval.source.value);
      print(2.5);
    } else if (sourceList2.contains(controllers[5].text)) {
      x += 5;
      print(RiskIndividualApproval.source.value);
      print(5);
    }
    if (invE.contains(controllers[6].text)) {
      x += 5;
      print(RiskIndividualApproval.investmentExp.value);
      print(5);
    } else if (invE2.contains(controllers[6].text)) {
      x += 2.5;
      print(RiskIndividualApproval.investmentExp.value);
      print(2.5);
    }
    if (riskAbility.contains(controllers[7].text)) {
      x += 5;
      print(RiskIndividualApproval.riskAbility.value);
      print(5);
    } else if (riskAbility2.contains(controllers[7].text)) {
      x += 2.5;
      print(RiskIndividualApproval.riskAbility.value);
      print(2.5);
    }

    if (ct1.contains(controllers[8].text)) {
      x += 2.5;
      print(RiskIndividualApproval.client.value);
      print(2.5);
    } else if (ct2.contains(controllers[8].text)) {
      x += 5;
      print(RiskIndividualApproval.client.value);
      print(5);
    }

    for (int i = 0; i < controllers[9].text.length; i++) {
      print("LOOPPPPP");

      if (controllers[9].text[i] == "1") {
        setState(() {
          if (i == 0) {
            controllers[9].text = "Protection Of Capital";
          } else if (i == 1) {
            controllers[9].text = "Income";
          } else if (i == 2) {
            controllers[9].text = "Balanced";
          } else if (i == 3) {
            controllers[9].text = "Growth Of Capital";
          }
        });
        break; // Break out of the loop once a match is found
      } else {
        setState(() {
          controllers[9].text = "";
        });
      }
      print("Controllerrrr");
      String y = controllers[9].text;
      print(y);
    }

    if (invobj.contains(controllers[9].text)) {
      x += 2.5;
      print(controllers[8].text);
      print(2.5);
    } else if (invobj2.contains(controllers[9].text)) {
      x += 5;
      print(controllers[8].text);
      print(5);
    }
    if (annualInc1.contains(controllers[10].text)) {
      x += 2.5;
      print(controllers[10].text);
      print(2.5);
    } else {
      x += 5;
      print(controllers[10].text);
      print(5);
    }
    if (netWorth1.contains(controllers[11].text)) {
      x += 2.5;
      print(controllers[11].text);
      print(2.5);
    } else {
      x += 5;
      print(controllers[11].text);
      print(5);
    }
    if (ans.contains(controllers[12].text)) {
      x += 5;
      print(controllers[12].text);
      print(5);
    } else if (ans2.contains(controllers[12].text)) {
      x += 2.5;
      print(controllers[9].text);
      print(2.5);
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

    if (ans.contains(controllers[14].text)) {
      x += 2.5;
      print(controllers[14].text);
      print(2.5);
    } else if (ans2.contains(controllers[14].text)) {
      x += 5;
      print(controllers[14].text);
      print(5);
    }

    String n = controllers[15].text == "" ? "No" : "Yes";
    print(n);
    print("__________________________________");
    if (ans.contains(n)) {
      x += 2.5;
      print(controllers[15].text);
      print(2.5);
    } else if (ans2.contains(n)) {
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
    // calulate();
    print("RiskFormmmmmmm");
    print("ClientIDDd");
    print(ClientId);
    print(RiskIndividualApproval.clientID.value);

    setState(() {
      for (int j = 0; j < 16; j++) {
        // list.add("");
        TextEditingController z = new TextEditingController();
        z.text = "";
        controllers.add(z);
      }
    });

    getdata(ClientId!);

    // a();
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
    print('${GlobalPermission.urlLink}/api/RiskAssessment/${id}');
    var url = Uri.parse('${GlobalPermission.urlLink}/api/RiskAssessment/${id}');

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
          print("kkkkkkkkkkkk");

          print(k);

          for (String i in responseData) {
            print("iiiiiiiiii");

            print(i);
            // list.add(i);
            list[k] = i;
            k++;
          }
          print("listt-----");

          print(list);
          controllers.clear();
          for (int x = 0; x < 16; x++) {
            print(x);
            TextEditingController y = new TextEditingController();
            y.text = list[x]!;

            controllers.add(y);
          }
        });

        print("Controllerssssssssss");
        print(controllers);
        print("Calculateeeeeeeeee");
        calulate();
        print(list);
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
        "clientInvestmentObjectives": controllers[9].text,
        "clienttype": controllers[8].text,
        "isTheClientABoardMemberOrACommitteeMemberInAListedCompany":
            controllers[12].text,
        "investingWithEastBridgeCompany": controllers[10].text,
        "approximateNetWorthExcludingResidenceInSAR": controllers[11].text,
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
        "clientInvestmentObjectives": controllers[9].text,
        "clienttype": controllers[8].text,
        "isTheClientABoardMemberOrACommitteeMemberInAListedCompany":
            controllers[12].text,
        "investingWithEastBridgeCompany": controllers[10].text,
        "approximateNetWorthExcludingResidenceInSAR": controllers[11].text,
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
      controllers[9].text = data["clientInvestmentObjectives"];
      controllers[8].text = data["clienttype"];
      controllers[12].text =
          data["isTheClientABoardMemberOrACommitteeMemberInAListedCompany"];
      controllers[10].text = data["investingWithEastBridgeCompany"];
      controllers[11].text = data["approximateNetWorthExcludingResidenceInSAR"];
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
      get(clientId);
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
                    //                     builder: (context) => RiskIndividualApproval(),
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

                    AnimatedContainer(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      transform:
                          Matrix4.translationValues(xOffset, yOffset, 1.0),
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: SingleChildScrollView(
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
                                Container(
                                  width: 900,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
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
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                S.of(context).Nationality,
                                                style: TextController.BodyText,
                                              ),
                                            ),
                                          ),
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
                                                  RiskIndividualApproval
                                                          .nationality.value =
                                                      controllers[0].text;
                                                  //calulate();
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.nationality
                                                .value = controllers[0].text;
                                            if (RiskIndividualApproval.nationality.value == 'Korea' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Iran' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Myanmar' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Albania' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Barbados' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Burkina Faso' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Haiti' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'South Sudan' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Mozambique' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Jamaica' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Gibraltar' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Jordan' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Mali' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Nigeria' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Panama' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Philippines' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Senegal' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'South Africa' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Syria' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Tanzania' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'United Arab Emirates (UAE)' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Uganda' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Yemen' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Democratic Republic of the Congo' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Cayman Islands' ||
                                                RiskIndividualApproval
                                                        .nationality.value ==
                                                    'China' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Russia') {
                                              return Center(child: Text("7.5"));
                                            } else if (RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Egypt' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Ukraine' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Algeria' ||
                                                RiskIndividualApproval
                                                        .nationality.value ==
                                                    'Tunisia' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Pakistan' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Uzbekistan' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Thailand' ||
                                                RiskIndividualApproval
                                                        .nationality.value ==
                                                    'Indonesia' ||
                                                RiskIndividualApproval
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
                                            RiskIndividualApproval.nationality
                                                .value = controllers[0].text;
                                            if (RiskIndividualApproval.nationality.value == 'Korea' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Iran' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Myanmar' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Albania' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Barbados' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Burkina Faso' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Haiti' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'South Sudan' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Mozambique' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Jamaica' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Gibraltar' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Jordan' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Mali' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Nigeria' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Panama' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Philippines' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Senegal' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'South Africa' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Syria' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Tanzania' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'United Arab Emirates (UAE)' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Uganda' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Yemen' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Democratic Republic of the Congo' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Cayman Islands' ||
                                                RiskIndividualApproval
                                                        .nationality.value ==
                                                    'China' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
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
                                            } else if (RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Egypt' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Ukraine' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Algeria' ||
                                                RiskIndividualApproval
                                                        .nationality.value ==
                                                    'Tunisia' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Pakistan' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Uzbekistan' ||
                                                RiskIndividualApproval.nationality
                                                        .value ==
                                                    'Thailand' ||
                                                RiskIndividualApproval
                                                        .nationality.value ==
                                                    'Indonesia' ||
                                                RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .residency.value =
                                                      controllers[1].text;
                                                  //calulate();
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.residency
                                                .value = controllers[1].text;
                                            if (RiskIndividualApproval.residency.value == 'Korea' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Iran' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Myanmar' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Albania' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Barbados' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Burkina Faso' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Haiti' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'South Sudan' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Mozambique' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Jamaica' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Gibraltar' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Jordan' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Mali' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Nigeria' ||
                                                RiskIndividualApproval
                                                        .nationality ==
                                                    'Panama' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Philippines' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Senegal' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'South Africa' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Syria' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Tanzania' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'United Arab Emirates (UAE)' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Uganda' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Yemen' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Democratic Republic of the Congo' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Cayman Islands' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'China' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Russia') {
                                              return Center(child: Text("15"));
                                            } else if (RiskIndividualApproval.residency
                                                        .value ==
                                                    'Egypt' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Ukraine' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Algeria' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Tunisia' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Pakistan' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Uzbekistan' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Thailand' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Indonesia' ||
                                                RiskIndividualApproval
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
                                            if (RiskIndividualApproval.residency.value == 'Korea' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Iran' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Myanmar' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Albania' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Barbados' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Burkina Faso' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Haiti' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'South Sudan' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Mozambique' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Jamaica' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Gibraltar' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Jordan' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Mali' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Nigeria' ||
                                                RiskIndividualApproval
                                                        .nationality ==
                                                    'Panama' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Philippines' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Senegal' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'South Africa' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Syria' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Tanzania' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'United Arab Emirates (UAE)' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Uganda' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Yemen' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Democratic Republic of the Congo' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Cayman Islands' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'China' ||
                                                RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval.residency
                                                        .value ==
                                                    'Egypt' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Ukraine' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Algeria' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Tunisia' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Pakistan' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Uzbekistan' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Thailand' ||
                                                RiskIndividualApproval
                                                        .residency.value ==
                                                    'Indonesia' ||
                                                RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .work.value =
                                                      controllers[2].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.work.value =
                                                controllers[2].text;
                                            if (RiskIndividualApproval
                                                        .work.value ==
                                                    'Senior Political' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Ruling Family' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Judicial' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Military' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Minister' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Self Employed') {
                                              return Center(child: Text("15"));
                                            } else if (RiskIndividualApproval
                                                    .work.value ==
                                                'Lawyer') {
                                              return Center(child: Text("7.5"));
                                            } else if (RiskIndividualApproval
                                                        .work.value ==
                                                    'Student' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Retired' ||
                                                RiskIndividualApproval
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
                                            if (RiskIndividualApproval
                                                        .work.value ==
                                                    'Senior Political' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Ruling Family' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Judicial' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Military' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Minister' ||
                                                RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
                                                        .work.value ==
                                                    'Student' ||
                                                RiskIndividualApproval
                                                        .work.value ==
                                                    'Retired' ||
                                                RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .account.value =
                                                      controllers[3].text;
                                                  // calulate();
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.account
                                                .value = controllers[3].text;
                                            if (RiskIndividualApproval
                                                    .account.value ==
                                                'Political') {
                                              return Center(child: Text("15"));
                                            } else if (RiskIndividualApproval
                                                    .account.value ==
                                                'Minor') {
                                              return Center(child: Text("7.5"));
                                            } else if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
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
                                                  RiskIndividualApproval
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
                                            RiskIndividualApproval
                                                .clientClassification
                                                .value = controllers[4].text;
                                            if (RiskIndividualApproval
                                                        .clientClassification
                                                        .value ==
                                                    'Retail' ||
                                                RiskIndividualApproval
                                                        .clientClassification
                                                        .value ==
                                                    'Qualified') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
                                                        .clientClassification
                                                        .value ==
                                                    'Retail' ||
                                                RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .source.value =
                                                      controllers[5].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.source
                                                .value = controllers[5].text;
                                            if (RiskIndividualApproval
                                                        .source.value ==
                                                    'Salary' ||
                                                RiskIndividualApproval
                                                        .source.value ==
                                                    'Real Estate' ||
                                                RiskIndividualApproval
                                                        .source.value ==
                                                    'Pension') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskIndividualApproval.source
                                                        .value ==
                                                    'Personal Business' ||
                                                RiskIndividualApproval
                                                        .source.value ==
                                                    'Investment' ||
                                                RiskIndividualApproval
                                                        .source.value ==
                                                    'Inheritance' ||
                                                RiskIndividualApproval
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
                                            if (RiskIndividualApproval
                                                        .source.value ==
                                                    'Salary' ||
                                                RiskIndividualApproval
                                                        .source.value ==
                                                    'Real Estate' ||
                                                RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval.source
                                                        .value ==
                                                    'Personal Business' ||
                                                RiskIndividualApproval
                                                        .source.value ==
                                                    'Investment' ||
                                                RiskIndividualApproval
                                                        .source.value ==
                                                    'Inheritance' ||
                                                RiskIndividualApproval
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
                                                RiskIndividualApproval
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
                                            RiskIndividualApproval.investmentExp
                                                .value = controllers[6].text;
                                            if (RiskIndividualApproval
                                                    .investmentExp.value ==
                                                'High') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskIndividualApproval
                                                        .investmentExp.value ==
                                                    'Low' ||
                                                RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
                                                        .investmentExp.value ==
                                                    'Low' ||
                                                RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .riskAbility.value =
                                                      controllers[7].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.riskAbility
                                                .value = controllers[7].text;
                                            if (RiskIndividualApproval
                                                    .riskAbility.value ==
                                                'High') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskIndividualApproval
                                                        .riskAbility.value ==
                                                    'Low' ||
                                                RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
                                                        .riskAbility.value ==
                                                    'Low' ||
                                                RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .investmentObj.value =
                                                      controllers[9].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.investmentObj
                                                .value = controllers[9].text;
                                            if (RiskIndividualApproval
                                                        .investmentObj.value ==
                                                    'Protection Of Capital' ||
                                                RiskIndividualApproval
                                                        .investmentObj.value ==
                                                    'Income' ||
                                                RiskIndividualApproval
                                                        .investmentObj.value ==
                                                    'Balanced') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
                                                        .investmentObj.value ==
                                                    'Protection Of Capital' ||
                                                RiskIndividualApproval
                                                        .investmentObj.value ==
                                                    'Income' ||
                                                RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .client.value =
                                                      controllers[8].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.client
                                                .value = controllers[8].text;
                                            if (RiskIndividualApproval
                                                    .client.value ==
                                                'Natural Person') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .boardDirector.value =
                                                      controllers[12].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.boardDirector
                                                .value = controllers[12].text;
                                            if (RiskIndividualApproval
                                                    .boardDirector.value ==
                                                'Yes') {
                                              return Center(child: Text("5"));
                                            } else if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .annualIncome.value =
                                                      controllers[10].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.annualIncome
                                                .value = controllers[10].text;
                                            if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .netWorth.value =
                                                      controllers[11].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.netWorth
                                                .value = controllers[11].text;
                                            if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .investing.value =
                                                      controllers[13].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.investing
                                                .value = controllers[13].text;
                                            if (RiskIndividualApproval
                                                    .investing.value ==
                                                'Less Than 5 Million') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .owner.value =
                                                      controllers[14].text;
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.owner.value =
                                                controllers[14].text;
                                            if (RiskIndividualApproval
                                                    .owner.value ==
                                                'Yes') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
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
                                                  RiskIndividualApproval
                                                          .pep.value =
                                                      controllers[15].text == ""
                                                          ? "No"
                                                          : "Yes";
                                                  controllers[15].text =
                                                      controllers[15].text == ""
                                                          ? "No"
                                                          : "Yes";
                                                });
                                              }),
                                        ),
                                        Container(
                                          height: 40,
                                          child: LayoutBuilder(
                                              builder: (context, constraints) {
                                            RiskIndividualApproval.pep.value =
                                                controllers[15].text == ""
                                                    ? "No"
                                                    : "Yes";
                                            if (RiskIndividualApproval
                                                    .pep.value ==
                                                'Yes') {
                                              return Center(child: Text("2.5"));
                                            } else if (RiskIndividualApproval
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
                                            if (RiskIndividualApproval
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
                                            } else if (RiskIndividualApproval
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
                                                  print("-----------!!!!");

                                                  print(total);
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
                            //   padding: const EdgeInsets.only(right: 50),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       Container(
                            //         height: 35,
                            //         width: 140,
                            //         decoration: BoxDecoration(
                            //             color: Colors.white,
                            //             border: Border.all(
                            //                 color: ColorSelect.tabBorderColor)),
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
                            //                 color: ColorSelect.tabBorderColor)),
                            //         child: TextButton(
                            //           onPressed: () async {
                            //             if (RiskIndividualApproval.send.value ==
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
                            //                       RiskIndividualApproval
                            //                           .clientID.value,
                            //                       RiskIndividualApproval
                            //                               .clientName.value +
                            //                           "-" +
                            //                           total.toString() +
                            //                           "-" +
                            //                           color,
                            //                       0);
                            //               if (x == true) {
                            //                 Fluttertoast.showToast(
                            //                     msg: "Sent For Approval",
                            //                     toastLength: Toast.LENGTH_SHORT,
                            //                     gravity: ToastGravity.CENTER,
                            //                     timeInSecForIosWeb: 3,
                            //                     backgroundColor: Colors.red,
                            //                     textColor: Colors.white,
                            //                     fontSize: 16.0);
                            //               }
                            //               RiskIndividualApproval.send.value =
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
                    ),
                    // if (sidebarVisible) SideBar() else Container(),
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
