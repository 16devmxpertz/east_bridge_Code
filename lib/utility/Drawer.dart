// import 'package:east_bridge/utility/Colors.dart';
// import 'package:flutter/material.dart';
// import 'package:east_bridge/generated/l10n.dart';
// import 'package:east_bridge/utility/TextController.dart';
// import 'package:flutter_simple_treeview/flutter_simple_treeview.dart';


// class NavDrawer extends StatefulWidget {
//   const NavDrawer({Key? key}) : super(key: key);

//   @override
//   State<NavDrawer> createState() => _NavDrawer();
// }

// class _NavDrawer extends State<NavDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top:160),
//       child: SizedBox(
//         width: 300,
//         child: Drawer(
//           child: ListView(
//             children:[
//               TreeView(
//               nodes: [

//                 //Dashboard
//                 TreeNode(
//                   content: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Icon(Icons.bar_chart,color: ColorSelect.bodytext,size: 25,),
//                   SizedBox(
//                     width: 30,
//                   ),
//                   Text(S.of(context).Dashboard,style: TextController.SideMenuText,),
//               ],
//             ),
//                   children: [
//                     TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                     TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                   ]
//                 ),

//                 //organization
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.balance_rounded,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).Organization,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //kyc
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.people,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).KYC,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).KYCForm,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Individual,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Institutional,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //funds
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.monetization_on_outlined,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).Funds,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //onboarding
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.handshake,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).Organization,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //contracts
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.contacts_outlined,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).Contracts,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //transfers
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.transfer_within_a_station_outlined,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).Transfer,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //reports
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.event_note_sharp,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).Reports,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //investment
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.auto_graph_outlined,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).Investment,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //account
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.account_balance,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).AccountDetails,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //portfolio
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.person_add_alt_1,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).PortfolioManagement,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                //profile
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.people_alt_outlined,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).Profile,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //invoice
//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.money_outlined,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).Invoice,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 TreeNode(
//                     content: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(Icons.logout,color: ColorSelect.bodytext,size: 25,),
//                         SizedBox(
//                           width: 30,
//                         ),
//                         Text(S.of(context).SignOut,style: TextController.SideMenuText,),
//                       ],
//                     ),
//                     children: [
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),),
//                       TreeNode(content: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),)
//                     ]
//                 ),

//                 //profile
//               ],
//             ),
//       ],
//           ),
//         )

//         /*Drawer(
//           child: ListView(
//             children: [
//               ExpansionTile(
//                 title: Text(S.of(context).Dashboard,style: TextController.SideMenuText,),
//                 children: [
//                   ListTile(
//                     title: Text(S.of(context).Dashboard, style: TextController.SideMenuText,),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),*/
//       ),
//     );
//   }
// }
