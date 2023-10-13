import 'package:east_bridge/KYC/KYC%20Components/DatePicker.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';

enum SingingCharacter { yes, no }
class ClientDeclaration extends StatefulWidget {
  const ClientDeclaration({Key? key}) : super(key: key);

  @override
  State<ClientDeclaration> createState() => _ClientDeclarationState();
}

class _ClientDeclarationState extends State<ClientDeclaration>  {

  bool? isChecked=false;
  @override
  Widget build(BuildContext context) {

    TextEditingController _firstName=new TextEditingController();
    TextEditingController _secondName=new TextEditingController();
    TextEditingController _thirdName=new TextEditingController();
    TextEditingController _fourthName=new TextEditingController();
    TextEditingController _fatherName=new TextEditingController();
    TextEditingController _grandfatherName=new TextEditingController();
    TextEditingController _numDependents=new TextEditingController();
    TextEditingController dateController=new TextEditingController();





    SingingCharacter? _character = SingingCharacter.yes;
    int? selectedValue=1;

    String dropdownvalue;

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    // @override
    // void initState(){
    //   super.initState();
    //   dateController.text=" ";
    // }

    return Container(
      height: 470,
      color: Colors.white,
      child: Scaffold(
        body: Container(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 40),
                child: Container(

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          Text(S.of(context).ClientName,style: TextController.BodyText,),
                          SizedBox(
                            width: 30,
                          ),

                          Container(
                            width: 270,
                            height: 35,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: ColorSelect.textField
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15,bottom: 10),
                              child: TextFormField(
                                controller: _firstName,
                                decoration: InputDecoration(
                                    hintText: S.of(context).TypeHere,
                                    hintStyle:TextController.labelText,
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),

                          Text(S.of(context).Date,style: TextController.BodyText,),
                          SizedBox(
                            width: 30,
                          ),

                          DatePicker(),
                          SizedBox(
                            width: 30,
                          ),

                          DatePicker(),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        height: 150,
                        width: 1500,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorSelect.tabBorderColor
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Align(alignment:Alignment.centerLeft,child: Text(S.of(context).ComplianceApproval,style: TextController.SubHeadingText,)),
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(S.of(context).Name,style: TextController.BodyText,),
                                  SizedBox(
                                    width: 30,
                                  ),


                                  Container(
                                    width: 270,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15,bottom: 10),
                                      child: TextFormField(
                                        controller: _firstName,
                                        decoration: InputDecoration(
                                            hintText: S.of(context).TypeHere,
                                            hintStyle:TextController.labelText,
                                            border: InputBorder.none
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),

                                  Text(S.of(context).Date,style: TextController.BodyText,),
                                  SizedBox(
                                    width: 30,
                                  ),

                                  DatePicker(),
                                  SizedBox(
                                    width: 30,
                                  ),

                                  DatePicker(),
                                ],
                              ),


                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: isChecked,
                                  onChanged: (val){
                                    setState(() {
                                      isChecked=val;
                                    });
                                  }
                              ),
                              Text(S.of(context).Terms,style: TextController.BodyHeadingText,)
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 50,top: 80),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 35,
                            width: 140,
                            decoration: BoxDecoration(
                                color: ColorSelect.east_blue,
                                border: Border.all(
                                    color: ColorSelect.tabBorderColor
                                )
                            ),
                            child: TextButton(
                              onPressed:(){}, // Switch tabs
                              child: Text(S.of(context).Submit,style: TextController.btnText,),
                            ),
                          ),
                        ),
                      ),



                    ],
                  ),
                ),
              ),
            )
        ),
      ),

    );
  }
}