import 'package:east_bridge/Advisory/Advisory%20Subscribe/AdvisorySubscribe.dart';
import 'package:east_bridge/Log%20In/Login.dart';
import 'package:east_bridge/User%20Management/UserManagement.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'KYC/KYC Components/cscpickerstate.dart';
import 'KYC/KYC Components/newInd.dart';
import 'generated/l10n.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CSCSelectionProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'East Bridge',
          theme: ThemeData.light().copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Colors.black,
              ),
              colorScheme: ColorScheme.light(primary: ColorSelect.east_blue),
              radioTheme: RadioThemeData(
                fillColor:
                    MaterialStateProperty.all<Color>(ColorSelect.east_blue),
              ),
              checkboxTheme: CheckboxThemeData(
                // checkColor:
                //     MaterialStateProperty.all<Color>(ColorSelect.east_blue),
                fillColor:
                    MaterialStateProperty.all<Color>(ColorSelect.east_blue),
              )
              // buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    // final delegate=S.of(context);

    return Scaffold(
      backgroundColor: Colors.white,

      // body: POAKYC(),
      //body: newInd(),
      // body: POAKYC(),
      // body: UserManagement(),
      // body: FundSelecion(),
      // body: Logins(),
      // body: ForgotPassword(),
      // body: Varification(),
      // body: Otp(),
      // body: SignUps(),
      // body: Demo(),
      // body: UserDashboard(),
      // body: AdminDashBoard(),
      // body: RiskForm(),
      // body: Responsive(
      //   desktopbody: DesktopDashboard(),
      //   mobilebody: MobileDashboard(),

      // ),
      // body: POAKYC(""),
      // body:TabOfArranging(),
      // body: InvestmentPortfolioBCorporate(),
      //body: TempletSelection(),
      // body: CustomerFundAgreement(),
      // body: FundSubscribe(),
      // body: Logins(),
      // body: Logins(),
      body: Logins(),
      // body: UserManagement(),
      // body: AdvisorySubscribes(),
      //body: newInd(""),
      // body: TabOfFundCreation(),
      // body: SignUps(),
      // body: IndividualKYCN(),
      // body: AdvisoryDefaultdatalanaAgreement(),
      // body: ServiceFormScreen(),
      // body: FATCA(),
      // body: FundReedem(),
      // body: KYCPdfUploadIND(),
    );
  }
}
