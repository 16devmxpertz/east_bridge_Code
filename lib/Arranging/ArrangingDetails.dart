import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:east_bridge/Arranging/ArrangingCreation.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';

class ListFieldFormBloc {
  final TextEditingController clubNameController = TextEditingController();
  final List<MemberFieldBloc> members = [];

  void addMember() {
    members.add(MemberFieldBloc());
  }

  void removeMember(int index) {
    members.removeAt(index);
  }

  void addHobbyToMember(int memberIndex) {
    members[memberIndex].hobbies.add(TextEditingController());
  }

  void removeHobbyFromMember(
      {required int memberIndex, required int hobbyIndex}) {
    members[memberIndex].hobbies.removeAt(hobbyIndex);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clubName'] = clubNameController.text;
    data['members'] = members.map((member) => member.toJson()).toList();
    return data;
  }

  void onSubmitting() {
    final clubV2 = Club.fromJson(toJson());

    debugPrint('clubV2');
    debugPrint(clubV2.toJson().toString());

    // Process your data here
  }

  
}

class MemberFieldBloc {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final List<TextEditingController> hobbies = [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstNameController.text;
    data['lastName'] = lastNameController.text;
    data['hobbies'] = hobbies.map((hobby) => hobby.text).toList();
    return data;
  }
}

class Club {
  String? clubName;
  List<Member>? members;

  Club({this.clubName, this.members});

  Club.fromJson(Map<String, dynamic> json) {
    clubName = json['clubName'];
    if (json['members'] != null) {
      members = <Member>[];
      json['members'].forEach((v) {
        members!.add(Member.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clubName'] = clubName;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() => '''Club {
  clubName: $clubName,
  members: $members
}''';
}

class Member {
  String? firstName;
  String? lastName;
  List<String?>? hobbies;

  Member({this.firstName, this.lastName, this.hobbies});

  Member.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    hobbies = json['hobbies'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['hobbies'] = hobbies;
    return data;
  }

  @override
  String toString() => '''Member {
  firstName: $firstName,
  lastName: $lastName,
  hobbies: $hobbies
}''';
}

const IconData circleIcon = const IconData(0xe163, fontFamily: 'MaterialIcons');

class ArrangingDetailss extends StatefulWidget {
  ArrangingDetailss({@required controller}) {
    tabController = controller;
  }
  // const ArrangingDetailss({Key? key}) : super(key: key);

  @override
  _ArrangingDetailssState createState() => _ArrangingDetailssState();
    static ValueNotifier<int> id = new ValueNotifier(0);

}

class _ArrangingDetailssState extends State<ArrangingDetailss> {
  final ListFieldFormBloc formBloc = ListFieldFormBloc();
  var dio = Dio();

 void addmilestone() async {
    final clubV2 = Club.fromJson(formBloc.toJson());


print(clubV2);
List<String> lastNameList = clubV2.members?.map((member) => member.lastName ?? '').toList() ?? [];

  print(formBloc.members);
   FormData data = FormData.fromMap({
 "ArrangingId":ArrangingDetailss.id.value,
          "lastNames":lastNameList
   });
  

      try {
      

        print(data);
         var response = await dio.post(
        "https://localhost:44323/api/ArrangingMileStone/ArrangingMileStroneCreation/",
        data: data,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
        if (response.statusCode == 200) {
          print(jsonDecode(response.data));
          // id = int.parse(response.body);
          // print("Successfull");
          // print(id);
          // return id;
        } else {
          print(response.statusCode);
          print("Error========");
          // Request failed, handle the error
      
          print(response.statusCode);
          print(response.data);
          print(jsonDecode(response.data));
          print("Error");
        }
      } catch (e) {
        print(e.toString());
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     formBloc.onSubmitting();
      //   },
      //   child: const Icon(Icons.send),
      // ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(50),
                  child: Text(
                    "Add MileStones",
                    style: TextController.SubHeadingText.copyWith(fontSize: 20),
                  )),
              // TextField(
              //   controller: formBloc.clubNameController,
              //   decoration: const InputDecoration(
              //     labelText: 'Arranging Services',
              //     prefixIcon: Icon(Icons.sentiment_satisfied),
              //   ),
              // ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: formBloc.members.length,
                itemBuilder: (context, i) {
                  return MemberCard(
                    memberIndex: i,
                    memberField: formBloc.members[i],
                    onRemoveMember: () =>
                        setState(() => formBloc.removeMember(i)),
                    onAddHobby: () =>
                        setState(() => formBloc.addHobbyToMember(i)),
                    onRemoveHobby: (hobbyIndex) => setState(() =>
                        formBloc.removeHobbyFromMember(
                            memberIndex: i, hobbyIndex: hobbyIndex)),
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 35,
                  width: 140,
                  decoration: BoxDecoration(
                    color: ColorSelect.east_blue,
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        formBloc.addMember();
                      });
                    }, // Switch tabs
                    child: Text(
                      'ADD Services', // You can replace 'ADD Services' with your desired button text.
                      style: TextController.btnText,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
                    onPressed: () {
                      setState(() {
                        formBloc.onSubmitting();
                        addmilestone();
                        tabController!.animateTo(2);
                      });
                    }, // Switch tabs
                    child: Text(
                     S.of(context).Next, // You can replace 'ADD Services' with your desired button text.
                      style: TextController.btnText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final int memberIndex;
  final MemberFieldBloc memberField;

  final VoidCallback onRemoveMember;
  final VoidCallback onAddHobby;

  const MemberCard({
    Key? key,
    required this.memberIndex,
    required this.memberField,
    required this.onRemoveMember,
    required this.onAddHobby,
    required void Function(dynamic hobbyIndex) onRemoveHobby,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorSelect.east_grey,
      borderOnForeground:
          true, // This ensures the border is displayed in front of the card's child
      shape: RoundedRectangleBorder(
        // The border shape can be changed here (e.g., BeveledRectangleBorder, StadiumBorder, etc.)
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
            color: ColorSelect.textField,
            width: 0.5), // Set border color and width
      ),
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(children: [
                  Icon(
                    circleIcon, // Use the custom IconData here
                    size: 12.0,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Milestone ${memberIndex + 1}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ]),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onRemoveMember,
                ),
              ],
            ),
            Container(
              height: 35,
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ColorSelect.textField),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 10),
                child: TextField(
                  controller: memberField.lastNameController,
                  decoration: InputDecoration(
                    hintText: 'Type Here',
                    hintStyle: TextController.BodyTextCC,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
