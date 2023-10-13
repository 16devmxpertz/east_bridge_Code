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

class RiskForm extends StatefulWidget {
  const RiskForm({Key? key}) : super(key: key);
  @override
  State<RiskForm> createState() => _RiskFormState();
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

class _RiskFormState extends State<RiskForm> {
  Rx<TextEditingController> _firstName = TextEditingController().obs;
  final RiskForm textControllers = Get.put(RiskForm());

  List<TextEditingController> controllers = [];

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
    print(RiskForm.investmentObj.value);
    // setState(() {
    //   RiskForm.nationality.value = controllers[0].text;
    //   RiskForm.residency.value = controllers[1].text;
    //   RiskForm.work.value = controllers[2].text;
    //   RiskForm.account.value = controllers[3].text;
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
      print(RiskForm.nationality.value);
      print(7.5);
    } else if (countryList2.contains(controllers[0].text)) {
      x += 5;
      print(RiskForm.nationality.value);
      print(5);
    } else {
      x += 2.5;
      print(RiskForm.nationality.value);
      print(2.5);
    }
    if (recidence1.contains(controllers[1].text)) {
      x += 15;
      print(RiskForm.residency.value);
      print(15);
    } else if (recidence2.contains(controllers[1].text)) {
      x += 7.5;
      print(RiskForm.residency.value);
      print(7.5);
    } else {
      x += 5;
      print(RiskForm.residency.value);
      print(5);
    }

    if (workList1.contains(controllers[2].text)) {
      x += 15;
      print(RiskForm.work.value);
      print(15);
    } else if (workList2.contains(controllers[2].text)) {
      x += 7.5;
      print(RiskForm.work.value);
      print(7.5);
    } else if (workList3.contains(controllers[2].text)) {
      x += 5;
      print(RiskForm.work.value);
      print(5);
    }
    if (at1.contains(controllers[3].text)) {
      x += 5;
      print(RiskForm.account.value);
      print(5);
    } else if (at2.contains(controllers[3].text)) {
      x += 7.5;
      print(RiskForm.account.value);
      print(7.5);
    } else if (at3.contains(controllers[3].text)) {
      x += 15;
      print(RiskForm.account.value);
      print(15);
    }
    if (clientClassification1.contains(controllers[4].text)) {
      x += 2.5;
      print(RiskForm.clientClassification.value);
      print(2.5);
    } else if (clientClassification2.contains(controllers[4].text)) {
      x += 5;
      print(RiskForm.clientClassification.value);
      print(5);
    }
    if (Sources1.contains(controllers[5].text)) {
      x += 2.5;
      print(RiskForm.source.value);
      print(2.5);
    } else if (sourceList2.contains(controllers[5].text)) {
      x += 5;
      print(RiskForm.source.value);
      print(5);
    }
    if (invE.contains(controllers[6].text)) {
      x += 5;
      print(RiskForm.investmentExp.value);
      print(5);
    } else if (invE2.contains(controllers[6].text)) {
      x += 2.5;
      print(RiskForm.investmentExp.value);
      print(2.5);
    }
    if (riskAbility.contains(controllers[7].text)) {
      x += 5;
      print(RiskForm.riskAbility.value);
      print(5);
    } else if (riskAbility2.contains(controllers[7].text)) {
      x += 2.5;
      print(RiskForm.riskAbility.value);
      print(2.5);
    }

