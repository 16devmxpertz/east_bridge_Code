// import 'package:east_bridge/generated/intl/messages_all.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class AppLocalizations {
//   static const supportedLocales = [Locale('en', 'US'), Locale('ar', 'SA')];

//   // Rest of your AppLocalizations class...

//   // Function to change the app's locale
//   static Future<void> changeLocale(BuildContext context, Locale locale) async {
//     final savedLocale = Intl.defaultLocale;

//     if (supportedLocales.contains(locale)) {
//       Intl.defaultLocale = locale.toString();
//     } else {
//       Intl.defaultLocale =
//           'en_US'; // Fallback to English if the locale is not supported
//     }

//     await initializeMessages(Intl.defaultLocale!);
//     AppLocalizations.of(context);
//     Intl.defaultLocale = savedLocale;
//   }
// // }