    if (ct1.contains(controllers[8].text)) {
      x += 2.5;
      print(RiskForm.client.value);
      print(2.5);
    } else if (ct2.contains(controllers[8].text)) {
      x += 5;
      print(RiskForm.client.value);
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
    print(RiskForm.clientID.value);

    setState(() {
      for (int j = 0; j < 16; j++) {
        // list.add("");
        TextEditingController z = new TextEditingController();
        z.text = "";
        controllers.add(z);
      }
    });

    getdata(RiskForm.clientID.value);

    a();
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

  void get() async {
    print("clientid-------------");
    print(
        '${GlobalPermission.urlLink}/api/RiskAssessment/${RiskForm.clientID.value}');
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/RiskAssessment/${RiskForm.clientID.value}');

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
        "clientId": RiskForm.clientID.value,
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
      get();
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
                margin: EdgeInsets.only(top: 40),
                color: Colors.white,
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
                                        builder: (context) => RiskForm(),
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
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) => KYCPdfUploadIND(),
                                      // ));
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
                                CustomerSearchRiskIndividual(),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Client Name : " +
                                            RiskForm.clientName.value,
                                        style: TextController.BodyHeadingText,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
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
                                                  style: TextController
                                                      .tableHeading,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                height: 50,
                                                color: ColorSelect.east_grey,
                                                child: Center(
                                                    child: Text(
                                                  S.of(context).Value,
                                                  style: TextController
                                                      .tableHeading,
                                                ))),
                                            Container(
                                                height: 50,
                                                color: ColorSelect.east_grey,
                                                child: Center(
                                                    child: Text(
                                                  S.of(context).Weightage,
                                                  style: TextController
                                                      .tableHeading,
                                                ))),
                                            Container(
                                                height: 50,
                                                color: ColorSelect.east_grey,
                                                child: Center(
                                                    child: Text(
                                                  S.of(context).ColorCode,
                                                  style: TextController
                                                      .tableHeading,
                                                ))),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                height: 40,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).Nationality,
                                                    style:
                                                        TextController.BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[0],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.nationality
                                                              .value =
                                                          controllers[0].text;
                                                      //calulate();
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.nationality.value =
                                                    controllers[0].text;
                                                if (RiskForm.nationality.value == 'Korea' ||
                                                    RiskForm.nationality.value ==
                                                        'Iran' ||
                                                    RiskForm.nationality.value ==
                                                        'Myanmar' ||
                                                    RiskForm.nationality.value ==
                                                        'Albania' ||
                                                    RiskForm.nationality.value ==
                                                        'Barbados' ||
                                                    RiskForm.nationality.value ==
                                                        'Burkina Faso' ||
                                                    RiskForm.nationality.value ==
                                                        'Haiti' ||
                                                    RiskForm.nationality.value ==
                                                        'South Sudan' ||
                                                    RiskForm.nationality.value ==
                                                        'Mozambique' ||
                                                    RiskForm.nationality.value ==
                                                        'Jamaica' ||
                                                    RiskForm.nationality.value ==
                                                        'Gibraltar' ||
                                                    RiskForm.nationality.value ==
                                                        'Jordan' ||
                                                    RiskForm.nationality.value ==
                                                        'Mali' ||
                                                    RiskForm.nationality.value ==
                                                        'Nigeria' ||
                                                    RiskForm.nationality.value ==
                                                        'Panama' ||
                                                    RiskForm.nationality.value ==
                                                        'Philippines' ||
                                                    RiskForm.nationality.value ==
                                                        'Senegal' ||
                                                    RiskForm.nationality.value ==
                                                        'South Africa' ||
                                                    RiskForm.nationality.value ==
                                                        'Syria' ||
                                                    RiskForm.nationality.value ==
                                                        'Tanzania' ||
                                                    RiskForm.nationality.value ==
                                                        'United Arab Emirates (UAE)' ||
                                                    RiskForm.nationality.value ==
                                                        'Uganda' ||
                                                    RiskForm.nationality.value ==
                                                        'Yemen' ||
                                                    RiskForm.nationality.value ==
                                                        'Democratic Republic of the Congo' ||
                                                    RiskForm.nationality.value ==
                                                        'Cayman Islands' ||
                                                    RiskForm.nationality.value ==
                                                        'China' ||
                                                    RiskForm.nationality.value ==
                                                        'Russia') {
                                                  return Center(
                                                      child: Text("7.5"));
                                                } else if (RiskForm.nationality
                                                            .value ==
                                                        'Egypt' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Ukraine' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Algeria' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Tunisia' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Pakistan' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Uzbekistan' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Thailand' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Indonesia' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Morocco') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text("2.5"));
                                                }

                                                return Text("");
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.nationality.value =
                                                    controllers[0].text;
                                                if (RiskForm.nationality.value == 'Korea' ||
                                                    RiskForm.nationality.value ==
                                                        'Iran' ||
                                                    RiskForm.nationality.value ==
                                                        'Myanmar' ||
                                                    RiskForm.nationality.value ==
                                                        'Albania' ||
                                                    RiskForm.nationality.value ==
                                                        'Barbados' ||
                                                    RiskForm.nationality.value ==
                                                        'Burkina Faso' ||
                                                    RiskForm.nationality.value ==
                                                        'Haiti' ||
                                                    RiskForm.nationality.value ==
                                                        'South Sudan' ||
                                                    RiskForm.nationality.value ==
                                                        'Mozambique' ||
                                                    RiskForm.nationality.value ==
                                                        'Jamaica' ||
                                                    RiskForm.nationality.value ==
                                                        'Gibraltar' ||
                                                    RiskForm.nationality.value ==
                                                        'Jordan' ||
                                                    RiskForm.nationality.value ==
                                                        'Mali' ||
                                                    RiskForm.nationality.value ==
                                                        'Nigeria' ||
                                                    RiskForm.nationality.value ==
                                                        'Panama' ||
                                                    RiskForm.nationality.value ==
                                                        'Philippines' ||
                                                    RiskForm.nationality.value ==
                                                        'Senegal' ||
                                                    RiskForm.nationality.value ==
                                                        'South Africa' ||
                                                    RiskForm.nationality.value ==
                                                        'Syria' ||
                                                    RiskForm.nationality.value ==
                                                        'Tanzania' ||
                                                    RiskForm.nationality.value ==
                                                        'United Arab Emirates (UAE)' ||
                                                    RiskForm.nationality.value ==
                                                        'Uganda' ||
                                                    RiskForm.nationality.value ==
                                                        'Yemen' ||
                                                    RiskForm.nationality.value ==
                                                        'Democratic Republic of the Congo' ||
                                                    RiskForm.nationality.value ==
                                                        'Cayman Islands' ||
                                                    RiskForm.nationality.value ==
                                                        'China' ||
                                                    RiskForm.nationality.value ==
                                                        'Russia') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm.nationality
                                                            .value ==
                                                        'Egypt' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Ukraine' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Algeria' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Tunisia' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Pakistan' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Uzbekistan' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Thailand' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Indonesia' ||
                                                    RiskForm.nationality
                                                            .value ==
                                                        'Morocco') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S.of(context).Residency,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[1],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.residency.value =
                                                          controllers[1].text;
                                                      //calulate();
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.residency.value =
                                                    controllers[1].text;
                                                if (RiskForm.residency.value == 'Korea' ||
                                                    RiskForm.residency.value ==
                                                        'Iran' ||
                                                    RiskForm.residency.value ==
                                                        'Myanmar' ||
                                                    RiskForm.residency.value ==
                                                        'Albania' ||
                                                    RiskForm.residency.value ==
                                                        'Barbados' ||
                                                    RiskForm.residency.value ==
                                                        'Burkina Faso' ||
                                                    RiskForm.residency.value ==
                                                        'Haiti' ||
                                                    RiskForm.residency.value ==
                                                        'South Sudan' ||
                                                    RiskForm.residency.value ==
                                                        'Mozambique' ||
                                                    RiskForm.residency.value ==
                                                        'Jamaica' ||
                                                    RiskForm.residency.value ==
                                                        'Gibraltar' ||
                                                    RiskForm.residency.value ==
                                                        'Jordan' ||
                                                    RiskForm.residency.value ==
                                                        'Mali' ||
                                                    RiskForm.residency.value ==
                                                        'Nigeria' ||
                                                    RiskForm.nationality ==
                                                        'Panama' ||
                                                    RiskForm.residency.value ==
                                                        'Philippines' ||
                                                    RiskForm.residency.value ==
                                                        'Senegal' ||
                                                    RiskForm.residency.value ==
                                                        'South Africa' ||
                                                    RiskForm.residency.value ==
                                                        'Syria' ||
                                                    RiskForm.residency.value ==
                                                        'Tanzania' ||
                                                    RiskForm.residency.value ==
                                                        'United Arab Emirates (UAE)' ||
                                                    RiskForm.residency.value ==
                                                        'Uganda' ||
                                                    RiskForm.residency.value ==
                                                        'Yemen' ||
                                                    RiskForm.residency.value ==
                                                        'Democratic Republic of the Congo' ||
                                                    RiskForm.residency.value ==
                                                        'Cayman Islands' ||
                                                    RiskForm.residency.value ==
                                                        'China' ||
                                                    RiskForm.residency.value ==
                                                        'Russia') {
                                                  return Center(
                                                      child: Text("15"));
                                                } else if (RiskForm
                                                            .residency.value ==
                                                        'Egypt' ||
                                                    RiskForm.residency.value ==
                                                        'Ukraine' ||
                                                    RiskForm.residency.value ==
                                                        'Algeria' ||
                                                    RiskForm.residency.value ==
                                                        'Tunisia' ||
                                                    RiskForm.residency.value ==
                                                        'Pakistan' ||
                                                    RiskForm.residency.value ==
                                                        'Uzbekistan' ||
                                                    RiskForm.residency.value ==
                                                        'Thailand' ||
                                                    RiskForm.residency.value ==
                                                        'Indonesia' ||
                                                    RiskForm.residency.value ==
                                                        'Morocco') {
                                                  return Center(
                                                      child: Text("7.5"));
                                                } else {
                                                  return Center(
                                                      child: Text("5"));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.residency.value == 'Korea' ||
                                                    RiskForm.residency.value ==
                                                        'Iran' ||
                                                    RiskForm.residency.value ==
                                                        'Myanmar' ||
                                                    RiskForm.residency.value ==
                                                        'Albania' ||
                                                    RiskForm.residency.value ==
                                                        'Barbados' ||
                                                    RiskForm.residency.value ==
                                                        'Burkina Faso' ||
                                                    RiskForm.residency.value ==
                                                        'Haiti' ||
                                                    RiskForm.residency.value ==
                                                        'South Sudan' ||
                                                    RiskForm.residency.value ==
                                                        'Mozambique' ||
                                                    RiskForm.residency.value ==
                                                        'Jamaica' ||
                                                    RiskForm.residency.value ==
                                                        'Gibraltar' ||
                                                    RiskForm.residency.value ==
                                                        'Jordan' ||
                                                    RiskForm.residency.value ==
                                                        'Mali' ||
                                                    RiskForm.residency.value ==
                                                        'Nigeria' ||
                                                    RiskForm.nationality ==
                                                        'Panama' ||
                                                    RiskForm.residency.value ==
                                                        'Philippines' ||
                                                    RiskForm.residency.value ==
                                                        'Senegal' ||
                                                    RiskForm.residency.value ==
                                                        'South Africa' ||
                                                    RiskForm.residency.value ==
                                                        'Syria' ||
                                                    RiskForm.residency.value ==
                                                        'Tanzania' ||
                                                    RiskForm.residency.value ==
                                                        'United Arab Emirates (UAE)' ||
                                                    RiskForm.residency.value ==
                                                        'Uganda' ||
                                                    RiskForm.residency.value ==
                                                        'Yemen' ||
                                                    RiskForm.residency.value ==
                                                        'Democratic Republic of the Congo' ||
                                                    RiskForm.residency.value ==
                                                        'Cayman Islands' ||
                                                    RiskForm.residency.value ==
                                                        'China' ||
                                                    RiskForm.residency.value ==
                                                        'Russia') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                            .residency.value ==
                                                        'Egypt' ||
                                                    RiskForm.residency.value ==
                                                        'Ukraine' ||
                                                    RiskForm.residency.value ==
                                                        'Algeria' ||
                                                    RiskForm.residency.value ==
                                                        'Tunisia' ||
                                                    RiskForm.residency.value ==
                                                        'Pakistan' ||
                                                    RiskForm.residency.value ==
                                                        'Uzbekistan' ||
                                                    RiskForm.residency.value ==
                                                        'Thailand' ||
                                                    RiskForm.residency.value ==
                                                        'Indonesia' ||
                                                    RiskForm.residency.value ==
                                                        'Morocco') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S.of(context).Work,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[2],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.work.value =
                                                          controllers[2].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.work.value =
                                                    controllers[2].text;
                                                if (RiskForm.work.value ==
                                                        'Senior Political' ||
                                                    RiskForm.work.value ==
                                                        'Ruling Family' ||
                                                    RiskForm.work.value ==
                                                        'Judicial' ||
                                                    RiskForm.work.value ==
                                                        'Military' ||
                                                    RiskForm.work.value ==
                                                        'Minister' ||
                                                    RiskForm.work.value ==
                                                        'Self Employed') {
                                                  return Center(
                                                      child: Text("15"));
                                                } else if (RiskForm
                                                        .work.value ==
                                                    'Lawyer') {
                                                  return Center(
                                                      child: Text("7.5"));
                                                } else if (RiskForm
                                                            .work.value ==
                                                        'Student' ||
                                                    RiskForm.work.value ==
                                                        'Retired' ||
                                                    RiskForm.work.value ==
                                                        'Employee') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.work.value ==
                                                        'Senior Political' ||
                                                    RiskForm.work.value ==
                                                        'Ruling Family' ||
                                                    RiskForm.work.value ==
                                                        'Judicial' ||
                                                    RiskForm.work.value ==
                                                        'Military' ||
                                                    RiskForm.work.value ==
                                                        'Minister' ||
                                                    RiskForm.work.value ==
                                                        'Self Employed') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                        .work.value ==
                                                    'Lawyer') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                            .work.value ==
                                                        'Student' ||
                                                    RiskForm.work.value ==
                                                        'Retired' ||
                                                    RiskForm.work.value ==
                                                        'Employee') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .AccountType,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[3],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.account.value =
                                                          controllers[3].text;
                                                      // calulate();
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.account.value =
                                                    controllers[3].text;
                                                if (RiskForm.account.value ==
                                                    'Political') {
                                                  return Center(
                                                      child: Text("15"));
                                                } else if (RiskForm
                                                        .account.value ==
                                                    'Minor') {
                                                  return Center(
                                                      child: Text("7.5"));
                                                } else if (RiskForm
                                                        .account.value ==
                                                    'Employee') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Text("");
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.account.value ==
                                                    'Political') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                        .account.value ==
                                                    'Minor') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                        .account.value ==
                                                    'Employee') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .ClientClassification,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[4],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm
                                                          .clientClassification
                                                          .value = controllers[
                                                              4]
                                                          .text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.clientClassification
                                                        .value =
                                                    controllers[4].text;
                                                if (RiskForm.clientClassification
                                                            .value ==
                                                        'Retail' ||
                                                    RiskForm.clientClassification
                                                            .value ==
                                                        'Qualified') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else if (RiskForm
                                                        .clientClassification
                                                        .value ==
                                                    'Institutional') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text(""));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.clientClassification
                                                            .value ==
                                                        'Retail' ||
                                                    RiskForm.clientClassification
                                                            .value ==
                                                        'Qualified') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
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
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .SourceOfWealth,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[5],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.source.value =
                                                          controllers[5].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.source.value =
                                                    controllers[5].text;
                                                if (RiskForm.source.value ==
                                                        'Salary' ||
                                                    RiskForm.source.value ==
                                                        'Real Estate' ||
                                                    RiskForm.source.value ==
                                                        'Pension') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else if (RiskForm
                                                            .source.value ==
                                                        'Personal Business' ||
                                                    RiskForm.source.value ==
                                                        'Investment' ||
                                                    RiskForm.source.value ==
                                                        'Inheritance' ||
                                                    RiskForm.source.value ==
                                                        'Marketable Securities') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text(""));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.source.value ==
                                                        'Salary' ||
                                                    RiskForm.source.value ==
                                                        'Real Estate' ||
                                                    RiskForm.source.value ==
                                                        'Pension') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                            .source.value ==
                                                        'Personal Business' ||
                                                    RiskForm.source.value ==
                                                        'Investment' ||
                                                    RiskForm.source.value ==
                                                        'Inheritance' ||
                                                    RiskForm.source.value ==
                                                        'Marketable Securities') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .InvestmentKnowledgeAndExperience,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
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
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none),
                                                onChanged: (value) {
                                                  setState(() {
                                                    RiskForm.investmentExp
                                                            .value =
                                                        controllers[6].text;
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.investmentExp.value =
                                                    controllers[6].text;
                                                if (RiskForm
                                                        .investmentExp.value ==
                                                    'High') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else if (RiskForm
                                                            .investmentExp
                                                            .value ==
                                                        'Low' ||
                                                    RiskForm.investmentExp
                                                            .value ==
                                                        'Medium') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text(""));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm
                                                        .investmentExp.value ==
                                                    'High') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                            .investmentExp
                                                            .value ==
                                                        'Low' ||
                                                    RiskForm.investmentExp
                                                            .value ==
                                                        'Medium') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .CustomerAbility,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[7],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.riskAbility
                                                              .value =
                                                          controllers[7].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.riskAbility.value =
                                                    controllers[7].text;
                                                if (RiskForm
                                                        .riskAbility.value ==
                                                    'High') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else if (RiskForm.riskAbility
                                                            .value ==
                                                        'Low' ||
                                                    RiskForm.riskAbility
                                                            .value ==
                                                        'Medium') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text(""));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm
                                                        .riskAbility.value ==
                                                    'High') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm.riskAbility
                                                            .value ==
                                                        'Low' ||
                                                    RiskForm.riskAbility
                                                            .value ==
                                                        'Medium') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Client\'s Investment Objectives",
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[9],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.investmentObj
                                                              .value =
                                                          controllers[9].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.investmentObj.value =
                                                    controllers[9].text;
                                                if (RiskForm.investmentObj
                                                            .value ==
                                                        'Protection Of Capital' ||
                                                    RiskForm.investmentObj
                                                            .value ==
                                                        'Income' ||
                                                    RiskForm.investmentObj
                                                            .value ==
                                                        'Balanced') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else if (RiskForm
                                                        .investmentObj.value ==
                                                    'Growth Of Capital') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text("0"));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.investmentObj
                                                            .value ==
                                                        'Protection Of Capital' ||
                                                    RiskForm.investmentObj
                                                            .value ==
                                                        'Income' ||
                                                    RiskForm.investmentObj
                                                            .value ==
                                                        'Balanced') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                        .investmentObj.value ==
                                                    'Growth Of Capital') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .ClientType,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[8],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.client.value =
                                                          controllers[8].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.client.value =
                                                    controllers[8].text;
                                                if (RiskForm.client.value ==
                                                    'Natural Person') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else if (RiskForm
                                                        .client.value ==
                                                    'Authorized Person') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text(""));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.client.value ==
                                                    'Natural Person') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                        .client.value ==
                                                    'Authorized Person') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .RiskTable11,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[12],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.boardDirector
                                                              .value =
                                                          controllers[12].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.boardDirector.value =
                                                    controllers[12].text;
                                                if (RiskForm
                                                        .boardDirector.value ==
                                                    'Yes') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else if (RiskForm
                                                        .boardDirector.value ==
                                                    'No') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else {
                                                  return Center(
                                                      child: Text(""));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm
                                                        .boardDirector.value ==
                                                    'Yes') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .ApproximateAnnualIncome,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[10],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.annualIncome
                                                              .value =
                                                          controllers[10].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.annualIncome.value =
                                                    controllers[10].text;
                                                if (RiskForm
                                                        .annualIncome.value ==
                                                    'More Than 50,000,000') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else {
                                                  return Center(
                                                      child: Text("5"));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm
                                                        .annualIncome.value ==
                                                    'More Than 50,000,000') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .ApproximateNetWorth,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[11],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.netWorth.value =
                                                          controllers[11].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.netWorth.value =
                                                    controllers[11].text;
                                                if (RiskForm.netWorth.value ==
                                                    'More Than 50,000,000') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else {
                                                  return Center(
                                                      child: Text("5"));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.netWorth.value ==
                                                    'More Than 50,000,000') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .RiskTable14,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[13],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.investing.value =
                                                          controllers[13].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.investing.value =
                                                    controllers[13].text;
                                                if (RiskForm.investing.value ==
                                                    'Less Than 5 Million') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else if (RiskForm
                                                        .investing.value ==
                                                    'More Than 5 Million') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text(""));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.investing.value ==
                                                    'Less Than 5 Million') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                        .investing.value ==
                                                    'More Than 5 Million') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .RiskTable15,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[14],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.owner.value =
                                                          controllers[14].text;
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.owner.value =
                                                    controllers[14].text;
                                                if (RiskForm.owner.value ==
                                                    'Yes') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else if (RiskForm
                                                        .owner.value ==
                                                    'No') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text(""));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.owner.value ==
                                                    'Yes') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm
                                                        .owner.value ==
                                                    'No') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                  height: 40,
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .RiskTable16,
                                                        style: TextController
                                                            .BodyText,
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
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                  readOnly: true,
                                                  textAlign: TextAlign.center,
                                                  controller: controllers[15],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      RiskForm.pep.value =
                                                          controllers[15]
                                                                      .text ==
                                                                  ""
                                                              ? "No"
                                                              : "Yes";
                                                      controllers[15].text =
                                                          controllers[15]
                                                                      .text ==
                                                                  ""
                                                              ? "No"
                                                              : "Yes";
                                                    });
                                                  }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                RiskForm.pep.value =
                                                    controllers[15].text == ""
                                                        ? "No"
                                                        : "Yes";
                                                if (RiskForm.pep.value ==
                                                    'Yes') {
                                                  return Center(
                                                      child: Text("2.5"));
                                                } else if (RiskForm.pep.value ==
                                                    'No') {
                                                  return Center(
                                                      child: Text("5"));
                                                } else {
                                                  return Center(
                                                      child: Text(""));
                                                }
                                              }),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (RiskForm.pep.value ==
                                                    'Yes') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                } else if (RiskForm.pep.value ==
                                                    'No') {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.yellow,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                  ));
                                                }
                                              }),
                                            ),
                                          ]),
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
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
                                              child:
                                                  Center(child: Text('$total')),
                                            ),
                                            Container(
                                              height: 40,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (total < 65) {
                                                  return Center(
                                                      child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                    child: Center(
                                                      child: Text(
                                                        "Low Risk",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                    child: Center(
                                                      child: Text(
                                                        "Medium Risk",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                            BorderRadius
                                                                .circular(50)
                                                        //more than 50% of width makes circle
                                                        ),
                                                    child: Center(
                                                      child: Text(
                                                        "High Risk",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                  ],
                                ),
                                SizedBox(
                                  height: 100,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect
                                                    .tabBorderColor)),
                                        child: TextButton(
                                          onPressed: () {}, // Switch tabs
                                          child: Text(
                                            S.of(context).Reject,
                                            style: TextController.SideMenuText,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: ColorSelect.east_blue,
                                            border: Border.all(
                                                color: ColorSelect
                                                    .tabBorderColor)),
                                        child: TextButton(
                                          onPressed: () async {
                                            if (RiskForm.send.value == false) {
                                              var color = "Green";
                                              if (total > 66 && total < 75) {
                                                color = "Yellow";
                                              } else if (total >= 75) {
                                                color = "Red";
                                              }
                                              bool x = await GlobalPermission
                                                  .formApproval(
                                                      "Risk Assesment",
                                                      RiskForm.clientID.value,
                                                      RiskForm.clientName
                                                              .value +
                                                          "-" +
                                                          total.toString() +
                                                          "-" +
                                                          color +
                                                          "-" +
                                                          "Individual",
                                                      0);
                                              if (x == true) {
                                                Fluttertoast.showToast(
                                                    msg: "Sent For Approval",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.CENTER,
                                                    timeInSecForIosWeb: 3,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                              RiskForm.send.value = true;
                                            }
                                          }, // Switch tabs
                                          child: Text(
                                            S.of(context).Approve,
                                            style: TextController.btnText,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        height: 35,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: ColorSelect.east_blue,
                                            border: Border.all(
                                                color: ColorSelect
                                                    .tabBorderColor)),
                                        child: TextButton(
                                          onPressed: () {
                                            register();
                                          }, // Switch tabs
                                          child: Text(
                                            S.of(context).Save,
                                            style: TextController.btnText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
