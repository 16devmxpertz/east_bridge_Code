// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `East Bridge`
  String get appTitle {
    return Intl.message(
      'East Bridge',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  //PostalCode
  String get PostalCode {
    return Intl.message(
      'Postal Code',
      name: 'Postal Code',
      desc: '',
      args: [],
    );
  }

  String get Transaction {
    return Intl.message(
      'Transaction',
      name: 'Transaction',
      desc: '',
      args: [],
    );
  }

  String get AdvisoryActivityUpdate {
    return Intl.message(
      'Advisory Activity Update',
      name: 'AdvisoryActivityUpdate',
      desc: '',
      args: [],
    );
  }

  String get ExpenseTracker {
    return Intl.message(
      'Expense Tracker',
      name: 'ExpenseTracker',
      desc: '',
      args: [],
    );
  }

  String get AdvisoryServiceInitiation {
    return Intl.message(
      'Advisory Service Initiation',
      name: 'AdvisoryServiceInitiation',
      desc: '',
      args: [],
    );
  }

  String get ServiceStart {
    return Intl.message(
      'Service Start',
      name: 'ServiceStart',
      desc: '',
      args: [],
    );
  }

  String get ServiceInitiation {
    return Intl.message(
      'Service Initiation',
      name: 'ServiceInitiation',
      desc: '',
      args: [],
    );
  }

  String get Operation {
    return Intl.message(
      "Operation",
      name: 'Operation',
      desc: '',
      args: [],
    );
  }

  String get Compliance {
    return Intl.message(
      'Compliance',
      name: 'Compliance',
      desc: '',
      args: [],
    );
  }

  // String get Operation {
  //   return Intl.message(
  //     "Operation",
  //     name: 'Operation',
  //     desc: '',
  //     args: [],
  //   );
  // }

  // String get Compliance {
  //   return Intl.message(
  //     'Compliance',
  //     name: 'Compliance',
  //     desc: '',
  //     args: [],
  //   );
  // }

  String get Setup {
    return Intl.message(
      'Setup',
      name: 'Setup',
      desc: '',
      args: [],
    );
  }

  String get GenerateInvoice {
    return Intl.message(
      'Generate Invoice',
      name: 'GenerateInvoice',
      desc: '',
      args: [],
    );
  }

  String get OrganizationalSetting {
    return Intl.message(
      'Organizational Setting',
      name: 'OrganizationalSetting',
      desc: '',
      args: [],
    );
  }

  String get Master {
    return Intl.message(
      'Master',
      name: 'Master',
      desc: '',
      args: [],
    );
  }

  String get UserAuthentication {
    return Intl.message(
      'User Authentication',
      name: 'UserAuthentication',
      desc: '',
      args: [],
    );
  }

  String get ActivityUpdate {
    return Intl.message(
      'Activity Update',
      name: 'ActivityUpdate',
      desc: '',
      args: [],
    );
  }

  String get AdvisoryTemplate {
    return Intl.message(
      'Advisory Template',
      name: 'AdvisoryTemplate',
      desc: '',
      args: [],
    );
  }

  String get MileStoneFees {
    return Intl.message(
      'MileStone Fees',
      name: 'MileStoneFees',
      desc: '',
      args: [],
    );
  }

  String get scopeOfWorkTitle {
    return Intl.message(
      'Scope Of Work Title',
      name: 'scopeOfWorkTitle',
      desc: '',
      args: [],
    );
  }

  String get GIIN {
    return Intl.message(
      'GIIN',
      name: 'GIIN',
      desc: '',
      args: [],
    );
  }

  String get USTIN {
    return Intl.message(
      'US TIN',
      name: 'USTIN',
      desc: '',
      args: [],
    );
  }

  //Duration
  String get Duration {
    return Intl.message(
      'Duration',
      name: 'Duration',
      desc: '',
      args: [],
    );
  }

  //Period
  String get Period {
    return Intl.message(
      'Period',
      name: 'Period',
      desc: '',
      args: [],
    );
  }

  //AgreementAddUpdateDelete
  String get AgreementAddUpdateDelete {
    return Intl.message(
      'Agreement Setup',
      name: 'AgreementAddUpdateDelete',
      desc: '',
      args: [],
    );
  }

  //CalculatedAmount
  String get CalculatedAmount {
    return Intl.message(
      'Calculated Amount',
      name: 'CalculatedAmount',
      desc: '',
      args: [],
    );
  }

  //ApprovalScreen
  String get ApprovalScreen {
    return Intl.message(
      'Approval Screen',
      name: 'ApprovalScreen',
      desc: '',
      args: [],
    );
  }

  //ServiceEnd
  String get ServiceEnd {
    return Intl.message(
      'Service End',
      name: 'ServiceEnd',
      desc: '',
      args: [],
    );
  }

  //LinkAgreementwithCustomer
  String get LinkAgreementwithCustomer {
    return Intl.message(
      'Link Agreement with Customer',
      name: 'LinkAgreementwithCustomer',
      desc: '',
      args: [],
    );
  }

  //ServiceFeesType
  String get ServiceFeesType {
    return Intl.message(
      'Service Fees Type',
      name: 'ServiceFeesType',
      desc: '',
      args: [],
    );
  }

  //ValueOfService
  String get ValueOfService {
    return Intl.message(
      'Value Of Service',
      name: 'ValueOfService',
      desc: '',
      args: [],
    );
  }

  //DurationofAdvisory
  String get DurationofAdvisory {
    return Intl.message(
      'Duration of\nAdvisory',
      name: 'DurationofAdvisory',
      desc: '',
      args: [],
    );
  }

  //NewAgreement
  String get NewAgreement {
    return Intl.message(
      'New Agreement',
      name: 'New Agreement',
      desc: '',
      args: [],
    );
  }

  //Advisory
  String get Advisory {
    return Intl.message(
      'Advisory',
      name: 'Advisory',
      desc: '',
      args: [],
    );
  }

  //Arranging
  String get Arranging {
    return Intl.message(
      'Arranging',
      name: 'Arranging',
      desc: '',
      args: [],
    );
  }

  //Agreement
  String get Agreement {
    return Intl.message(
      'Agreement',
      name: 'Agreement',
      desc: '',
      args: [],
    );
  }

  //
  String get Fund {
    return Intl.message(
      'Fund',
      name: 'Fund',
      desc: '',
      args: [],
    );
  }

  //
  String get customerAgreement {
    return Intl.message(
      'Customer Agreement',
      name: 'Customer Agreement',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get Logout {
    return Intl.message(
      'Log out',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get New {
    return Intl.message(
      'New',
      name: 'New',
      desc: '',
      args: [],
    );
  }

  //AdvisoryCreation
  String get AdvisoryCreation {
    return Intl.message(
      'Advisory Creation',
      name: 'AdvisoryCreation ',
      desc: '',
      args: [],
    );
  }

  String get AdvisoryServiceCreations {
    return Intl.message(
      'Advisory Service \n\nCreation',
      name: 'AdvisoryServiceCreatio',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get View {
    return Intl.message(
      'View',
      name: 'View',
      desc: '',
      args: [],
    );
  }

  String get EmailId {
    return Intl.message(
      'Email Id',
      name: 'EmailId',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get Edit {
    return Intl.message(
      'Edit',
      name: 'Edit',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get Print {
    return Intl.message(
      'Print',
      name: 'Print',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get Download {
    return Intl.message(
      'Download',
      name: 'Download',
      desc: '',
      args: [],
    );
  }

  /// `Save Draft`
  String get SaveDraft {
    return Intl.message(
      'Save Draft',
      name: 'SaveDraft',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get Dashboard {
    return Intl.message(
      'Dashboard',
      name: 'Dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Organization`
  String get Organization {
    return Intl.message(
      'Organization',
      name: 'Organization',
      desc: '',
      args: [],
    );
  }

  /// `KYC`
  String get KYC {
    return Intl.message(
      'KYC',
      name: 'KYC',
      desc: '',
      args: [],
    );
  }

  /// `Onboarding`
  String get Onboarding {
    return Intl.message(
      'Onboarding',
      name: 'Onboarding',
      desc: '',
      args: [],
    );
  }

  /// `Contracts`
  String get Contracts {
    return Intl.message(
      'Contracts',
      name: 'Contracts',
      desc: '',
      args: [],
    );
  }

  /// `Transfer`
  String get Transfer {
    return Intl.message(
      'Transfer',
      name: 'Transfer',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get Reports {
    return Intl.message(
      'Reports',
      name: 'Reports',
      desc: '',
      args: [],
    );
  }

  /// `Investment`
  String get Investment {
    return Intl.message(
      'Investment',
      name: 'Investment',
      desc: '',
      args: [],
    );
  }

  /// `Account Details`
  String get AccountDetails {
    return Intl.message(
      'Account Details',
      name: 'AccountDetails',
      desc: '',
      args: [],
    );
  }

  /// `PortfolioManagement`
  String get PortfolioManagement {
    return Intl.message(
      'PortfolioManagement',
      name: 'PortfolioManagement',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get Invoice {
    return Intl.message(
      'Invoice',
      name: 'Invoice',
      desc: '',
      args: [],
    );
  }

  String get DPMInvoice {
    return Intl.message(
      'DPM Invoice',
      name: 'DPMInvoice',
      desc: '',
      args: [],
    );
  }

  String get CompanyDetails {
    return Intl.message(
      'Company Details',
      name: 'CompanyDetails',
      desc: '',
      args: [],
    );
  }

  String get ExpenseBooking {
    return Intl.message(
      'Expense Booking',
      name: 'ExpenseBooking',
      desc: '',
      args: [],
    );
  }

  String get FundInvoice {
    return Intl.message(
      'Fund Invoice ',
      name: 'FundInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get SignOut {
    return Intl.message(
      'Sign out',
      name: 'SignOut',
      desc: '',
      args: [],
    );
  }

  /// `Funds`
  String get Funds {
    return Intl.message(
      'Funds',
      name: 'Funds',
      desc: '',
      args: [],
    );
  }

  /// `KYC Form`
  String get KYCForm {
    return Intl.message(
      'KYC Form',
      name: 'KYCForm',
      desc: '',
      args: [],
    );
  }

  /// `Individual`
  String get Individual {
    return Intl.message(
      'Individual',
      name: 'Individual',
      desc: '',
      args: [],
    );
  }

  /// `Institutional`
  String get Institutional {
    return Intl.message(
      'Institutional',
      name: 'Institutional',
      desc: '',
      args: [],
    );
  }

  /// `Know Your Client`
  String get UserManagement {
    return Intl.message(
      'User Management',
      name: 'UserManagement',
      desc: '',
      args: [],
    );
  }

  /// `Know Your Client`
  String get KnowYourClient {
    return Intl.message(
      'Know Your Client',
      name: 'KnowYourClient',
      desc: '',
      args: [],
    );
  }

  /// `(Individual Account)`
  String get IndividualAccount {
    return Intl.message(
      '(Individual Account)',
      name: 'IndividualAccount',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get AddUser {
    return Intl.message(
      'Add User',
      name: 'AddUser',
      desc: '',
      args: [],
    );
  }

  String get Permission {
    return Intl.message(
      'Permission',
      name: 'Permission',
      desc: '',
      args: [],
    );
  }

  String get PersonalInformation {
    return Intl.message(
      'Personal Information',
      name: 'PersonalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Client Classification`
  String get ClientClassification {
    return Intl.message(
      'Client Classification',
      name: 'ClientClassification',
      desc: '',
      args: [],
    );
  }

  /// `Postal Address`
  String get PostalAddress {
    return Intl.message(
      'Postal Address',
      name: 'PostalAddress',
      desc: '',
      args: [],
    );
  }

  /// `Income and Net Worth`
  String get NetWorth {
    return Intl.message(
      'Income and Net Worth',
      name: 'NetWorth',
      desc: '',
      args: [],
    );
  }

  /// `Employer Information`
  String get EmployerInformation {
    return Intl.message(
      'Employer Information',
      name: 'EmployerInformation',
      desc: '',
      args: [],
    );
  }

  /// `Bank Information`
  String get BankInformation {
    return Intl.message(
      'Bank Information',
      name: 'BankInformation',
      desc: '',
      args: [],
    );
  }

  /// `Professional Experience`
  String get ProfessionalExperience {
    return Intl.message(
      'Professional Experience',
      name: 'ProfessionalExperience',
      desc: '',
      args: [],
    );
  }

  /// `General Information`
  String get GeneralInformation {
    return Intl.message(
      'General Information',
      name: 'GeneralInformation',
      desc: '',
      args: [],
    );
  }

  /// `Custodian Information`
  String get CustodianInformation {
    return Intl.message(
      'Custodian Information',
      name: 'CustodianInformation',
      desc: '',
      args: [],
    );
  }

  /// `Investment Portfolio A`
  String get InvestmentPortfolioA {
    return Intl.message(
      'Investment Portfolio A',
      name: 'InvestmentPortfolioA',
      desc: '',
      args: [],
    );
  }

  /// `Investment Portfolio B`
  String get InvestmentPortfolioB {
    return Intl.message(
      'Investment Portfolio B',
      name: 'InvestmentPortfolioB',
      desc: '',
      args: [],
    );
  }

  /// `FATCA & CRS`
  String get Fatca {
    return Intl.message(
      'FATCA & CRS',
      name: 'Fatca',
      desc: '',
      args: [],
    );
  }

  /// `Document Upload`
  String get DocumentUpload {
    return Intl.message(
      'Document Upload',
      name: 'DocumentUpload',
      desc: '',
      args: [],
    );
  }

  /// `Client's Declaration`
  String get ClientDeclaration {
    return Intl.message(
      'Client\'s Declaration',
      name: 'ClientDeclaration',
      desc: '',
      args: [],
    );
  }

  /// `Type Here...`
  String get TypeHere {
    return Intl.message(
      'Type Here...',
      name: 'TypeHere',
      desc: '',
      args: [],
    );
  }

  String get descibeHere {
    return Intl.message(
      'Descibe Here....',
      name: 'descibeHere',
      desc: '',
      args: [],
    );
  }

  String get inDays {
    return Intl.message(
      'in Days',
      name: 'inDays',
      desc: '',
      args: [],
    );
  }

  /// `Client Name`
  String get ClientName {
    return Intl.message(
      'Client Name',
      name: 'ClientName',
      desc: '',
      args: [],
    );
  }

  /// `(In Accordance With Identification Document)`
  String get InAccordance {
    return Intl.message(
      '(In Accordance With Identification Document)',
      name: 'InAccordance',
      desc: '',
      args: [],
    );
  }

  String get InAccordancen {
    return Intl.message(
      '(In accordance with identification document)',
      name: 'InAccordancen',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get FullName {
    return Intl.message(
      'Full Name',
      name: 'FullName',
      desc: '',
      args: [],
    );
  }

  /// `Father Name`
  String get FatherName {
    return Intl.message(
      'Father Name',
      name: 'FatherName',
      desc: '',
      args: [],
    );
  }

  /// `Grand Father Name`
  String get GrandFatherName {
    return Intl.message(
      'Grand Father Name',
      name: 'GrandFatherName',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Dependents`
  String get NumberOfDependents {
    return Intl.message(
      'Number Of Dependents',
      name: 'NumberOfDependents',
      desc: '',
      args: [],
    );
  }

  String get NumberOfDependentsn {
    return Intl.message(
      'Number of dependents',
      name: 'NumberOfDependentsn',
      desc: '',
      args: [],
    );
  }

  /// `Citizenship`
  String get Citizenship {
    return Intl.message(
      'Citizenship',
      name: 'Citizenship',
      desc: '',
      args: [],
    );
  }

  /// `Holder Of Another Citizenship ?`
  String get Holder {
    return Intl.message(
      'Holder Of Another Citizenship ?',
      name: 'Holder',
      desc: '',
      args: [],
    );
  }

  String get Holdern {
    return Intl.message(
      'Holder of another Citizenship ?',
      name: 'Holdern',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get Yes {
    return Intl.message(
      'Yes',
      name: 'Yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get No {
    return Intl.message(
      'No',
      name: 'No',
      desc: '',
      args: [],
    );
  }

  /// `Marital Status`
  String get MaritalStatus {
    return Intl.message(
      'Marital Status',
      name: 'MaritalStatus',
      desc: '',
      args: [],
    );
  }

  /// `ID Type`
  String get IDType {
    return Intl.message(
      'ID Type',
      name: 'IDType',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get Gender {
    return Intl.message(
      'Gender',
      name: 'Gender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get Male {
    return Intl.message(
      'Male',
      name: 'Male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get Female {
    return Intl.message(
      'Female',
      name: 'Female',
      desc: '',
      args: [],
    );
  }

  /// `Select Here...`
  String get SelectHere {
    return Intl.message(
      'Select Here...',
      name: 'SelectHere',
      desc: '',
      args: [],
    );
  }

  /// `Define`
  String get Define {
    return Intl.message(
      'Define',
      name: 'Define',
      desc: '',
      args: [],
    );
  }

  /// `Saudi ID Expiry Date`
  String get SaudiIDExpiryDate {
    return Intl.message(
      'Saudi ID Expiry Date',
      name: 'SaudiIDExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Iqama ID Expiry Date`
  String get IqamaIDExpiryDate {
    return Intl.message(
      'Iqama ID Expiry Date',
      name: 'IqamaIDExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Passport Expiry Date`
  String get PassportExpiryDate {
    return Intl.message(
      'Passport Expiry Date',
      name: 'PassportExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `dd / mm / yyyy`
  String get DateFormat {
    return Intl.message(
      'dd / mm / yyyy',
      name: 'DateFormat',
      desc: '',
      args: [],
    );
  }

  //AdvisoryManagerName
  String get AdvisoryManagerName {
    return Intl.message(
      'Advisory Manager Name',
      name: 'AdvisoryManagerName',
      desc: '',
      args: [],
    );
  }

  //AdvisoryManager
  String get AdvisoryManager {
    return Intl.message(
      'Advisory Manager',
      name: 'AdvisoryManager',
      desc: '',
      args: [],
    );
  }

  //AdvisoryManagerId
  String get AdvisoryManagerId {
    return Intl.message(
      'Advisory Manager Id',
      name: 'AdvisoryManagerId',
      desc: '',
      args: [],
    );
  }

  /// `Diplomatic ID Expiry Date`
  String get DiplomaticIDExpiryDate {
    return Intl.message(
      'Diplomatic ID Expiry Date',
      name: 'DiplomaticIDExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `ID Number`
  String get IDNumber {
    return Intl.message(
      'ID Number',
      name: 'IDNumber',
      desc: '',
      args: [],
    );
  }

  /// `Place Of Birth`
  String get PlaceOfBirth {
    return Intl.message(
      'Place Of Birth',
      name: 'PlaceOfBirth',
      desc: '',
      args: [],
    );
  }

  String get PlaceOfBirthn {
    return Intl.message(
      'Place of Birth',
      name: 'PlaceOfBirthn',
      desc: '',
      args: [],
    );
  }

  /// `Date Of Birth`
  String get DateOfBirth {
    return Intl.message(
      'Date Of Birth',
      name: 'DateOfBirth',
      desc: '',
      args: [],
    );
  }

  String get DateOfBirthn {
    return Intl.message(
      'Date of Birth',
      name: 'DateOfBirthn',
      desc: '',
      args: [],
    );
  }

  /// `Education Level`
  String get EducationLevel {
    return Intl.message(
      'Education Level',
      name: 'EducationLevel',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `National Address`
  String get NationalAddress {
    return Intl.message(
      'National Address',
      name: 'NationalAddress',
      desc: '',
      args: [],
    );
  }

  /// `(If The Client Is Resident Of The Kingdom)`
  String get IfResident {
    return Intl.message(
      '(If The Client Is Resident Of The Kingdom)',
      name: 'IfResident',
      desc: '',
      args: [],
    );
  }

  /// `We Wish To Receive A Statement Via :`
  String get WeWish {
    return Intl.message(
      'We wish to receive a statement via :',
      name: 'WeWish',
      desc: '',
      args: [],
    );
  }

  /// `Via`
  String get Via {
    return Intl.message(
      'Via',
      name: 'Via',
      desc: '',
      args: [],
    );
  }

  /// `E-Mail`
  String get EMail {
    return Intl.message(
      'E-Mail',
      name: 'EMail',
      desc: '',
      args: [],
    );
  }

  /// `We Do Not Wish To Receive A Statement`
  String get WeNotWish {
    return Intl.message(
      'We Do Not Wish To Receive A Statement',
      name: 'WeNotWish',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get Country {
    return Intl.message(
      'Country',
      name: 'Country',
      desc: '',
      args: [],
    );
  }

  /// `P.O. Box`
  String get PO {
    return Intl.message(
      'P.O. Box',
      name: 'PO',
      desc: '',
      args: [],
    );
  }

  /// `Mobile`
  String get Mobile {
    return Intl.message(
      'Mobile',
      name: 'Mobile',
      desc: '',
      args: [],
    );
  }

  /// `Fax`
  String get Fax {
    return Intl.message(
      'Fax',
      name: 'Fax',
      desc: '',
      args: [],
    );
  }

  /// `Residence Phone Number`
  String get ResidencePhone {
    return Intl.message(
      'Residence Phone Number',
      name: 'ResidencePhone',
      desc: '',
      args: [],
    );
  }

  /// `District`
  String get District {
    return Intl.message(
      'District',
      name: 'District',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get City {
    return Intl.message(
      'City',
      name: 'City',
      desc: '',
      args: [],
    );
  }

  /// `Building Number`
  String get BuildingNo {
    return Intl.message(
      'Building Number',
      name: 'BuildingNo',
      desc: '',
      args: [],
    );
  }

  /// `Street Name`
  String get StreetName {
    return Intl.message(
      'Street Name',
      name: 'StreetName',
      desc: '',
      args: [],
    );
  }

  /// `Zip Code`
  String get ZipCode {
    return Intl.message(
      'Zip Code',
      name: 'ZipCode',
      desc: '',
      args: [],
    );
  }

  /// `Secondary Number`
  String get SecondaryNumber {
    return Intl.message(
      'Secondary Number',
      name: 'SecondaryNumber',
      desc: '',
      args: [],
    );
  }

  /// `Employer's Name`
  String get EmployerName {
    return Intl.message(
      'Employer\'s Name',
      name: 'EmployerName',
      desc: '',
      args: [],
    );
  }

  /// `Employer's Address`
  String get EmployerAddress {
    return Intl.message(
      'Employer\'s Address',
      name: 'EmployerAddress',
      desc: '',
      args: [],
    );
  }

  /// `Employer's Phone Number`
  String get EmployerPhone {
    return Intl.message(
      'Employer\'s Phone Number',
      name: 'EmployerPhone',
      desc: '',
      args: [],
    );
  }

  /// `Duration Of Employment`
  String get DurationOfEmployment {
    return Intl.message(
      'Duration Of Employment',
      name: 'DurationOfEmployment',
      desc: '',
      args: [],
    );
  }

  /// `Position/Title`
  String get Position {
    return Intl.message(
      'Position/Title',
      name: 'Position',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get Back {
    return Intl.message(
      'Back',
      name: 'Back',
      desc: '',
      args: [],
    );
  }

  String get GCCMS77 {
    return Intl.message(
      'A Board of Directors resolution of the listed company and the company that the investment account is to be opened for (if it is an affiliate of that company). Such resolution shall also determine the investment controls, and prior to opening the investment account',
      name:
          'A Board of Directors resolution of the listed company and the company that the investment account is to be opened for (if it is an affiliate of that company). Such resolution shall also determine the investment controls, and prior to opening the investment account',
      desc: '',
      args: [],
    );
  }

  String get other {
    return Intl.message(
      'Other',
      name: 'Other',
      desc: '',
      args: [],
    );
  }

  String get GCCMS7 {
    return Intl.message(
      'Other',
      name: 'Other',
      desc: '',
      args: [],
    );
  }

  String get IF5 {
    return Intl.message(
      'The investment funds Terms and Conditions and any amendments to them',
      name:
          'The investment funds Terms and Conditions and any amendments to them',
      desc: '',
      args: [],
    );
  }

  String get IF6 {
    return Intl.message(
      'The issued resolution approving the opening of the investment account and assigning the authorised signatories to operate the investment account',
      name:
          'The issued resolution approving the opening of the investment account and assigning the authorised signatories to operate the investment account',
      desc: '',
      args: [],
    );
  }

  /// `Bank Name`
  String get BankName {
    return Intl.message(
      'Bank Name',
      name: 'BankName',
      desc: '',
      args: [],
    );
  }

  /// `Branch Name`
  String get BranchName {
    return Intl.message(
      'Branch Name',
      name: 'BranchName',
      desc: '',
      args: [],
    );
  }

  /// `Main Account Number (IBAN)`
  String get IBAN {
    return Intl.message(
      'Main Account Number (IBAN)',
      name: 'IBAN',
      desc: '',
      args: [],
    );
  }

  String get Branch {
    return Intl.message(
      'Branch',
      name: 'Branch',
      desc: '',
      args: [],
    );
  }

  //LinkAgreementwithCustomer
  String get LinkAgreementwithCustomera {
    return Intl.message(
      'Link Agreement \n\nwith Customer',
      name: 'LinkAgreementwithCustomera',
      desc: '',
      args: [],
    );
  }

  //AssignAdvisoryManager
  String get AssignAdvisoryManagera {
    return Intl.message(
      'Assign Advisory\n\n    Manager',
      name: 'AssignAdvisoryManagera',
      desc: '',
      args: [],
    );
  }

  String get ArrangingServiceCreationa {
    return Intl.message(
      'Arranging Service \n\nCreation',
      name: 'ArrangingServiceCreationa',
      desc: '',
      args: [],
    );
  }

  String get AssignArrangingManagera {
    return Intl.message(
      'Assign Arranging \n\nManager',
      name: 'AssignArrangingManagera',
      desc: '',
      args: [],
    );
  }

  /// `Account Holder Name`
  String get AccountHolderName {
    return Intl.message(
      'Account Holder Name',
      name: 'AccountHolderName',
      desc: '',
      args: [],
    );
  }

  /// `Has the client worked in the financial sector during the past five years? (This includes, for example: working for capital market institutions, banks, finance companies, insurance companies)`
  String get ProfessionalExpQ1 {
    return Intl.message(
      'Has the client worked in the financial sector during the past five years? (This includes, for example: working for capital market institutions, banks, finance companies, insurance companies)',
      name: 'ProfessionalExpQ1',
      desc: '',
      args: [],
    );
  }

  /// `Does the client have any other practical experience related to the financial sector?`
  String get ProfessionalExpQ2 {
    return Intl.message(
      'Does the client have any other practical experience related to the financial sector?',
      name: 'ProfessionalExpQ2',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Correspondence Address`
  String get CorrespondenceAddress {
    return Intl.message(
      'Correspondence Address',
      name: 'CorrespondenceAddress',
      desc: '',
      args: [],
    );
  }

  /// `Account Name`
  String get AccountName {
    return Intl.message(
      'Account Name',
      name: 'AccountName',
      desc: '',
      args: [],
    );
  }

  /// `Account Number`
  String get AccountNumber {
    return Intl.message(
      'Account Number',
      name: 'AccountNumber',
      desc: '',
      args: [],
    );
  }

  /// `Source Of Income`
  String get SourceOfIncome {
    return Intl.message(
      'Source Of Income',
      name: 'SourceOfIncome',
      desc: '',
      args: [],
    );
  }

  /// `Approximate Net Worth (excluding residence) in SAR`
  String get ApproximateNetWorth {
    return Intl.message(
      'Approximate Net Worth (excluding residence) in SAR',
      name: 'ApproximateNetWorth',
      desc: '',
      args: [],
    );
  }

  /// `Approximate Annual Income (in SAR)`
  String get ApproximateAnnualIncome {
    return Intl.message(
      'Approximate Annual Income (in SAR)',
      name: 'ApproximateAnnualIncome',
      desc: '',
      args: [],
    );
  }

  /// `Is the client a board of directors’ member, an audit committee member or a senior executive in a listed company?`
  String get GeneralInfoQ1 {
    return Intl.message(
      'Is the client a board of directors’ member, an audit committee member or a senior executive in a listed company?',
      name: 'GeneralInfoQ1',
      desc: '',
      args: [],
    );
  }

  /// `Does the client have a close association with a board of directors’ member, an audit committee member or a senior executive in a listed company?`
  String get GeneralInfoQ2 {
    return Intl.message(
      'Does the client have a close association with a board of directors’ member, an audit committee member or a senior executive in a listed company?',
      name: 'GeneralInfoQ2',
      desc: '',
      args: [],
    );
  }

  /// `Is the client entrusted with prominent public function in the Kingdom or a foreign country, senior management position, or a position in an international organization?`
  String get GeneralInfoQ3 {
    return Intl.message(
      'Is the client entrusted with prominent public function in the Kingdom or a foreign country, senior management position, or a position in an international organization?',
      name: 'GeneralInfoQ3',
      desc: '',
      args: [],
    );
  }

  /// `Does the client have a relationship (by blood or marriage up to the second degree) , or have an association with a person entrusted with the prominent public function in the kingdom or a foreign country, senior management position, or a position in an international organization?`
  String get GeneralInfoQ4 {
    return Intl.message(
      'Does the client have a relationship (by blood or marriage up to the second degree) , or have an association with a person entrusted with the prominent public function in the kingdom or a foreign country, senior management position, or a position in an international organization?',
      name: 'GeneralInfoQ4',
      desc: '',
      args: [],
    );
  }

  /// `Is the client the beneficial owner of the account or business relationship?`
  String get GeneralInfoQ5 {
    return Intl.message(
      'Is the client the beneficial owner of the account or business relationship?',
      name: 'GeneralInfoQ5',
      desc: '',
      args: [],
    );
  }

  /// `The identity of the beneficial owner of the account or business relationship(if the answer to above question is No)`
  String get GeneralInfoQ6 {
    return Intl.message(
      'The identity of the beneficial owner of the account or business relationship(if the answer to above question is No)',
      name: 'GeneralInfoQ6',
      desc: '',
      args: [],
    );
  }

  /// `Any other financial information on the client’s financial situation?`
  String get GeneralInfoQ7 {
    return Intl.message(
      'Any other financial information on the client’s financial situation?',
      name: 'GeneralInfoQ7',
      desc: '',
      args: [],
    );
  }

  /// `Are you a Tax Resident of any country or countries outside of Saudi Arabia? (by selecting ‘No’, I confirm that Saudi Arabia is my sole residency for tax purposes) `
  String get FatcaQ1 {
    return Intl.message(
      'Are you a Tax Resident of any Country or Countries outside of Saudi Arabia? (by selecting ‘No’, I confirm that Saudi Arabia is my sole residency for tax purposes) ',
      name: 'FatcaQ1',
      desc: '',
      args: [],
    );
  }

  /// `If Yes, Please Complete Section A`
  String get IfYesPleasecompletesectionA {
    return Intl.message(
      'If Yes, Please Complete Section B',
      name: 'IfYesPleasecompletesectionA',
      desc: '',
      args: [],
    );
  }

  /// `If Yes, Please Complete Section A`
  String get IfYesPleasecompletesectionB {
    return Intl.message(
      'If Yes, Please Complete Section B',
      name: 'IfYesPleasecompletesectionB',
      desc: '',
      args: [],
    );
  }

  /// `Section B - Tax Residency Information`
  String get SectionBTaxResidencyInformation {
    return Intl.message(
      'Section B - Tax Residency Information',
      name: 'SectionBTaxResidencyInformation',
      desc: '',
      args: [],
    );
  }

  /// `Please Specify Your Country(ies)/Jurisdiction(s) Of Residence For Tax Purposes Including Taxpayer Identification Number.If You Are A Tax Resident Of The United States Of America (USA), Please Also Complete Section B`
  String get FatcaQ2 {
    return Intl.message(
      'Please specify your Country(ies)/Jurisdiction(s) of Residence for Tax Purposes including Taxpayer Identification number.If you are a Tax Resident of the United States of America (USA), please also complete Section C',
      name: 'FatcaQ2',
      desc: '',
      args: [],
    );
  }

  /// `Country/Jurisdiction (Abbreviations Are Not Allowed)`
  String get CountryJurisdictionAbbreviationsarenotAllowed {
    return Intl.message(
      'Country/Jurisdiction (Abbreviations Are Not Allowed)',
      name: 'CountryJurisdictionAbbreviationsarenotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Taxpayer Identification Number (TIN) or Functional Equivalent`
  String get TaxpayerIdentification {
    return Intl.message(
      'Taxpayer Identification Number (TIN) or Functional Equivalent',
      name: 'TaxpayerIdentification',
      desc: '',
      args: [],
    );
  }

  /// `*If No TIN Available Enter Reason`
  String get IfnoTINavailableenterReason {
    return Intl.message(
      '*If No TIN Available Enter Reason',
      name: 'IfnoTINavailableenterReason',
      desc: '',
      args: [],
    );
  }

  /// `*If TIN Is Not Available Please Choose One Of The Following Reasons:`
  String get chooseoneofthefollowingreasons {
    return Intl.message(
      '*If TIN Is Not Available Please Choose One Of The Following Reasons:',
      name: 'chooseoneofthefollowingreasons',
      desc: '',
      args: [],
    );
  }

  /// `The Country/jurisdiction Where The Account Holder Is Resident Does Not Issue Tins To Its Residents`
  String get FatcaOpt1 {
    return Intl.message(
      'The Country/Jurisdiction Where The Account Holder Is Resident Does Not Issue TINs To Its Residents',
      name: 'FatcaOpt1',
      desc: '',
      args: [],
    );
  }

  /// `The Account Holder Is Otherwise Unable To Obtain A Tin Or Equivalent Number (Please Explain Why You Are Unable To Obtain A Tin If You Have Selected This Reason):`
  String get FatcaOpt2 {
    return Intl.message(
      'The Account Holder Is Otherwise Unable To Obtain A TIN Or Equivalent Number (Please Explain Why You Are Unable To Obtain A TIN If You Have Selected This Reason):',
      name: 'FatcaOpt2',
      desc: '',
      args: [],
    );
  }

  /// `No Tin Is Required.(Note: Only Select This Reason If The Domestic Law Of The Relevant Jurisdiction Does Not Require The Collection Of The Tin Issued By Such Jurisdiction)`
  String get FatcaOpt3 {
    return Intl.message(
      'No TIN Is Required.(Note: Only Select This Reason If The Domestic Law Of The Relevant Jurisdiction Does Not Require The Collection Of The TIN Issued By Such Jurisdiction)',
      name: 'FatcaOpt3',
      desc: '',
      args: [],
    );
  }

  /// `Country 1`
  String get Country1 {
    return Intl.message(
      'Country 1',
      name: 'Country1',
      desc: '',
      args: [],
    );
  }

  /// `Country 2`
  String get Country2 {
    return Intl.message(
      'Country 2',
      name: 'Country2',
      desc: '',
      args: [],
    );
  }

  /// `Country 3`
  String get Country3 {
    return Intl.message(
      'Country 3',
      name: 'Country3',
      desc: '',
      args: [],
    );
  }

  /// `Section C - USA Tax Residents`
  String get SectionCUSATaxResidents {
    return Intl.message(
      'Section C - USA Tax Residents',
      name: 'SectionCUSATaxResidents',
      desc: '',
      args: [],
    );
  }

  /// `If You Are A Usa Tax Resident Please Provide One Of The Following Tins. A Us Tin Can Be One Of The Following: A Social Security Number (SSN), Or An Individual Taxpayer Identification Number (ITIN). Please Provide You Tin In One Of The Lines Provided Below:`
  String get FatcaQ3 {
    return Intl.message(
      'If You Are A USA Tax Resident Please Provide One Of The Following TINs. A US TIN Can Be One Of The Following: A Social Security Number (SSN), Or An Individual Taxpayer Identification Number (ITIN). Please Provide You TIN In One Of The Lines Provided Below:',
      name: 'FatcaQ3',
      desc: '',
      args: [],
    );
  }

  /// `SSN`
  String get SSN {
    return Intl.message(
      'SSN',
      name: 'SSN',
      desc: '',
      args: [],
    );
  }

  /// `ITIN`
  String get ITIN {
    return Intl.message(
      'ITIN',
      name: 'ITIN',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Date {
    return Intl.message(
      'Date',
      name: 'Date',
      desc: '',
      args: [],
    );
  }

  /// `Compliance Approval`
  String get ComplianceApproval {
    return Intl.message(
      'Compliance Approval',
      name: 'ComplianceApproval',
      desc: '',
      args: [],
    );
  }

  /// `I Read & Understand & I Agree With The Terms & Conditions*`
  String get Terms {
    return Intl.message(
      'I Read & Understand & I Agree With The Terms & Conditions*',
      name: 'Terms',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get Submit {
    return Intl.message(
      'Submit',
      name: 'Submit',
      desc: '',
      args: [],
    );
  }

  /// `National ID`
  String get SaudiID {
    return Intl.message(
      'National ID',
      name: 'SaudiID',
      desc: '',
      args: [],
    );
  }

  /// `Browse`
  String get Browse {
    return Intl.message(
      'Browse',
      name: 'Browse',
      desc: '',
      args: [],
    );
  }

  /// `Iqama ID`
  String get IqamaID {
    return Intl.message(
      'Iqama ID',
      name: 'IqamaID',
      desc: '',
      args: [],
    );
  }

  /// `Document Type`
  String get DocumentType {
    return Intl.message(
      'Document Type',
      name: 'DocumentType',
      desc: '',
      args: [],
    );
  }

  /// `Upload Document`
  String get UploadDocument {
    return Intl.message(
      'Upload Document',
      name: 'UploadDocument',
      desc: '',
      args: [],
    );
  }

  /// `Diplomatic ID`
  String get DiplomaticID {
    return Intl.message(
      'Diplomatic ID',
      name: 'DiplomaticID',
      desc: '',
      args: [],
    );
  }

  /// `Passport ID`
  String get Passport {
    return Intl.message(
      'Passport ID',
      name: 'Passport',
      desc: '',
      args: [],
    );
  }

  /// `Address Proof`
  String get AddressProof {
    return Intl.message(
      'Address Proof',
      name: 'AddressProof',
      desc: '',
      args: [],
    );
  }

  //Director & Senior Executives :
  String get DirectorSeniorExecutives {
    return Intl.message(
      'Director & Senior Executives',
      name: 'Director & Senior Executives',
      desc: '',
      args: [],
    );
  }

  //Business Phone
  String get BusinessPhone {
    return Intl.message(
      'Business Phone',
      name: 'Business Phone',
      desc: '',
      args: [],
    );
  }

  /// `BRO:`
  String get BRO {
    return Intl.message(
      'Please specify the BRO for the account if diffrent from the client',
      name:
          'Please specify the BRO for the account if diffrent from the client',
      desc: '',
      args: [],
    );
  }

  String get IndustryCategory {
    return Intl.message(
      'Industry Category',
      name: 'Industry Category',
      desc: '',
      args: [],
    );
  }

  //AuthorizedRepresentativesshouldcompleteaseparateindividualKYCform
  String get AuthorizedRepresentativesshouldcompleteaseparateindividualKYCform {
    return Intl.message(
      'Authorized  Representatives should complete a separate individual KYC form',
      name:
          'Authorized  Representatives should complete a separate individual KYC form',
      desc: '',
      args: [],
    );
  }

  String get ContactInfoPhoneNumber {
    return Intl.message(
      'ContactInfo/Phone Number',
      name: 'ContactInfo/Phone Number',
      desc: '',
      args: [],
    );
  }

  String get FundCategory {
    return Intl.message(
      'Fund Category',
      name: 'Fund Category',
      desc: '',
      args: [],
    );
  }

  String get FundAllotment {
    return Intl.message(
      'Fund Allotment',
      name: 'Fund Allotment',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get Other {
    return Intl.message(
      'Other',
      name: 'Other',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get Description {
    return Intl.message(
      'Description',
      name: 'Description',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get High {
    return Intl.message(
      'High',
      name: 'High',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get Low {
    return Intl.message(
      'Low',
      name: 'Low',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get Medium {
    return Intl.message(
      'Medium',
      name: 'Medium',
      desc: '',
      args: [],
    );
  }

  /// `Investment Knowledge & Experience`
  String get ClientInvestmentKnowledgeExperience {
    return Intl.message(
      'Investment Knowledge & Experience',
      name: 'ClientInvestmentKnowledgeExperience',
      desc: '',
      args: [],
    );
  }

  /// `Number Of Years Of Investment In Securities`
  String get InvTaB1 {
    return Intl.message(
      'Number Of Years Of Investment In Securities',
      name: 'InvTaB1',
      desc: '',
      args: [],
    );
  }

  String get InvTaB1n {
    return Intl.message(
      'Number of years of investment in securities',
      name: 'InvTaB1n',
      desc: '',
      args: [],
    );
  }

  /// `Products Previously Invested In`
  String get InvTaB2 {
    return Intl.message(
      'Products Previously Invested In',
      name: 'InvTaB2',
      desc: '',
      args: [],
    );
  }

  String get InvTaB2n {
    return Intl.message(
      'Products previously invested in',
      name: 'InvTaB2n',
      desc: '',
      args: [],
    );
  }

  /// `Professional Certificates ( If The Client Is A Natural Person )`
  String get InvTaB3 {
    return Intl.message(
      'Professional Certificates ( If The Client Is A Natural Person )',
      name: 'InvTaB3',
      desc: '',
      args: [],
    );
  }

  String get InvTaB3n {
    return Intl.message(
      'Professional certificates(if the client is a natural person)',
      name: 'InvTaB3n',
      desc: '',
      args: [],
    );
  }

  /// `Loan To Invested Money Ratio`
  String get InvTaB4 {
    return Intl.message(
      'Loan To Invested Money Ratio',
      name: 'InvTaB4',
      desc: '',
      args: [],
    );
  }

  String get InvTaB4n {
    return Intl.message(
      'Loan to invested money ratio',
      name: 'InvTaB4n',
      desc: '',
      args: [],
    );
  }

  /// `Margin Transactions Over The Past Five Years`
  String get InvTaB5 {
    return Intl.message(
      'Margin Transactions Over The Past Five Years',
      name: 'InvTaB5',
      desc: '',
      args: [],
    );
  }

  String get InvTaB5n {
    return Intl.message(
      'Margin transactions over the past five years',
      name: 'InvTaB5n',
      desc: '',
      args: [],
    );
  }

  /// `Securities Transactions Outside The Kingdom Over The Past Five Years`
  String get InvTaB6 {
    return Intl.message(
      'Securities Transactions Outside The Kingdom Over The Past Five Years',
      name: 'InvTaB6',
      desc: '',
      args: [],
    );
  }

  /// `Securities Transactions Outside The Kingdom Over The Past Five Years`
  String get InvTaB6n {
    return Intl.message(
      'Securities transactions outside the Kingdom over the past five years',
      name: 'InvTaB6n',
      desc: '',
      args: [],
    );
  }

  /// `If Securities Transactions Were Executed Outside The Kingdom Over The Past Five Years, In Which Countries Were These Transactions Executed?`
  String get InvTaB7 {
    return Intl.message(
      'If Securities Transactions Were Executed Outside The Kingdom Over The Past Five Years, In Which Countries Were These Transactions Executed?',
      name: 'InvTaB7',
      desc: '',
      args: [],
    );
  }

  String get InvTaB7n {
    return Intl.message(
      'If securities transactions were executed outside the Kingdom over the past five years, in which countries were these transactions executed?',
      name: 'InvTaB7n',
      desc: '',
      args: [],
    );
  }

  /// `Client’s Appetite For Risk`
  String get ClientsAppetiteForRisk {
    return Intl.message(
      'Client’s Appetite For Risk',
      name: 'ClientsAppetiteForRisk',
      desc: '',
      args: [],
    );
  }

  String get ClientsAppetiteForRiskn {
    return Intl.message(
      'Client’s Appetite for Risk',
      name: 'ClientsAppetiteForRiskn',
      desc: '',
      args: [],
    );
  }

  /// `General Investment Objectives`
  String get GeneralInvestmentObjectives {
    return Intl.message(
      'General Investment Objectives',
      name: 'GeneralInvestmentObjectives',
      desc: '',
      args: [],
    );
  }

  String get Termsnew {
    return Intl.message(
      'I have read, understood and I Agree with the Terms & Conditions *',
      name: 'Termsnew',
      desc: '',
      args: [],
    );
  }

  String get InvA1new {
    return Intl.message(
      'Please ensure that the sum of all percentages of each portfolio above equals to 100%',
      name: 'InvA1new',
      desc: '',
      args: [],
    );
  }

  String get Options {
    return Intl.message(
      'Options',
      name: 'Options',
      desc: '',
      args: [],
    );
  }

  String get Select {
    return Intl.message(
      'Select',
      name: 'Select',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get Type {
    return Intl.message(
      'Type',
      name: 'Type',
      desc: '',
      args: [],
    );
  }

  /// `Client’s Current Investment Portfolio Profile`
  String get ClientCurrentInvestmentPortfolioProfile {
    return Intl.message(
      'Client’s Current Investment Portfolio Profile',
      name: 'ClientCurrentInvestmentPortfolioProfile',
      desc: '',
      args: [],
    );
  }

  /// `Client’s Ideal Investment Portfolio Profile`
  String get ClientIdealinvestmentportfolioprofile {
    return Intl.message(
      'Client’s Ideal Investment Portfolio Profile',
      name: 'ClientIdealinvestmentportfolioprofile',
      desc: '',
      args: [],
    );
  }

  /// `Deposits and Murabaha`
  String get InvAT11 {
    return Intl.message(
      'Deposits and Murabaha',
      name: 'InvAT11',
      desc: '',
      args: [],
    );
  }

  /// `Shares`
  String get InvAT12 {
    return Intl.message(
      'Shares',
      name: 'InvAT12',
      desc: '',
      args: [],
    );
  }

  /// `Real Estates`
  String get InvAT13 {
    return Intl.message(
      'Real Estates',
      name: 'InvAT13',
      desc: '',
      args: [],
    );
  }

  /// `Derivative Contracts`
  String get InvAT14 {
    return Intl.message(
      'Derivative Contracts',
      name: 'InvAT14',
      desc: '',
      args: [],
    );
  }

  /// `Alternative Investments`
  String get InvAT15 {
    return Intl.message(
      'Alternative Investments',
      name: 'InvAT15',
      desc: '',
      args: [],
    );
  }

  /// `Indicate Where The Following Should Be Forwarded`
  String get InvAT21 {
    return Intl.message(
      'Indicate Where The Following Should Be Forwarded',
      name: 'InvAT21',
      desc: '',
      args: [],
    );
  }

  /// `The Client`
  String get InvAT22 {
    return Intl.message(
      'The Client',
      name: 'InvAT22',
      desc: '',
      args: [],
    );
  }

  /// `The Custodian`
  String get InvAT23 {
    return Intl.message(
      'The Custodian',
      name: 'InvAT23',
      desc: '',
      args: [],
    );
  }

  /// `1) Certificates`
  String get InvAT24 {
    return Intl.message(
      '1) Certificates',
      name: 'InvAT24',
      desc: '',
      args: [],
    );
  }

  /// `2) Dividends/Other Income`
  String get InvAT25 {
    return Intl.message(
      '2) Dividends/Other Income',
      name: 'InvAT25',
      desc: '',
      args: [],
    );
  }

  /// `3) Sales Proceeds`
  String get InvAT26 {
    return Intl.message(
      '3) Sales Proceeds',
      name: 'InvAT26',
      desc: '',
      args: [],
    );
  }

  /// `Others : Specify All Details As Instructed By Client`
  String get InvAT27 {
    return Intl.message(
      'Others : Specify All Details As Instructed By Client',
      name: 'InvAT27',
      desc: '',
      args: [],
    );
  }

  /// `Please ensure that the sum of all percentages of each portfolio above equals 100%`
  String get InvA1 {
    return Intl.message(
      'Please ensure that the sum of all percentages of each portfolio above equals 100%',
      name: 'InvA1',
      desc: '',
      args: [],
    );
  }

  /// `Client’s Preferred Investments Assets ( Check As Many As Required )`
  String get InvA2 {
    return Intl.message(
      'Client’s Preferred Investments Assets ( Check As Many As Required )',
      name: 'InvA2',
      desc: '',
      args: [],
    );
  }

  /// `Denominated In Saudi Riyals`
  String get Opt1 {
    return Intl.message(
      'Denominated In Saudi Riyals',
      name: 'Opt1',
      desc: '',
      args: [],
    );
  }

  /// `Denominated In Foreign Currency`
  String get Opt2 {
    return Intl.message(
      'Denominated In Foreign Currency',
      name: 'Opt2',
      desc: '',
      args: [],
    );
  }

  /// `State The Foreign Currencies :`
  String get Opt3 {
    return Intl.message(
      'State The Foreign Currencies :',
      name: 'Opt3',
      desc: '',
      args: [],
    );
  }

  String get InvA2New {
    return Intl.message(
      'Client’s preferred investments assets ( check as many as required )',
      name: 'InvA2New',
      desc: '',
      args: [],
    );
  }

  String get Opt1new {
    return Intl.message(
      'Denominated in Saudi Riyals',
      name: 'Opt1new',
      desc: '',
      args: [],
    );
  }

  String get Opt2New {
    return Intl.message(
      'Denominated in Foreign Currency',
      name: 'Opt2New',
      desc: '',
      args: [],
    );
  }

  String get Opt3New {
    return Intl.message(
      'State the foreign currencies :',
      name: 'Opt3New',
      desc: '',
      args: [],
    );
  }

  String get InvA3n {
    return Intl.message(
      'The period during which the client expects to cash out his invested money',
      name: 'InvA3n',
      desc: '',
      args: [],
    );
  }

  String get Opt11n {
    return Intl.message(
      'Short term (less than 1 year)',
      name: 'Opt11n',
      desc: '',
      args: [],
    );
  }

  String get Opt12n {
    return Intl.message(
      'Medium term (1 year – 5 years)',
      name: 'Opt12n',
      desc: '',
      args: [],
    );
  }

  String get Opt13n {
    return Intl.message(
      'Long term ( more than 5 years )',
      name: 'Opt13n',
      desc: '',
      args: [],
    );
  }

  String get InvA4n {
    return Intl.message(
      'Other constraints',
      name: 'InvA4n',
      desc: '',
      args: [],
    );
  }

  String get InvA5n {
    return Intl.message(
      'Clients’ preferences and other constraints may include, as example sharia compliant investments etc. or any other constraints desired by the client.',
      name: 'InvA5n',
      desc: '',
      args: [],
    );
  }

  /// `The Period During Which The Client Expects To Cash Out His Invested Money`
  String get InvA3 {
    return Intl.message(
      'The Period During Which The Client Expects To Cash Out His Invested Money',
      name: 'InvA3',
      desc: '',
      args: [],
    );
  }

  /// `Short Term (less Than 1 Year)`
  String get Opt11 {
    return Intl.message(
      'Short Term (less Than 1 Year)',
      name: 'Opt11',
      desc: '',
      args: [],
    );
  }

  /// `Medium Term (1 Year – 5 Years)`
  String get Opt12 {
    return Intl.message(
      'Medium Term (1 Year – 5 Years)',
      name: 'Opt12',
      desc: '',
      args: [],
    );
  }

  /// `Long Term ( More Than 5 Years )`
  String get Opt13 {
    return Intl.message(
      'Long Term ( More Than 5 Years )',
      name: 'Opt13',
      desc: '',
      args: [],
    );
  }

  /// `Other Constraints`
  String get InvA4 {
    return Intl.message(
      'Other Constraints',
      name: 'InvA4',
      desc: '',
      args: [],
    );
  }

  /// `Clients’ Preferences And Other Constraints May Include, As Example Sharia Compliant Investments Etc. Or Any Other Constraints Desired By The Client.`
  String get InvA5 {
    return Intl.message(
      'Clients’ Preferences And Other Constraints May Include, As Example Sharia Compliant Investments Etc. Or Any Other Constraints Desired By The Client.',
      name: 'InvA5',
      desc: '',
      args: [],
    );
  }

  String get InvA5new {
    return Intl.message(
      'Clients’ preferences and other constraints may include, as example Sharia compliant investments etc. or any other constraints desired by the client.',
      name: 'InvA5new',
      desc: '',
      args: [],
    );
  }

  /// `Risk Assessment Form`
  String get RiskAssessmentForm {
    return Intl.message(
      'Risk Assessment Form',
      name: 'RiskAssessmentForm',
      desc: '',
      args: [],
    );
  }

  /// `Attribute`
  String get Attribute {
    return Intl.message(
      'Attribute',
      name: 'Attribute',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get Value {
    return Intl.message(
      'Value',
      name: 'Value',
      desc: '',
      args: [],
    );
  }

  /// `Weightage`
  String get Weightage {
    return Intl.message(
      'Weightage',
      name: 'Weightage',
      desc: '',
      args: [],
    );
  }

  /// `Nationality`
  String get Nationality {
    return Intl.message(
      'Nationality',
      name: 'Nationality',
      desc: '',
      args: [],
    );
  }

  /// `Residency`
  String get Residency {
    return Intl.message(
      'Residency',
      name: 'Residency',
      desc: '',
      args: [],
    );
  }

  /// `Work`
  String get Work {
    return Intl.message(
      'Work',
      name: 'Work',
      desc: '',
      args: [],
    );
  }

  /// `Account Type`
  String get AccountType {
    return Intl.message(
      'Account Type',
      name: 'AccountType',
      desc: '',
      args: [],
    );
  }

  /// `Source Of Wealth`
  String get SourceOfWealth {
    return Intl.message(
      'Source Of Wealth',
      name: 'SourceOfWealth',
      desc: '',
      args: [],
    );
  }

  /// `Investment Knowledge And Experience`
  String get InvestmentKnowledgeAndExperience {
    return Intl.message(
      'Investment Knowledge And Experience',
      name: 'InvestmentKnowledgeAndExperience',
      desc: '',
      args: [],
    );
  }

  String get InvestmentKnowledgeAndExperiencen {
    return Intl.message(
      'Investment Knowledge and Experience',
      name: 'InvestmentKnowledgeAndExperiencen',
      desc: '',
      args: [],
    );
  }

  String get Questions {
    return Intl.message(
      'Questions',
      name: 'Questions',
      desc: '',
      args: [],
    );
  }

  /// `Customer's Ability to Bear Risk`
  String get CustomerAbility {
    return Intl.message(
      'Customer\'s Ability to Bear Risk',
      name: 'CustomerAbility',
      desc: '',
      args: [],
    );
  }

  /// `Client's Investment Objectives Capital Protection. `
  String get RiskTable9 {
    return Intl.message(
      'Client\'s Investment Objectives Capital Protection. ',
      name: 'RiskTable9',
      desc: '',
      args: [],
    );
  }

  /// `Client Type`
  String get ClientType {
    return Intl.message(
      'Client Type',
      name: 'ClientType',
      desc: '',
      args: [],
    );
  }

  /// `Is The Client A Board Member Or A Committee Member In A Listed Company`
  String get RiskTable11 {
    return Intl.message(
      'Is The Client A Board Member Or A Committee Member In A Listed Company',
      name: 'RiskTable11',
      desc: '',
      args: [],
    );
  }

  /// `Investing With East Bridge Company`
  String get RiskTable14 {
    return Intl.message(
      'Investing With East Bridge Company',
      name: 'RiskTable14',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get Total {
    return Intl.message(
      'Total',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get FirstName {
    return Intl.message(
      'First Name',
      name: 'FirstName',
      desc: '',
      args: [],
    );
  }

  /// `Family Name`
  String get FamilyName {
    return Intl.message(
      'Family Name',
      name: 'FamilyName',
      desc: '',
      args: [],
    );
  }

  /// `ID Expiry Date`
  String get IDExpiryDate {
    return Intl.message(
      'ID Expiry Date',
      name: 'IDExpiryDate',
      desc: '',
      args: [],
    );
  }

  /// `Mail`
  String get Mail {
    return Intl.message(
      'Mail',
      name: 'Mail',
      desc: '',
      args: [],
    );
  }

  /// `Protection Of Capital`
  String get ProtectionOfCapital {
    return Intl.message(
      'Protection Of Capital',
      name: 'ProtectionOfCapital',
      desc: '',
      args: [],
    );
  }

  /// `Income`
  String get Income {
    return Intl.message(
      'Income',
      name: 'Income',
      desc: '',
      args: [],
    );
  }

  /// `Balanced`
  String get Balanced {
    return Intl.message(
      'Balanced',
      name: 'Balanced',
      desc: '',
      args: [],
    );
  }

  /// `Growth Of Capital`
  String get GrowthOfCapital {
    return Intl.message(
      'Growth Of Capital',
      name: 'GrowthOfCapital',
      desc: '',
      args: [],
    );
  }

  String get GrowthOfCapitalNew {
    return Intl.message(
      'Growth of Capital',
      name: 'GrowthOfCapitalNew',
      desc: '',
      args: [],
    );
  }

  String get CreateSavingForRetirementNew {
    return Intl.message(
      'Create saving for retirement',
      name: 'CreateSavingForRetirementNew',
      desc: '',
      args: [],
    );
  }

  String get PurchaseAnAssetNew {
    return Intl.message(
      'Purchase an Asset',
      name: 'PurchaseAnAssetNew',
      desc: '',
      args: [],
    );
  }

  String get ProtectionOfCapitalNew {
    return Intl.message(
      'Protection of Capital',
      name: 'ProtectionOfCapitalNew',
      desc: '',
      args: [],
    );
  }

  /// `Create Saving For Retirement`
  String get CreateSavingForRetirement {
    return Intl.message(
      'Create Saving For Retirement',
      name: 'CreateSavingForRetirement',
      desc: '',
      args: [],
    );
  }

  /// `Project Financing`
  String get ProjectFinancing {
    return Intl.message(
      'Project Financing',
      name: 'ProjectFinancing',
      desc: '',
      args: [],
    );
  }

  /// `Purchase An Asset`
  String get PurchaseAnAsset {
    return Intl.message(
      'Purchase An Asset',
      name: 'PurchaseAnAsset',
      desc: '',
      args: [],
    );
  }

  /// `Section D - Declaration And Signature`
  String get SectionDDeclarationSign {
    return Intl.message(
      'Section D - Declaration And Signature',
      name: 'SectionDDeclarationSign',
      desc: '',
      args: [],
    );
  }

  String get SectionDDeclarationSignn {
    return Intl.message(
      'Section D - Declaration and Signature',
      name: 'SectionDDeclarationSignn',
      desc: '',
      args: [],
    );
  }

  /// `Name Of Signatory`
  String get NameOfSignatory {
    return Intl.message(
      'Name Of Signatory',
      name: 'NameOfSignatory',
      desc: '',
      args: [],
    );
  }

  String get NameOfSignatoryn {
    return Intl.message(
      'Name of Signatory',
      name: 'NameOfSignatoryn',
      desc: '',
      args: [],
    );
  }

  /// `Capacity Of Signatory`
  String get CapacityOfSignatory {
    return Intl.message(
      'Capacity Of Signatory',
      name: 'CapacityOfSignatory',
      desc: '',
      args: [],
    );
  }

  String get CapacityOfSignatoryn {
    return Intl.message(
      'Capacity of Signatory',
      name: 'CapacityOfSignatoryn',
      desc: '',
      args: [],
    );
  }

  /// `Retail Client`
  String get RetailClient {
    return Intl.message(
      'Retail Client',
      name: 'RetailClient',
      desc: '',
      args: [],
    );
  }

  /// `Qualified Client`
  String get QualifiedClient {
    return Intl.message(
      'Qualified Client',
      name: 'QualifiedClient',
      desc: '',
      args: [],
    );
  }

  /// `Read The Definition Of `
  String get PleaseClickOnTheLinkToKnowAbout {
    return Intl.message(
      'Read The Definition Of ',
      name: 'PleaseClickOnTheLinkToKnowAbout',
      desc: '',
      args: [],
    );
  }

  /// `Retail,Qualified & Institutional Client`
  String get RnQClient {
    return Intl.message(
      'Retail,Qualified & Institutional Client',
      name: 'RnQClient',
      desc: '',
      args: [],
    );
  }

  /// `Submit Relevant Documents If You Are Qualified Client :-`
  String get SubmitrelevantdocumentsifyouareQualifiedClient {
    return Intl.message(
      'Submit Relevant Documents If You Are Qualified Client :-',
      name: 'SubmitrelevantdocumentsifyouareQualifiedClient',
      desc: '',
      args: [],
    );
  }

  /// `Submit Relevant Documents If You Are Institutional Client :-`
  String get SubmitrelevantdocumentsifyouareInstitutionalClient {
    return Intl.message(
      'Submit Relevant Documents If You Are Institutional Client :-',
      name: 'SubmitrelevantdocumentsifyouareInstitutionalClient',
      desc: '',
      args: [],
    );
  }

  /// `A) A Natural Person Who Meets At Least One Of The Following Criteria: `
  String get CC1 {
    return Intl.message(
      'A) A Natural Person Who Meets At Least One Of The Following Criteria: ',
      name: 'CC1',
      desc: '',
      args: [],
    );
  }

  /// `1) Has Carried Out At Least 10 Transactions Per Quarter Over The Last 12 Months Of A Minimum Total Amount Of 40 Million Saudi Riyals On Securities Markets`
  String get CC2 {
    return Intl.message(
      '1) Has Carried Out At Least 10 Transactions Per Quarter Over The Last 12 Months Of A Minimum Total Amount Of 40 Million Saudi Riyals On Securities Markets',
      name: 'CC2',
      desc: '',
      args: [],
    );
  }

  /// `Upload Statement`
  String get UploadStatement {
    return Intl.message(
      'Upload Statement',
      name: 'UploadStatement',
      desc: '',
      args: [],
    );
  }

  /// `2) His Net Assets Is Not Less Than 5 Million Saudi Riyals.`
  String get CC3 {
    return Intl.message(
      '2) His Net Assets Is Not Less Than 5 Million Saudi Riyals.',
      name: 'CC3',
      desc: '',
      args: [],
    );
  }

  /// `Upload Income Proof`
  String get UploadIncomeProof {
    return Intl.message(
      'Upload Income Proof',
      name: 'UploadIncomeProof',
      desc: '',
      args: [],
    );
  }

  /// `3) Works Or Has Worked For At Least Three Years In The Financial Sector In A Professional Position Related To Investment In Securities.`
  String get CC4 {
    return Intl.message(
      '3) Works Or Has Worked For At Least Three Years In The Financial Sector In A Professional Position Related To Investment In Securities.',
      name: 'CC4',
      desc: '',
      args: [],
    );
  }

  /// `Upload Work Experience`
  String get UploadWorkExperience {
    return Intl.message(
      'Upload Work Experience',
      name: 'UploadWorkExperience',
      desc: '',
      args: [],
    );
  }

  /// `4) Holds A Professional Certificate In Securities Business And Accredited By An Internationally Recognised Entity.`
  String get CC5 {
    return Intl.message(
      '4) Holds A Professional Certificate In Securities Business And Accredited By An Internationally Recognised Entity.',
      name: 'CC5',
      desc: '',
      args: [],
    );
  }

  /// `Upload Certificate`
  String get UploadCertificate {
    return Intl.message(
      'Upload Certificate',
      name: 'UploadCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Upload Proof`
  String get UploadProof {
    return Intl.message(
      'Upload Proof',
      name: 'UploadProof',
      desc: '',
      args: [],
    );
  }

  /// `5) Holds The General Securities Qualification Certificate That Is Recognized By The Authority, And Has An Annual Income That Is Not Less Than 600,000 Saudi Riyals In The Last Two Years.`
  String get CC6 {
    return Intl.message(
      '5) Holds The General Securities Qualification Certificate That Is Recognized By The Authority, And Has An Annual Income That Is Not Less Than 600,000 Saudi Riyals In The Last Two Years.',
      name: 'CC6',
      desc: '',
      args: [],
    );
  }

  /// `6) Being A Client Of A Capital Market Institution Authorized By The Authority To Conduct Managing Activities, Provided That The Following Is Fulfilled: `
  String get CC71 {
    return Intl.message(
      '6) Being A Client Of A Capital Market Institution Authorized By The Authority To Conduct Managing Activities, Provided That The Following Is Fulfilled: ',
      name: 'CC71',
      desc: '',
      args: [],
    );
  }

  /// `  A. The Offer Shall Be Made To The Capital Market Institution, And That All Related Communications Be Made By It. `
  String get CC72 {
    return Intl.message(
      '  A. The Offer Shall Be Made To The Capital Market Institution, And That All Related Communications Be Made By It. ',
      name: 'CC72',
      desc: '',
      args: [],
    );
  }

  /// `B. The Capital Market Institution Has Been Appointed On Terms Which Enable It To Make Investment Decisions On The Client’s Behalf Without Obtaining Prior Approval From The Client.`
  String get CC73 {
    return Intl.message(
      'B. The Capital Market Institution Has Been Appointed On Terms Which Enable It To Make Investment Decisions On The Client’s Behalf Without Obtaining Prior Approval From The Client.',
      name: 'CC73',
      desc: '',
      args: [],
    );
  }

  /// `7) Registered Persons Of A Capital Market Institution If The Offer Is Carried Out By The Capital Market Institution Itself.`
  String get CC8 {
    return Intl.message(
      '7) Registered Persons Of A Capital Market Institution If The Offer Is Carried Out By The Capital Market Institution Itself.',
      name: 'CC8',
      desc: '',
      args: [],
    );
  }

  /// `B) A Legal Person, Which Meets At Least One Of The Following Criteria: `
  String get CC9 {
    return Intl.message(
      'B) A Legal Person, Which Meets At Least One Of The Following Criteria: ',
      name: 'CC9',
      desc: '',
      args: [],
    );
  }

  /// `Upload Net Assets Proof`
  String get UploadNetAssetsProof {
    return Intl.message(
      'Upload Net Assets Proof',
      name: 'UploadNetAssetsProof',
      desc: '',
      args: [],
    );
  }

  /// ` 1) Any Legal Person Acting For Its Own Account And Be Any Of The Following:`
  String get CC10 {
    return Intl.message(
      ' 1) Any Legal Person Acting For Its Own Account And Be Any Of The Following:',
      name: 'CC10',
      desc: '',
      args: [],
    );
  }

  /// `A. A Company Which Owns, Or Which Is A Member Of A Group Which Owns, Net Assets Of Not Less Than 10 Million Saudi Riyals And Not More Than 50 Million Saudi Riyals.`
  String get CC101 {
    return Intl.message(
      'A. A Company Which Owns, Or Which Is A Member Of A Group Which Owns, Net Assets Of Not Less Than 10 Million Saudi Riyals And Not More Than 50 Million Saudi Riyals.',
      name: 'CC101',
      desc: '',
      args: [],
    );
  }

  /// `B. Any Unincorporated Body, Partnership Company Or Other Organisation Which Has Net Assets Of Not Less Than 10 Million Saudi Riyals And Not More Than 50 Million Saudi Riyals.`
  String get CC102 {
    return Intl.message(
      'B. Any Unincorporated Body, Partnership Company Or Other Organisation Which Has Net Assets Of Not Less Than 10 Million Saudi Riyals And Not More Than 50 Million Saudi Riyals.',
      name: 'CC102',
      desc: '',
      args: [],
    );
  }

  /// `2) A Person Acting In The Capacity Of Director, Officer Or Employee Of A Legal Person And Responsible For Its Securities Activity, Where That Legal Person Falls Within The Definition Of Paragraph (1/a) Or (1/b). Clients Of A Capital Market Institution Authorized By The Authority To Conduct Managing Activities, Provided That The Following Is Fulfilled:`
  String get CC11 {
    return Intl.message(
      '2) A Person Acting In The Capacity Of Director, Officer Or Employee Of A Legal Person And Responsible For Its Securities Activity, Where That Legal Person Falls Within The Definition Of Paragraph (1/a) Or (1/b). Clients Of A Capital Market Institution Authorized By The Authority To Conduct Managing Activities, Provided That The Following Is Fulfilled:',
      name: 'CC11',
      desc: '',
      args: [],
    );
  }

  /// `A. The Offer Shall Be Made To The Capital Market Institution, And That All Related Communications Be Made By It; And `
  String get CC111 {
    return Intl.message(
      'A. The Offer Shall Be Made To The Capital Market Institution, And That All Related Communications Be Made By It; And ',
      name: 'CC111',
      desc: '',
      args: [],
    );
  }

  /// `B. The Capital Market Institution Has Been Appointed On Terms Which Enable It To Make Investment Decisions On The Client’s Behalf Without Obtaining Prior Approval From The Client. `
  String get CC112 {
    return Intl.message(
      'B. The Capital Market Institution Has Been Appointed On Terms Which Enable It To Make Investment Decisions On The Client’s Behalf Without Obtaining Prior Approval From The Client. ',
      name: 'CC112',
      desc: '',
      args: [],
    );
  }

  /// `C. A Company Fully Owned By A Natural Person Who Meets One Of The Criteria Mentioned In Paragraph (a) Or A Legal Person Who Meets One Of The Criteria Mentioned In Paragraph (b).`
  String get CC113 {
    return Intl.message(
      'C. A Company Fully Owned By A Natural Person Who Meets One Of The Criteria Mentioned In Paragraph (a) Or A Legal Person Who Meets One Of The Criteria Mentioned In Paragraph (b).',
      name: 'CC113',
      desc: '',
      args: [],
    );
  }

  /// `ID Expiry Date (Hijri)`
  String get IDExpiryDateHijri {
    return Intl.message(
      'ID Expiry Date (Hijri)',
      name: 'IDExpiryDateHijri',
      desc: '',
      args: [],
    );
  }

  /// `Date Of Birth (Hijri)`
  String get DOBHijri {
    return Intl.message(
      'Date Of Birth (Hijri)',
      name: 'DOBHijri',
      desc: '',
      args: [],
    );
  }

  String get DOBHijrin {
    return Intl.message(
      'Date of Birth (Hijri)',
      name: 'DOBHijrin',
      desc: '',
      args: [],
    );
  }

  /// `Date (Hijri)`
  String get DateHijri {
    return Intl.message(
      'Date (Hijri)',
      name: 'DateHijri',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get TermsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'TermsConditions',
      desc: '',
      args: [],
    );
  }

  /// `The Client acknowledges that he/she has read and understood the various provisions contained herein and been given ample opportunity to ask questions, and he/she acknowledges also that all information contained in this document is true, correct, comprehensive, valid and non-misleading. And he/she will inform the Investment Manger if any of these information have changed and that in a short time. The client commit to update his related data and information at any time requested by Investment Manager provided that such period doesn’t exceed 3 years. The client acknowledge of his awareness that the Investment Manager will freeze his investment account when this commitment is breached. The client undertake also to adhere to the Capital Market Law and its implementing regulations, and other laws and regulations of the Kingdom, in particular the anti-money laundering law and its implementing regulations, and law of terrorism crimes and financing. By signing below, the client agrees on all previous terms and declarations unless he send a written declaration and notification objecting the previous, and the  investment manager accepts it in written.`
  String get CLientTermsText {
    return Intl.message(
      'The Client acknowledges that he/she has read and understood the various provisions contained herein and been given ample opportunity to ask questions, and he/she acknowledges also that all information contained in this document is true, correct, comprehensive, valid and non-misleading. And he/she will inform the Investment Manger if any of these information have changed and that in a short time. The client commit to update his related data and information at any time requested by Investment Manager provided that such period doesn’t exceed 3 years. The client acknowledge of his awareness that the Investment Manager will freeze his investment account when this commitment is breached. The client undertake also to adhere to the Capital Market Law and its implementing regulations, and other laws and regulations of the Kingdom, in particular the anti-money laundering law and its implementing regulations, and law of terrorism crimes and financing. By signing below, the client agrees on all previous terms and declarations unless he send a written declaration and notification objecting the previous, and the  investment manager accepts it in written.',
      name: 'CLientTermsText',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get OK {
    return Intl.message(
      'OK',
      name: 'OK',
      desc: '',
      args: [],
    );
  }

  /// `Declaration`
  String get Declaration {
    return Intl.message(
      'Declaration',
      name: 'Declaration',
      desc: '',
      args: [],
    );
  }

  /// `Investment Profile`
  String get InvestmentPortfolio {
    return Intl.message(
      'Investment Profile',
      name: 'InvestmentPortfolio',
      desc: '',
      args: [],
    );
  }

  /// `(Power Of Attorney or Authorized Signatory)`
  String get POA {
    return Intl.message(
      '(Power Of Attorney or Authorized Signatory)',
      name: 'POA',
      desc: '',
      args: [],
    );
  }

  String get POAn {
    return Intl.message(
      '(Power of Attorney or Authorized Signatory)',
      name: 'POAn',
      desc: '',
      args: [],
    );
  }

  /// `Institutional Client`
  String get InstitutionalClient {
    return Intl.message(
      'Institutional Client',
      name: 'InstitutionalClient',
      desc: '',
      args: [],
    );
  }

  /// `Client's Investment Portfolio Profile`
  String get ClientsInvestmentPortfolioProfile {
    return Intl.message(
      'Client\'s Investment Portfolio Profile',
      name: 'ClientsInvestmentPortfolioProfile',
      desc: '',
      args: [],
    );
  }

  /// `Debt Instruments`
  String get DebtInstruments {
    return Intl.message(
      'Debt Instruments',
      name: 'DebtInstruments',
      desc: '',
      args: [],
    );
  }

  /// `Section A - Customer/Account Holder Information`
  String get SectionACustomerAccountHolderInformation {
    return Intl.message(
      'Section A - Customer/Account Holder Information',
      name: 'SectionACustomerAccountHolderInformation',
      desc: '',
      args: [],
    );
  }

  /// `I declare that all the particulars and information provided herein, are true, correct, complete and up-to-date in all respects and I have not withheld any information and I acknowledge that East Bridge Capital will rely on the information provided in this form until notice in writing satisfactory to East Bridge Capitalof its revocation and by submission of an updated Self-Certification & Declaration Form is received by East Bridge Capital , within 30 days where any change in circumstances occurs.I hereby undertake to inform East Bridge Capital of any change in information / circumstances provided, and to furnish East Bridge Capital any changes/amendments taking place in future with reference to the documents submitted by me as and when such changes/amendments occur.I undertake to inform East Bridge Capital if I am away from my own country of residence for any period that may impact the United States Substantial Presence Test, or the presence test related to any other .I confirm and accept that should any withholding, tax, other impositions or other governmental dues related to me become payable to domestic or overseas regulators or tax authorities, all payments made to me shall be net of any such taxes etc.. East Bridge Capital assumes no liability in this regard.I waive East Bridge Capital of its duty of confidentiality and grant East Bridge Capital the liberty to make available, as and when required by law/authorities, to the Courts, regulatory/or other authorities of Saudi Arabia or my country of residence or the country in whose currency this account will be maintained or routed, or to any other regulator/tax authority or other authorities in domestic and other jurisdictions, any information relating to my account, without any prior consent from me. Any information / documents provided by you or your authorized representative in relation to this self-certification form shall only be disclosed to the relevant authorities for the purpose of compliance with FATCA and / or CRS requirements.`
  String get FatcaDeclarationText {
    return Intl.message(
      'I declare that all the particulars and information provided herein, are true, correct, complete and up-to-date in all respects and I have not withheld any information and I acknowledge that East Bridge Capital will rely on the information provided in this form until notice in writing satisfactory to East Bridge Capitalof its revocation and by submission of an updated Self-Certification & Declaration Form is received by East Bridge Capital , within 30 days where any change in circumstances occurs.I hereby undertake to inform East Bridge Capital of any change in information / circumstances provided, and to furnish East Bridge Capital any changes/amendments taking place in future with reference to the documents submitted by me as and when such changes/amendments occur.I undertake to inform East Bridge Capital if I am away from my own country of residence for any period that may impact the United States Substantial Presence Test, or the presence test related to any other .I confirm and accept that should any withholding, tax, other impositions or other governmental dues related to me become payable to domestic or overseas regulators or tax authorities, all payments made to me shall be net of any such taxes etc.. East Bridge Capital assumes no liability in this regard.I waive East Bridge Capital of its duty of confidentiality and grant East Bridge Capital the liberty to make available, as and when required by law/authorities, to the Courts, regulatory/or other authorities of Saudi Arabia or my country of residence or the country in whose currency this account will be maintained or routed, or to any other regulator/tax authority or other authorities in domestic and other jurisdictions, any information relating to my account, without any prior consent from me. Any information / documents provided by you or your authorized representative in relation to this self-certification form shall only be disclosed to the relevant authorities for the purpose of compliance with FATCA and / or CRS requirements.',
      name: 'FatcaDeclarationText',
      desc: '',
      args: [],
    );
  }

  /// `Please Click On This Link To Read Relevant Definitions`
  String get FatcaDefinitons {
    return Intl.message(
      'Please Click On This Link To Read Relevant Definitions',
      name: 'FatcaDefinitons',
      desc: '',
      args: [],
    );
  }

  /// `C) A Company Fully Owned By  `
  String get CC14 {
    return Intl.message(
      'C) A Company Fully Owned By  ',
      name: 'CC14',
      desc: '',
      args: [],
    );
  }

  /// `1) A Natural Person Who Meets One Of The Criteria Mentioned In Paragraph (A)`
  String get CC15 {
    return Intl.message(
      '1) A Natural Person Who Meets One Of The Criteria Mentioned In Paragraph (A)',
      name: 'CC15',
      desc: '',
      args: [],
    );
  }

  /// `2) A Legal Person Who Meets One Of The Criteria Mentioned In Paragraph (B) `
  String get CC16 {
    return Intl.message(
      '2) A Legal Person Who Meets One Of The Criteria Mentioned In Paragraph (B) ',
      name: 'CC16',
      desc: '',
      args: [],
    );
  }

  /// `Institutional Client: Means Any Of The Following:`
  String get CC17 {
    return Intl.message(
      'Institutional Client: Means Any Of The Following:',
      name: 'CC17',
      desc: '',
      args: [],
    );
  }

  /// `1) The Government of the Kingdom or any supranational authority recognized by the Authority`
  String get CC18 {
    return Intl.message(
      '1) The Government of the Kingdom or any supranational authority recognized by the Authority',
      name: 'CC18',
      desc: '',
      args: [],
    );
  }

  /// `2) Companies fully owned by the government or any government entity, either directly or through a portfolio managed by a Capital Market Institution authorized to carry on managing business`
  String get CC19 {
    return Intl.message(
      '2) Companies fully owned by the government or any government entity, either directly or through a portfolio managed by a Capital Market Institution authorized to carry on managing business',
      name: 'CC19',
      desc: '',
      args: [],
    );
  }

  /// `3) Any legal person acting for its own account and be any of the following:`
  String get CC20 {
    return Intl.message(
      '3) Any legal person acting for its own account and be any of the following:',
      name: 'CC20',
      desc: '',
      args: [],
    );
  }

  /// `A. A company which owns, or is a member of a group which owns, net assets of more than 50 million Saudi Riyals`
  String get CC201 {
    return Intl.message(
      'A. A company which owns, or is a member of a group which owns, net assets of more than 50 million Saudi Riyals',
      name: 'CC201',
      desc: '',
      args: [],
    );
  }

  /// `B. An unincorporated body, partnership company or other organization which has net assets of more than 50 million Saudi Riyals`
  String get CC202 {
    return Intl.message(
      'B. An unincorporated body, partnership company or other organization which has net assets of more than 50 million Saudi Riyals',
      name: 'CC202',
      desc: '',
      args: [],
    );
  }

  /// `C. A person acting in the capacity of director, officer or employee of a legal person and responsible for its securities activity, where that legal person falls within the definition of paragraph (c/1) or (c/2)`
  String get CC203 {
    return Intl.message(
      'C. A person acting in the capacity of director, officer or employee of a legal person and responsible for its securities activity, where that legal person falls within the definition of paragraph (c/1) or (c/2)',
      name: 'CC203',
      desc: '',
      args: [],
    );
  }

  /// `4)  A company fully owned by a legal person who meets the criteria of paragraph (b) or (c)`
  String get CC21 {
    return Intl.message(
      '4)  A company fully owned by a legal person who meets the criteria of paragraph (b) or (c)',
      name: 'CC21',
      desc: '',
      args: [],
    );
  }

  /// `5) An Investment Fund`
  String get CC22 {
    return Intl.message(
      '5) An Investment Fund',
      name: 'CC22',
      desc: '',
      args: [],
    );
  }

  /// `A Counterparty`
  String get CC23 {
    return Intl.message(
      'A Counterparty',
      name: 'CC23',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 0, 1, 2...`
  String get NoDepLabel {
    return Intl.message(
      'e.g. 0, 1, 2...',
      name: 'NoDepLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 1234567890`
  String get IdNumLablel {
    return Intl.message(
      'e.g. 1234567890',
      name: 'IdNumLablel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 0XX XXX XXXX`
  String get ResPhLabel {
    return Intl.message(
      'e.g. 0XX XXX XXXX',
      name: 'ResPhLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. +1 408 XXX XXXX`
  String get MobLabel {
    return Intl.message(
      'e.g. +1 408 XXX XXXX',
      name: 'MobLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. +1 XXX XXXXXXX`
  String get FaxLabel {
    return Intl.message(
      'e.g. +1 XXX XXXXXXX',
      name: 'FaxLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 99999`
  String get ZipLabel {
    return Intl.message(
      'e.g. 99999',
      name: 'ZipLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. GB33BUKB20201555555555`
  String get IbanLabel {
    return Intl.message(
      'e.g. GB33BUKB20201555555555',
      name: 'IbanLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. AAA-GG-SSSS`
  String get SSNLabel {
    return Intl.message(
      'e.g. AAA-GG-SSSS',
      name: 'SSNLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 9XX-8X-XXXX`
  String get ITINLabel {
    return Intl.message(
      'e.g. 9XX-8X-XXXX',
      name: 'ITINLabel',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get State {
    return Intl.message(
      'State',
      name: 'State',
      desc: '',
      args: [],
    );
  }

  /// `Fund Creation`
  String get FundCreation {
    return Intl.message(
      'Fund Creation',
      name: 'FundCreation',
      desc: '',
      args: [],
    );
  }

  /// `Fund Financial`
  String get FundFinancial {
    return Intl.message(
      'Fund Financial',
      name: 'FundFinancial',
      desc: '',
      args: [],
    );
  }

  /// `Fund Detail & Fund Classification`
  String get FundDetailFundClassification {
    return Intl.message(
      'Fund Detail & Fund Classification',
      name: 'FundDetailFundClassification',
      desc: '',
      args: [],
    );
  }

  //AdvisoryServiceCreation
  String get AdvisoryServiceCreation {
    return Intl.message(
      'Advisory Service Creation',
      name: 'AdvisoryServiceCreation',
      desc: '',
      args: [],
    );
  }

  //AdvisoryServiceCreation
  String get AdvisorySubServiceCreation {
    return Intl.message(
      'Advisory Sub Service Creation',
      name: 'AdvisorySubServiceCreation',
      desc: '',
      args: [],
    );
  }

  //AdvisoryServiceCreation
  String get AdvisoryMasterServiceSearch {
    return Intl.message(
      'Advisory Master Service Search',
      name: 'AdvisoryMasterServiceSearch',
      desc: '',
      args: [],
    );
  }

  //AdvisoryProductCode
  String get AdvisoryProductCode {
    return Intl.message(
      'Advisory Product Code',
      name: 'AdvisoryProductCode',
      desc: '',
      args: [],
    );
  }

  //AdvisoryAgreement
  String get AdvisoryAgreement {
    return Intl.message(
      'Advisory Agreement',
      name: 'AdvisoryAgreement',
      desc: '',
      args: [],
    );
  }

  //AdvisoryBankDetails
  String get AdvisoryBankDetails {
    return Intl.message(
      'Advisory Bank Details',
      name: 'AdvisoryBankDetails',
      desc: '',
      args: [],
    );
  }

  //AdvisoryFeesDetails
  String get AdvisoryFeesDetails {
    return Intl.message(
      'Advisory Fees Details',
      name: 'AdvisoryFeesDetails',
      desc: '',
      args: [],
    );
  }

  //AdvisoryFinancial&AdministrationDetails
  String get AdvisoryFinancialAdministrationDetails {
    return Intl.message(
      'Advisory Financial & Administration Details',
      name: 'AdvisoryFinancial&AdministrationDetails',
      desc: '',
      args: [],
    );
  }

  /// `Fund Financial Detail & Fund Administration Details`
  String get FundFinancialDetailFundAdministrationDetails {
    return Intl.message(
      'Fund Financial Detail & Fund Administration Details',
      name: 'FundFinancialDetailFundAdministrationDetails',
      desc: '',
      args: [],
    );
  }

  /// `Fees`
  String get Fees {
    return Intl.message(
      'Fees',
      name: 'Fees',
      desc: '',
      args: [],
    );
  }

  /// `Fund Details`
  String get FundDetails {
    return Intl.message(
      'Fund Details',
      name: 'FundDetails',
      desc: '',
      args: [],
    );
  }

  /// `Fund/Product Code`
  String get FundProductCode {
    return Intl.message(
      'Fund/Product Code',
      name: 'FundProductCode',
      desc: '',
      args: [],
    );
  }

  //ServiceAllotment
  String get ServiceAllotment {
    return Intl.message(
      'Service Allotment',
      name: 'ServiceAllotment',
      desc: '',
      args: [],
    );
  }

  //ServiceCatogory
  String get ServiceCatogory {
    return Intl.message(
      'Service Catogory',
      name: 'ServiceCatogory',
      desc: '',
      args: [],
    );
  }

  //ServiceType
  String get ServiceType {
    return Intl.message(
      'Service Type',
      name: 'ServiceType',
      desc: '',
      args: [],
    );
  }

  //AdvisoryDetails
  String get AdvisoryDetails {
    return Intl.message(
      'Advisory Details',
      name: 'AdvisoryDetails',
      desc: '',
      args: [],
    );
  }

  //AdvisoryFeestype
  String get AdvisoryFeestype {
    return Intl.message(
      'Advisory Fees type',
      name: 'AdvisoryFeestype',
      desc: '',
      args: [],
    );
  }

  //FixedAdvisoryFees
  String get FixedAdvisoryFees {
    return Intl.message(
      'Fixed Advisory Fees',
      name: 'FixedAdvisoryFees',
      desc: '',
      args: [],
    );
  }

  //AdvisoryFeesRate
  String get AdvisoryFeesRate {
    return Intl.message(
      'Advisory Fees Rate',
      name: 'AdvisoryFeesRate',
      desc: '',
      args: [],
    );
  }

  //PerformanceAdvisoryFees
  String get PerformanceAdvisoryFees {
    return Intl.message(
      'Performance Advisory Fees',
      name: 'PerformanceAdvisoryFees',
      desc: '',
      args: [],
    );
  }

  //CustodyAdvisoryFees
  String get CustodyAdvisoryFees {
    return Intl.message(
      'Custody Advisory Fees',
      name: 'CustodyAdvisoryFees',
      desc: '',
      args: [],
    );
  }

  //FundOperatorAdvisoryFees
  String get FundOperatorAdvisoryFees {
    return Intl.message(
      'Advisory Operator Advisory Fees',
      name: 'FundOperatorAdvisoryFees',
      desc: '',
      args: [],
    );
  }

  //AudtiorAdvisoryFees
  String get AudtiorAdvisoryFees {
    return Intl.message(
      'Audtior Advisory Fees',
      name: 'AudtiorAdvisoryFees',
      desc: '',
      args: [],
    );
  }

  //CustomerSearchforAdvisory
  String get CustomerSearchforAdvisory {
    return Intl.message(
      'Customer Search for Advisory',
      name: 'CustomerSearchforAdvisory',
      desc: '',
      args: [],
    );
  }

  //AdvisorySubscribe
  String get AdvisorySubscribe {
    return Intl.message(
      'Advisory Subscribe',
      name: 'Advisory Subscribe',
      desc: '',
      args: [],
    );
  }

  //Redeem
  String get Redeem {
    return Intl.message(
      'Redeem',
      name: 'Redeem',
      desc: '',
      args: [],
    );
  }

  //SendApprovalForRedeem
  String get SendApprovalForRedeem {
    return Intl.message(
      'Send Request For Service End',
      name: 'SendApprovalForRedeem',
      desc: '',
      args: [],
    );
  }

  //AssignAdvisoryManager
  String get AssignAdvisoryManager {
    return Intl.message(
      'Assign Advisory\n    Manager',
      name: 'AssignAdvisoryManager',
      desc: '',
      args: [],
    );
  }

  String get PortfolioClassification {
    return Intl.message(
      'Product Classification',
      name: 'PortfolioClassification',
      desc: '',
      args: [],
    );
  }

  String get FixedIncome {
    return Intl.message(
      'Fixed Income',
      name: 'FixedIncome',
      desc: '',
      args: [],
    );
  }

  String get AllotmentType {
    return Intl.message(
      'Allotment Type',
      name: 'AllotmentType',
      desc: '',
      args: [],
    );
  }

  String get Symbol {
    return Intl.message(
      'Symbol',
      name: 'Symbol',
      desc: '',
      args: [],
    );
  }

  String get SymbolSearch {
    return Intl.message(
      'Symbol Search',
      name: ' SymbolSearch',
      desc: '',
      args: [],
    );
  }

  //ArrangingAgreementTemplateSearch
  String get ArrangingAgreementTemplateSearch {
    return Intl.message(
      'Arranging Agreement Template Search',
      name: 'ArrangingAgreementTemplateSearch',
      desc: '',
      args: [],
    );
  }

  //ArrangingManagerSearch
  String get ArrangingManagerSearch {
    return Intl.message(
      'Arranging Manager Search',
      name: 'ArrangingManagerSearch',
      desc: '',
      args: [],
    );
  }

  //AssignArrangingManager
  String get AssignArrangingManager {
    return Intl.message(
      'Assign Arranging Manager',
      name: 'AssignArrangingManager',
      desc: '',
      args: [],
    );
  }

  //MileStoneTab
  String get MileStoneTab {
    return Intl.message(
      'MileStone Tab',
      name: 'MileStoneTab',
      desc: '',
      args: [],
    );
  }

  //ArrangingServiceCode
  String get ArrangingServiceCode {
    return Intl.message(
      'Arranging Service Code',
      name: 'ArrangingServiceCode',
      desc: '',
      args: [],
    );
  }

  //CustomerArrangingDetails
  String get CustomerArrangingDetails {
    return Intl.message(
      'Customer Arranging Details',
      name: 'CustomerArrangingDetails',
      desc: '',
      args: [],
    );
  }

  //ArrangingAgreement
  String get ArrangingAgreement {
    return Intl.message(
      'Arranging Agreement',
      name: 'ArrangingAgreement',
      desc: '',
      args: [],
    );
  }

  //ArrangingerviceCreation
  String get ArrangingerviceCreation {
    return Intl.message(
      'Arranging Service Creation',
      name: 'ArrangingAgreementTemplateSearch',
      desc: '',
      args: [],
    );
  }

  String get ProductName {
    return Intl.message(
      'Product Name',
      name: 'ProductName',
      desc: '',
      args: [],
    );
  }

  String get ProductId {
    return Intl.message(
      'Product Id',
      name: 'ProductId',
      desc: '',
      args: [],
    );
  }

  String get ProductCode {
    return Intl.message(
      'Product Code',
      name: 'ProductCode',
      desc: '',
      args: [],
    );
  }

  String get CompanyNameAR {
    return Intl.message(
      'Company Name\n(In Arabic)',
      name: 'CompanyNameAR',
      desc: '',
      args: [],
    );
  }

  String get DateofIncorporationorStartofBusinessAr {
    return Intl.message(
      'Date of Incorporation or Start of Business\n(Hijri)',
      name: 'DateofIncorporationorStartofBusinessAr',
      desc: '',
      args: [],
    );
  }

  //DurationofArranging
  String get DurationofArranging {
    return Intl.message(
      'Duration of Arranging',
      name: 'DurationofArranging',
      desc: '',
      args: [],
    );
  }

  String get PortfolioDetails {
    return Intl.message(
      'Product Details',
      name: 'PortfolioDetails',
      desc: '',
      args: [],
    );
  }

  String get PortfolioDetailShareClassification {
    return Intl.message(
      'Product Detail & Classification',
      name: 'PortfolioDetailShareClassification',
      desc: '',
      args: [],
    );
  }

  String get PortfolioFinancialDetail {
    return Intl.message(
      'Product Financial Detail',
      name: 'PortfolioFinancialDetail',
      desc: '',
      args: [],
    );
  }

  String get PortfolioFeesDetails {
    return Intl.message(
      'Product Fees Details',
      name: 'PortfolioFeesDetails',
      desc: '',
      args: [],
    );
  }

  //MileStone
  String get MileStone {
    return Intl.message(
      'Milestone',
      name: 'MileStone',
      desc: '',
      args: [],
    );
  }

  //AdvisoryManagerSearch
  String get AdvisoryManagerSearch {
    return Intl.message(
      'Advisory Manager Search',
      name: 'AdvisoryManagerSearch',
      desc: '',
      args: [],
    );
  }

  //AdvisorManagerId
  String get AdvisorManagerId {
    return Intl.message(
      'Advisor Manager Id',
      name: 'AdvisoryManagerSearch',
      desc: '',
      args: [],
    );
  }

  //AdvisorManagerName
  String get AdvisorManagerName {
    return Intl.message(
      'Advisor Manager Name',
      name: 'AdvisorManagerName',
      desc: '',
      args: [],
    );
  }

  //CustomerAdvisoryAgreement
  String get CustomerAdvisoryAgreement {
    return Intl.message(
      'Customer Advisory Agreement',
      name: 'CustomerAdvisoryAgreement',
      desc: '',
      args: [],
    );
  }

  //AdvisoryServiceCode
  String get AdvisoryServiceCode {
    return Intl.message(
      'Advisory Service Code',
      name: 'AdvisoryServiceCode',
      desc: '',
      args: [],
    );
  }

  String get FundInvoiceList {
    return Intl.message(
      'Fund Invoice List ',
      name: 'FundInvoiceList',
      desc: '',
      args: [],
    );
  }

  //TradingAdvisoryFees
  String get TradingAdvisoryFees {
    return Intl.message(
      'Trading Advisory Fees',
      name: 'TradingAdvisoryFees',
      desc: '',
      args: [],
    );
  }

  //AdvisoryServiceTotalValue
  String get AdvisoryServiceTotalValue {
    return Intl.message(
      'Advisory Service Total Value',
      name: 'AdvisoryServiceTotalValue',
      desc: '',
      args: [],
    );
  }

  //ServiceClassification
  String get ServiceClassification {
    return Intl.message(
      'Service Classification',
      name: 'ServiceClassification',
      desc: '',
      args: [],
    );
  }

  //ServiceName
  String get ServiceName {
    return Intl.message(
      'Service Name',
      name: 'ServiceName',
      desc: '',
      args: [],
    );
  }

  //ServiceName
  String get ServiceCode {
    return Intl.message(
      'Service Code',
      name: 'ServiceCode',
      desc: '',
      args: [],
    );
  }

  //ServiceName
  String get ServiceID {
    return Intl.message(
      'Service ID',
      name: 'ServiceID',
      desc: '',
      args: [],
    );
  }

  //TotalValue
  String get TotalValue {
    return Intl.message(
      'Total Value',
      name: 'TotalValue',
      desc: '',
      args: [],
    );
  }

  //ServiceIndustry
  String get ServiceIndustry {
    return Intl.message(
      'Service Industry',
      name: 'ServiceIndustry',
      desc: '',
      args: [],
    );
  }

  /// `Fund/Product Name`
  String get FundProductName {
    return Intl.message(
      'Fund/Product Name',
      name: 'FundProductName',
      desc: '',
      args: [],
    );
  }

  //ServiceStatus
  String get ServiceStatus {
    return Intl.message(
      'Service Status',
      name: 'ServiceStatus',
      desc: '',
      args: [],
    );
  }

  //TotalValueOfService
  String get TotalValueOfService {
    return Intl.message(
      'Total Value Of Service',
      name: 'ServiceStatus',
      desc: '',
      args: [],
    );
  }

  //ArrangingMasterServiceSearch
  String get ArrangingMasterServiceSearch {
    return Intl.message(
      'Arranging Master Service Search',
      name: 'ArrangingMasterServiceSearch',
      desc: '',
      args: [],
    );
  }

//ArrangingSubServiceCreation
  String get ArrangingSubServiceCreation {
    return Intl.message(
      'Arranging Sub Service Creation',
      name: 'ArrangingSubServiceCreation',
      desc: '',
      args: [],
    );
  }

  //CustomerDetailsArr
  String get CustomerDetailsArr {
    return Intl.message(
      'Customer Details Arr',
      name: 'CustomerDetailsArr',
      desc: '',
      args: [],
    );
  }

  //FundTemplateSearchArr
  String get FundTemplateSearchArr {
    return Intl.message(
      'Fund Template Search Arranging',
      name: 'FundTemplateSearchArr',
      desc: '',
      args: [],
    );
  }

  //AdvisoryAgreementArranging
  String get AdvisoryAgreementArranging {
    return Intl.message(
      'Advisory Agreement Arranging',
      name: 'AdvisoryAgreementArranging',
      desc: '',
      args: [],
    );
  }

  //FundTemplateSearchArr

  //AgreementTemplateSearch
  String get AdvisoryAgreementTemplateSearch {
    return Intl.message(
      'Advisory Agreement Template Search',
      name: 'ServiceStatus',
      desc: '',
      args: [],
    );
  }

  //ArrangingFeestype
  String get ArrangingFeestype {
    return Intl.message(
      'Arranging Fees type',
      name: 'ArrangingFeestype',
      desc: '',
      args: [],
    );
  }

  //FixedArrangingFees
  String get FixedArrangingFees {
    return Intl.message(
      'Fixed Arranging Fees',
      name: 'FixedArrangingFees',
      desc: '',
      args: [],
    );
  }

  //ArrangingFeesRate
  String get ArrangingFeesRate {
    return Intl.message(
      'Arranging Fees Rate',
      name: 'ArrangingFeesRate',
      desc: '',
      args: [],
    );
  }

  //PerformanceArrangingFees
  String get PerformanceArrangingFees {
    return Intl.message(
      'Performance Arranging Fees',
      name: 'PerformanceArrangingFees',
      desc: '',
      args: [],
    );
  }

  //CustodyArrangingFees
  String get CustodyArrangingFees {
    return Intl.message(
      'Custody Arranging Fees',
      name: 'PerformanceArrangingFees',
      desc: '',
      args: [],
    );
  }

  //ArrangingAgreementUpload
  String get ArrangingAgreementUpload {
    return Intl.message(
      'Arranging Agreement Upload',
      name: 'ArrangingAgreementUpload',
      desc: '',
      args: [],
    );
  }

  //ArrangingServiceCreation
  String get ArrangingServiceCreation {
    return Intl.message(
      'Arranging Service Creation',
      name: 'ArrangingServiceCreation',
      desc: '',
      args: [],
    );
  }

  //ArrangingFinancialAdministrationDetails
  String get ArrangingFinancialAdministrationDetails {
    return Intl.message(
      'Arranging Financial Administration Details',
      name: 'ArrangingFinancialAdministrationDetails',
      desc: '',
      args: [],
    );
  }

  //AdvisoryFundAgreement
  String get AdvisoryFundAgreement {
    return Intl.message(
      'Advisory Advisory Agreement',
      name: 'AdvisoryFundAgreement',
      desc: '',
      args: [],
    );
  }

  //ArrangingFeesDetails
  String get ArrangingFeesDetails {
    return Intl.message(
      'Arranging Fees Details',
      name: 'ArrangingFeesDetails',
      desc: '',
      args: [],
    );
  }

  //ArrangingBankDetails
  String get ArrangingBankDetails {
    return Intl.message(
      'Arranging Bank Details',
      name: 'ArrangingBankDetails',
      desc: '',
      args: [],
    );
  }

  //ArrangingAgreement
  String get ArrangingAgreements {
    return Intl.message(
      'Arranging Agreement',
      name: 'ArrangingAgreement',
      desc: '',
      args: [],
    );
  }

  //ArrangingCreation
  String get ArrangingCreation {
    return Intl.message(
      'Arranging Creation',
      name: 'ArrangingCreation',
      desc: '',
      args: [],
    );
  }

  //ArrangingDetails
  String get ArrangingDetails {
    return Intl.message(
      'Arranging Details',
      name: 'ArrangingDetails',
      desc: '',
      args: [],
    );
  }

  //CustomerArrangingAgreement
  String get CustomerArrangingAgreement {
    return Intl.message(
      'Customer Arranging Agreement',
      name: 'CustomerArrangingAgreement',
      desc: '',
      args: [],
    );
  }

  //ArrangingRedeem
  String get ArrangingRedeem {
    return Intl.message(
      'Arranging Redeem',
      name: 'ArrangingRedeem',
      desc: '',
      args: [],
    );
  }

  //ArrangingSubscribe
  String get ArrangingSubscribe {
    return Intl.message(
      'Arranging Subscribe',
      name: 'ArrangingSubscribe',
      desc: '',
      args: [],
    );
  }

  //TradingArrangingFees
  String get TradingArrangingFees {
    return Intl.message(
      'Trading Arranging Fees',
      name: 'TradingArrangingFees',
      desc: '',
      args: [],
    );
  }

  //AudtiorArrangingFees
  String get AudtiorArrangingFees {
    return Intl.message(
      'Audtior Arranging Fees',
      name: 'AudtiorArrangingFees',
      desc: '',
      args: [],
    );
  }

  //FundOperatorArrangingFees
  String get FundOperatorArrangingFees {
    return Intl.message(
      'Fund Operator Arranging Fees',
      name: 'FundOperatorArrangingFees',
      desc: '',
      args: [],
    );
  }

  //AdvisoryReedem
  String get AdvisoryReedem {
    return Intl.message(
      'Advisory Reedem',
      name: 'AdvisoryReedem',
      desc: '',
      args: [],
    );
  }

  //AdvisoryRedeem
  String get AdvisoryRedeem {
    return Intl.message(
      'Advisory Redeem',
      name: 'AdvisoryRedeem',
      desc: '',
      args: [],
    );
  }

  //AdvisoryRedeemSearch
  String get AdvisoryRedeemSearch {
    return Intl.message(
      'Advisory Redeem Search',
      name: 'AdvisoryRedeemSearch',
      desc: '',
      args: [],
    );
  }

  /// `Fund Classification`
  String get FundClassification {
    return Intl.message(
      'Fund Classification',
      name: 'FundClassification',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Industry Category' key

  /// `Fund Type`
  String get FundType {
    return Intl.message(
      'Fund Type',
      name: 'FundType',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Fund Allotment' key

  // skipped getter for the 'Fund Category' key

  /// `Status`
  String get Status {
    return Intl.message(
      'Status',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// `Total Value of Fund`
  String get fundtotalvalue {
    return Intl.message(
      'Total Value of Fund',
      name: 'fundtotalvalue',
      desc: '',
      args: [],
    );
  }

  /// `Per Share Value`
  String get PerShareValue {
    return Intl.message(
      'Per Unit Value',
      name: 'PerShareValue',
      desc: '',
      args: [],
    );
  }

  String get PerUnitValue {
    return Intl.message(
      'Per Unit Value',
      name: 'PerUnitValue',
      desc: '',
      args: [],
    );
  }

  /// `No. Of Shares`
  String get NoOfShares {
    return Intl.message(
      'No. Of Unit',
      name: 'NoOfShares',
      desc: '',
      args: [],
    );
  }

  String get NoOfUnit {
    return Intl.message(
      'No. Of Unit',
      name: 'NoOfUnit',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get Currency {
    return Intl.message(
      'Currency',
      name: 'Currency',
      desc: '',
      args: [],
    );
  }

  /// `Fund Administration Details`
  String get FundAdministrationDetails {
    return Intl.message(
      'Fund Administration Details',
      name: 'FundAdministrationDetails',
      desc: '',
      args: [],
    );
  }

  /// `Individual/Institutional`
  String get IndividualInstitutional {
    return Intl.message(
      'Individual/Institutional',
      name: 'IndividualInstitutional',
      desc: '',
      args: [],
    );
  }

  /// `Fund Manager`
  String get FundManager {
    return Intl.message(
      'Fund Manager',
      name: 'FundManager',
      desc: '',
      args: [],
    );
  }

  /// `Fund Operations`
  String get FundOperations {
    return Intl.message(
      'Fund Operations',
      name: 'FundOperations',
      desc: '',
      args: [],
    );
  }

  /// `Custodian`
  String get Custodian {
    return Intl.message(
      'Custodian',
      name: 'Custodian',
      desc: '',
      args: [],
    );
  }

  /// `Bank Details`
  String get BankDetails {
    return Intl.message(
      'Bank Details',
      name: 'BankDetails',
      desc: '',
      args: [],
    );
  }

  /// `IBANNumber`
  String get IBANNumber {
    return Intl.message(
      'IBANNumber',
      name: 'IBANNumber',
      desc: '',
      args: [],
    );
  }

  /// `Fees Detail`
  String get Feesdetail {
    return Intl.message(
      'Fees Detail',
      name: 'Feesdetail',
      desc: '',
      args: [],
    );
  }

  /// `Fees Type`
  String get Feestype {
    return Intl.message(
      'Fees Type',
      name: 'Feestype',
      desc: '',
      args: [],
    );
  }

  /// `Bank From/To`
  String get Bankfromto {
    return Intl.message(
      'Bank From/To',
      name: 'Bankfromto',
      desc: '',
      args: [],
    );
  }

  /// `Fixed Fees`
  String get FixedFees {
    return Intl.message(
      'Fixed Fees',
      name: 'FixedFees',
      desc: '',
      args: [],
    );
  }

  /// `Percent`
  String get percent {
    return Intl.message(
      'Percent',
      name: 'percent',
      desc: '',
      args: [],
    );
  }

  /// `% Of`
  String get percentof {
    return Intl.message(
      '% Of',
      name: 'percentof',
      desc: '',
      args: [],
    );
  }

  /// `Lower Limit`
  String get Lowerlimit {
    return Intl.message(
      'Lower Limit',
      name: 'Lowerlimit',
      desc: '',
      args: [],
    );
  }

  /// `Upper Limit`
  String get Uperlimit {
    return Intl.message(
      'Upper Limit',
      name: 'Uperlimit',
      desc: '',
      args: [],
    );
  }

  /// `Other Information`
  String get OtherInfo {
    return Intl.message(
      'Other Information',
      name: 'OtherInfo',
      desc: '',
      args: [],
    );
  }

  /// `Investing With East Bridge Company?`
  String get RiskQue {
    return Intl.message(
      'Investing With East Bridge Capital?',
      name: 'RiskQue',
      desc: '',
      args: [],
    );
  }

  /// `Investing With East Bridge Company?`
  String get RiskQue2 {
    return Intl.message(
      'Investing With East Bridge Capital?',
      name: 'RiskQue',
      desc: '',
      args: [],
    );
  }

  /// `Investment Account Opening Categories`
  String get InvestmentAccntOpening {
    return Intl.message(
      'Investment Account Opening Categories',
      name: 'InvestmentAccntOpening',
      desc: '',
      args: [],
    );
  }

  /// `Politically Exposed Person`
  String get PEP {
    return Intl.message(
      'Politically Exposed Person',
      name: 'PEP',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get Cash {
    return Intl.message(
      'Cash',
      name: 'Cash',
      desc: '',
      args: [],
    );
  }

  /// `Kind`
  String get cashKind {
    return Intl.message(
      'Cash & Kind',
      name: 'cashKind',
      desc: '',
      args: [],
    );
  }

  /// `Kind`
  String get Kind {
    return Intl.message(
      'Kind',
      name: 'Kind',
      desc: '',
      args: [],
    );
  }

  /// `Range From`
  String get RangeFrom {
    return Intl.message(
      'Range From',
      name: 'RangeFrom',
      desc: '',
      args: [],
    );
  }

  /// `Range To`
  String get RangeTo {
    return Intl.message(
      'Range To',
      name: 'RangeTo',
      desc: '',
      args: [],
    );
  }

  /// `Fees Rate (%)`
  String get FeesRate {
    return Intl.message(
      'Fees Rate (%)',
      name: 'FeesRate',
      desc: '',
      args: [],
    );
  }

  /// `Fund Fees Details`
  String get FundFeesDetails {
    return Intl.message(
      'Fund Fees Details',
      name: 'FundFeesDetails',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get Agree {
    return Intl.message(
      'Agree',
      name: 'Agree',
      desc: '',
      args: [],
    );
  }

  /// `Decline`
  String get Decline {
    return Intl.message(
      'Decline',
      name: 'Decline',
      desc: '',
      args: [],
    );
  }

  /// `Approve`
  String get Approve {
    return Intl.message(
      'Approve',
      name: 'Approve',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get Reject {
    return Intl.message(
      'Reject',
      name: 'Reject',
      desc: '',
      args: [],
    );
  }

  /// `Color Code`
  String get ColorCode {
    return Intl.message(
      'Color Code',
      name: 'ColorCode',
      desc: '',
      args: [],
    );
  }

  /// `Is The Customer The Beneficial Owner Of The Account `
  String get RiskTable15 {
    return Intl.message(
      'Is The Customer The Beneficial Owner Of The Account ',
      name: 'RiskTable15',
      desc: '',
      args: [],
    );
  }

  /// `Is There A Power Of Attorney On The Account`
  String get RiskTable16 {
    return Intl.message(
      'Is There A Power Of Attorney On The Account',
      name: 'RiskTable16',
      desc: '',
      args: [],
    );
  }

  /// `Fund List`
  String get FundList {
    return Intl.message(
      'Fund List',
      name: 'FundList',
      desc: '',
      args: [],
    );
  }

  /// `Power Of Attorney`
  String get PowerOfAttorneyn {
    return Intl.message(
      'Power of Attorney',
      name: 'PowerOfAttorneyn',
      desc: '',
      args: [],
    );
  }

  //SendApprovalForRedeem
  String get SendRequest {
    return Intl.message(
      'Send Request',
      name: 'SendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Power Of Attorney`
  String get PowerOfAttorney {
    return Intl.message(
      'Power of Attorney',
      name: 'PowerOfAttorney',
      desc: '',
      args: [],
    );
  }

  /// `Fund Bank Detail`
  String get FundBankDetail {
    return Intl.message(
      'Fund Bank Detail',
      name: 'FundBankDetail',
      desc: '',
      args: [],
    );
  }

  /// `Passport Expiry Date (Hijri)`
  String get PassportExpiryDateHijri {
    return Intl.message(
      'Passport Expiry Date (Hijri)',
      name: 'PassportExpiryDateHijri',
      desc: '',
      args: [],
    );
  }

  /// `(In Arabic)`
  String get InArabic {
    return Intl.message(
      '(In Arabic)',
      name: 'InArabic',
      desc: '',
      args: [],
    );
  }

  /// `Citizenship ID`
  String get CitizenshipID {
    return Intl.message(
      'Citizenship ID',
      name: 'CitizenshipID',
      desc: '',
      args: [],
    );
  }

  String get CitizenshipNo {
    return Intl.message(
      'Citizenship ID No.',
      name: 'citizenshipNo',
      desc: '',
      args: [],
    );
  }

  /// `Bank Code`
  String get BankCode {
    return Intl.message(
      'Bank Code',
      name: 'BankCode',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get Code {
    return Intl.message(
      'Code',
      name: 'Code',
      desc: '',
      args: [],
    );
  }

  /// `Any Client Who Is Not A Qualified Client or An Institutional Client.`
  String get CCRetail {
    return Intl.message(
      'Any Client Who Is Not A Qualified Client or An Institutional Client.',
      name: 'CCRetail',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get Category {
    return Intl.message(
      'Category',
      name: 'Category',
      desc: '',
      args: [],
    );
  }

  /// `Letter From Embassy or Diplomatic ID`
  String get LetterFromEmbassyorDiplomaticID {
    return Intl.message(
      'Letter From Embassy or Diplomatic ID',
      name: 'LetterFromEmbassyorDiplomaticID',
      desc: '',
      args: [],
    );
  }

  String get PortfolioCreation {
    return Intl.message(
      'Portfolio Creation',
      name: 'PortfolioCreation',
      desc: '',
      args: [],
    );
  }

  String get lockingPeriod {
    return Intl.message(
      'Locking Period',
      name: 'lockingPeriod',
      desc: '',
      args: [],
    );
  }

  /// `Five Year Residency Card`
  String get FiveYearResidencyCard {
    return Intl.message(
      'Five Year Residency Card',
      name: 'FiveYearResidencyCard',
      desc: '',
      args: [],
    );
  }

  String get CustomerFundAgreement {
    return Intl.message(
      'Customer Fund Agreement',
      name: 'CustomerFundAgreement',
      desc: '',
      args: [],
    );
  }

  String get CustomerFundAgreementTree {
    return Intl.message(
      'Customer Fund\n Agreement',
      name: 'CustomerFundAgreementTree',
      desc: '',
      args: [],
    );
  }

  String get CustomerDetails {
    return Intl.message(
      'Customer Details',
      name: 'CustomerDetails',
      desc: '',
      args: [],
    );
  }

  String get DateofIssuanceofTCofFund {
    return Intl.message(
      'Date Of Issuance Of T&C Of Fund',
      name: 'DateofIssuanceofTCofFund',
      desc: '',
      args: [],
    );
  }

  String get TheDateOfNotifying {
    return Intl.message(
      'The Date Of Notifying The Authourity To Offer The units Of The Investment Fund',
      name: 'TheDateOfNotifying',
      desc: '',
      args: [],
    );
  }

  String get TheDateTCWereLastUpdate {
    return Intl.message(
      'The Date T&C Were Last Update',
      name: 'TheDateTCWereLastUpdate',
      desc: '',
      args: [],
    );
  }

  String get FundEstablishmentDate {
    return Intl.message(
      'Fund Establishment Date',
      name: 'FundEstablishmentDate',
      desc: '',
      args: [],
    );
  }

  String get FundFirstClosingDate {
    return Intl.message(
      'Fund First Closing Date',
      name: 'FundFirstClosingDate',
      desc: '',
      args: [],
    );
  }

  String get ClosingDate {
    return Intl.message(
      'Closing Date',
      name: 'ClosingDate',
      desc: '',
      args: [],
    );
  }

  String get FundManagerHeadquaters {
    return Intl.message(
      'Fund Manager\'s Headquaters',
      name: 'FundManagerHeadquaters',
      desc: '',
      args: [],
    );
  }

  String get FundTermDate {
    return Intl.message(
      'Fund Term Date',
      name: 'FundTermDate',
      desc: '',
      args: [],
    );
  }

  String get FundExtentionPeriod {
    return Intl.message(
      'Fund Extention Period',
      name: 'FundExtentionPeriod',
      desc: '',
      args: [],
    );
  }

  String get Subscription {
    return Intl.message(
      'Subscription (Total Catpital Commitments)',
      name: 'Subscription',
      desc: '',
      args: [],
    );
  }

  String get NetAssetValue {
    return Intl.message(
      'Net Asset Value',
      name: 'NetAssetValue',
      desc: '',
      args: [],
    );
  }

  String get SubscriptionAmt {
    return Intl.message(
      'Subscription Amount',
      name: 'SubscriptionAmt',
      desc: '',
      args: [],
    );
  }

  String get FirstOffering {
    return Intl.message(
      'First Offering',
      name: 'FirstOffering',
      desc: '',
      args: [],
    );
  }

  String get PostOffering {
    return Intl.message(
      'Post Offering',
      name: 'PostOffering',
      desc: '',
      args: [],
    );
  }

  String get IssuingPeriod {
    return Intl.message(
      'Issuing Period',
      name: 'IssuingPeriod',
      desc: '',
      args: [],
    );
  }

  String get FirstOfferingPeriod {
    return Intl.message(
      'First Offering Period',
      name: 'FirstOfferingPeriod',
      desc: '',
      args: [],
    );
  }

  String get FirstOfferingStartDate {
    return Intl.message(
      'First Offering Start Date',
      name: 'FirstOfferingStartDate',
      desc: '',
      args: [],
    );
  }

  String get ValuationDate {
    return Intl.message(
      'Valuation Date',
      name: 'ValuationDate',
      desc: '',
      args: [],
    );
  }

  // Approval

  String get Approval {
    return Intl.message(
      'Approval',
      name: 'Approval',
      desc: '',
      args: [],
    );
  }

  String get FormName {
    return Intl.message(
      'Form Name',
      name: 'FormName',
      desc: '',
      args: [],
    );
  }

  String get ApprovalLevel1 {
    return Intl.message(
      'Approval Level 1',
      name: 'ApprovalLevel1',
      desc: '',
      args: [],
    );
  }

  String get ApprovalLevel2 {
    return Intl.message(
      'Approval Level 2',
      name: 'ApprovalLevel2',
      desc: '',
      args: [],
    );
  }

  String get ApprovalLevel3 {
    return Intl.message(
      'Approval Level 3',
      name: 'ApprovalLevel3',
      desc: '',
      args: [],
    );
  }

  String get ApprovalLevel4 {
    return Intl.message(
      'Approval Level 4',
      name: 'ApprovalLevel4',
      desc: '',
      args: [],
    );
  }

  String get RiskAssessment {
    return Intl.message(
      'Risk Assessment',
      name: 'RiskAssessment',
      desc: '',
      args: [],
    );
  }

  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  // Fund Template Search
  String get FundTemplateSearch {
    return Intl.message(
      'Fund Template Search',
      name: 'FundTemplateSearch',
      desc: '',
      args: [],
    );
  }

  String get Filters {
    return Intl.message(
      'Filters',
      name: 'Filters',
      desc: '',
      args: [],
    );
  }

  String get FundName {
    return Intl.message(
      'Fund Name',
      name: 'FundName',
      desc: '',
      args: [],
    );
  }

  String get FundCode {
    return Intl.message(
      'Fund Code',
      name: 'FundCode',
      desc: '',
      args: [],
    );
  }

  String get NoOfShare {
    return Intl.message(
      'No. of Shares',
      name: 'NoOfShare',
      desc: '',
      args: [],
    );
  }

  String get FundIndustry {
    return Intl.message(
      'Fund Industry',
      name: 'FundIndustry',
      desc: '',
      args: [],
    );
  }

  /// `RefreeIdentityCard`
  String get RefreeIdentityCard {
    return Intl.message(
      'Refree Identity Card',
      name: 'Refree Identity Card',
      desc: '',
      args: [],
    );
  }

  /// `Client National ID`
  String get ClientNationalID {
    return Intl.message(
      'Client National ID',
      name: 'ClientNationalID',
      desc: '',
      args: [],
    );
  }

  /// `GuardianNationalID`
  String get GuardianNationalID {
    return Intl.message(
      'GuardianNationalID',
      name: 'GuardianNationalID',
      desc: '',
      args: [],
    );
  }

  /// `Family Card (if age is less than 15)`
  String get FamilyCard {
    return Intl.message(
      'Family Card (if age is less than 15)',
      name: 'FamilyCard',
      desc: '',
      args: [],
    );
  }

  /// `Incapacitated Person Certificate`
  String get IncapacitatedPersonCertificate {
    return Intl.message(
      'Incapacitated Person Certificate',
      name: 'IncapacitatedPersonCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Fund Agreement`
  String get FundAgreement {
    return Intl.message(
      'Fund Agreement',
      name: 'FundAgreement',
      desc: '',
      args: [],
    );
  }

  //FeesAndExpenses
  String get FeesAndExpenses {
    return Intl.message(
      'Fees And Expenses',
      name: 'Fees And Expenses',
      desc: '',
      args: [],
    );
  }

  /// Official Phone Number
  String get OfficialPhoneNumber {
    return Intl.message(
      'Official Phone Number',
      name: 'Official PhoneNumber',
      desc: '',
      args: [],
    );
  }

// Please select if the current address is same as registered address
  String get current2 {
    return Intl.message(
      'Please select if the current address is same as registered address:     ',
      name:
          'Please select if the current address is same as registered address:    ',
      desc: '',
      args: [],
    );
  }

  //optional
  String get optional {
    return Intl.message(
      'Optional',
      name: 'Optional',
      desc: '',
      args: [],
    );
  }

  //NameOfAccount
  String get NameOfAccount {
    return Intl.message(
      'Name Of Account',
      name: 'Name Of Account',
      desc: '',
      args: [],
    );
  }

  /// `NationalID
  String get NationalID {
    return Intl.message(
      'National ID',
      name: 'National ID',
      desc: '',
      args: [],
    );
  }

  /// `Other Tab
  String get OtherTab {
    return Intl.message(
      'Other Tab',
      name: 'OtherTab',
      desc: '',
      args: [],
    );
  }

  /// sourceofwealth
  String get sourceofwealth {
    return Intl.message(
      'source of wealth',
      name: 'source of wealth',
      desc: '',
      args: [],
    );
  }

  /// sourceofwealth
  String get InvestmentKnowledgeandexperience {
    return Intl.message(
      'Investment Knowledge and experience',
      name: 'Investment Knowledge and experience',
      desc: '',
      args: [],
    );
  }

  /// sourceofwealth
  String get Customerabilitytobearrisk {
    return Intl.message(
      'Customer ability to bear risk',
      name: 'Customer ability to bear risk',
      desc: '',
      args: [],
    );
  }

  /// sourceofwealth
  String get ClientInvestmentobjectivecapitalprotection {
    return Intl.message(
      'Client Investment objective capital protection',
      name: 'Client Investment objective capital protection',
      desc: '',
      args: [],
    );
  }

  /// sourceofwealth
  String get Investingwitheastbridgecompany {
    return Intl.message(
      'Investing with east bridge company',
      name: 'Investing with east bridge company',
      desc: '',
      args: [],
    );
  }

  String get Isthereapowerofattorneyontheaccount {
    return Intl.message(
      'Is there a power of attorney on the account',
      name: 'Is there a power of attorney on the account',
      desc: '',
      args: [],
    );
  }

  //title
  String get title {
    return Intl.message(
      'title ID',
      name: 'ID ID',
      desc: '',
      args: [],
    );
  }

  /// ABCPvtLmt
  String get ABCPvtLmt {
    return Intl.message(
      'ABC Holding',
      name: 'ABC Pvt Lmt',
      desc: '',
      args: [],
    );
  }

  /// Buissness Name
  String get BuisnessName {
    return Intl.message(
      'Business Name',
      name: 'Buissness Name',
      desc: '',
      args: [],
    );
  }

  /// **********
  String get Enter10DigitsofRegistrationNumber {
    return Intl.message(
      'Enter 10 Digits of RegistrationNumber',
      name: 'Enter 10 Digits of Registration Number',
      desc: '',
      args: [],
    );
  }

  /// `Passport Expiry Date`
  String get PassportID {
    return Intl.message(
      'Passport ID',
      name: 'Passport ID',
      desc: '',
      args: [],
    );
  }

  //Building123
  String get Building123 {
    return Intl.message(
      'E.g: Building No: 1234',
      name: 'E.g: Building No: 1234',
      desc: '',
      args: [],
    );
  }

  //NameOfStreet
  String get NameOfStreet {
    return Intl.message(
      'Name of the Street',
      name: 'Name of the Street',
      desc: '',
      args: [],
    );
  }

  //Enter5DigitsofZipCode
  String get Enter5DigitsofZipCode {
    return Intl.message(
      'Please Enter 5 Digits of Zip Code',
      name: 'Name of the Street',
      desc: '',
      args: [],
    );
  }

  //Tabuk
  String get Tabuk {
    return Intl.message(
      'E.g: Tabuk',
      name: 'E.g: Tabuk',
      desc: '',
      args: [],
    );
  }

//Enter5DigitsNumber
  String get Enter5DigitsNumber {
    return Intl.message(
      'Enter 5 Digits Number',
      name: 'Enter 5 Digits Number',
      desc: '',
      args: [],
    );
  }

  //966
  String get fax1 {
    return Intl.message(
      '+966',
      name: '+966',
      desc: '',
      args: [],
    );
  }

  //SAR
  String get SAR {
    return Intl.message(
      'SAR',
      name: 'SAR',
      desc: '',
      args: [],
    );
  }

  //number

  String get number {
    return Intl.message(
      '0',
      name: '0',
      desc: '',
      args: [],
    );
  }

  //ContractNames
  String get ContractNames {
    return Intl.message(
      'Enter Contact Names',
      name: 'Contact Names',
      desc: '',
      args: [],
    );
  }

  //XYZgmail.com
  String get XYZgmailcom {
    return Intl.message(
      'XYZ@gmail.com',
      name: 'XYZ@gmail.com',
      desc: '',
      args: [],
    );
  }

  //NameOfBank
  String get NameOfBank {
    return Intl.message(
      'Name Of Bank',
      name: 'Name Of Bank',
      desc: '',
      args: [],
    );
  }

  //NameOfBranch
  String get NameOfBranch {
    return Intl.message(
      'Name Of Branch',
      name: 'Name Of Branch',
      desc: '',
      args: [],
    );
  }

  //saudiPhoneCode\
  String get saudiPhoneCode {
    return Intl.message(
      '+966',
      name: '+966',
      desc: '',
      args: [],
    );
  }

  //EnterName
  String get EnterName {
    return Intl.message(
      'EnterName',
      name: 'EnterName',
      desc: '',
      args: [],
    );
  }

  //NameOfAccountHolder
  String get NameOfAccountHolder {
    return Intl.message(
      'Name Of Account Holder',
      name: 'Name Of Account Holder',
      desc: '',
      args: [],
    );
  }

  //Enter24
  String get Enter24 {
    return Intl.message(
      'Enter Account Number',
      name: 'Enter Account Number',
      desc: '',
      args: [],
    );
  }

  //FirstNameSecondName
  String get FirstNameSecondName {
    return Intl.message(
      'Enter Name',
      name: 'Enter Name',
      desc: '',
      args: [],
    );
  }

  //EnterDetails
  String get EnterDetails {
    return Intl.message(
      'Enter Details',
      name: 'Enter Details',
      desc: '',
      args: [],
    );
  }

  /// `Debt`
  String get Debt {
    return Intl.message(
      'Debt Instrument',
      name: 'Debt Instrument',
      desc: '',
      args: [],
    );
  }

  //Registered Address
  String get RegisteredAddress {
    return Intl.message(
      'Registered Address',
      name: 'Registered Address',
      desc: '',
      args: [],
    );
  }

  //Authorized Representatives
  String get AuthorizedRepresentatives {
    return Intl.message(
      'Authorized Representative',
      name: 'Authorized Representatives',
      desc: '',
      args: [],
    );
  }

  String get WeNotWishn {
    return Intl.message(
      'We do not wish to receive a statement',
      name: 'WeNotWishn',
      desc: '',
      args: [],
    );
  }

  String get EMailn {
    return Intl.message(
      'e-mail',
      name: 'EMailn',
      desc: '',
      args: [],
    );
  }

  String get WeWishn {
    return Intl.message(
      'We wish to receive a statement via :',
      name: 'WeWishn',
      desc: '',
      args: [],
    );
  }

  //Contact
  String get Contact {
    return Intl.message(
      'Contact',
      name: 'Contact',
      desc: '',
      args: [],
    );
  }

  //Other Information
  String get otherInformation {
    return Intl.message(
      'Other Information',
      name: 'Other Information',
      desc: '',
      args: [],
    );
  }

  String get AdditionalInfo {
    return Intl.message(
      'Additional Information',
      name: 'AdditionalInfo',
      desc: '',
      args: [],
    );
  }

  //Investment Profile Client’s Investment Portfolio Profile A
  String get InvestmentProfileClientsInvestmentPortfolioProfileA {
    return Intl.message(
      'Investment Profile Clients Investment Portfolio Profile A',
      name: 'Investment Profile Clients Investment Portfolio Profile A',
      desc: '',
      args: [],
    );
  }

  //Investment Profile Client’s Investment Portfolio Profile B
  String get InvestmentProfileClientsInvestmentPortfolioProfileB {
    return Intl.message(
      'Investment Profile Clients Investment Portfolio Profile B',
      name: 'Investment Profile Clients Investment Portfolio Profile B',
      desc: '',
      args: [],
    );
  }

  // Client’s Declaration
  String get ClientsDeclaration {
    return Intl.message(
      'Clients Declaration',
      name: 'Clients Declaration',
      desc: '',
      args: [],
    );
  }

  // Company Name
  String get CompanyName {
    return Intl.message(
      'Company Name',
      name: 'Company Name',
      desc: '',
      args: [],
    );
  }

  //Country of Registration
  String get CountryofRegistration {
    return Intl.message(
      'Country of Registration ',
      name: 'Country of Registration ',
      desc: '',
      args: [],
    );
  }

  //Main Business :
  String get MainBusiness {
    return Intl.message(
      'Main Business',
      name: 'Main Business',
      desc: '',
      args: [],
    );
  }

  //Country of Practicing Business :
  String get CountryofPracticingBusiness {
    return Intl.message(
      'Country of Practicing Business',
      name: 'Country of Practicing Business',
      desc: '',
      args: [],
    );
  }

  //Date of Incorporation or Start of Business
  String get DateofIncorporationorStartofBusiness {
    return Intl.message(
      'Date of Incorporation or Start of Business',
      name: 'Date of Incorporation or Start of Business',
      desc: '',
      args: [],
    );
  }

  //Commerical Registration Number or its Equivalent :
  String get CommericalRegistrationNumberoritsEquivalent {
    return Intl.message(
      'Commerical Registration Number or its Equivalent :',
      name: 'Commerical Registration Number or its Equivalent',
      desc: '',
      args: [],
    );
  }

  //Names of Natural Persons who own or control 25% or more of the shares :
  String get NamesofNaturalPersonswhoownorcontrol25ormoreoftheshares {
    return Intl.message(
      'Names of Natural Persons who own or control 25% or more of the shares :',
      name:
          'Names of Natural Persons who own or control 25% or more of the shares :',
      desc: '',
      args: [],
    );
  }

  //Percentage of Ownership
  String get PercentageofOwnership {
    return Intl.message(
      'Percentage of Ownership ',
      name: 'Percentage of Ownership',
      desc: '',
      args: [],
    );
  }

  //Shareholders having 25% ownership or more should complete a separate KYC form.
  String get Shareholdershaving25ownershipormoreshouldcompleteaseparateKYCform {
    return Intl.message(
      'Shareholders having 25% ownership or more should complete a separate KYC form.',
      name:
          'Shareholders having 25% ownership or more should complete a separate KYC form.',
      desc: '',
      args: [],
    );
  }

  //Address for Correspondence
  String get AddressforCorrespondence {
    return Intl.message(
      'Address for Correspondence',
      name: 'Address for Correspondence',
      desc: '',
      args: [],
    );
  }

  //Name of Contract
  String get NameofContract {
    return Intl.message(
      'Name of Contact',
      name: 'Name of Contact',
      desc: '',
      args: [],
    );
  }

  // Any other financial information on the client’s financial situation?
  String get Anyotherfinancialinformationontheclientsfinancialsituation {
    return Intl.message(
      'Any other financial information on the client financial situation?',
      name:
          'Any other financial information on the clients financial situation?',
      desc: '',
      args: [],
    );
  }

  //CustomerExpectation
  String get CustomerExpectation {
    return Intl.message(
      'Customer Expectation',
      name: 'Customer Expectation',
      desc: '',
      args: [],
    );
  }

  //ScopeOfWork
  String get ScopeOfWork {
    return Intl.message(
      'Scope Of Work',
      name: 'Scope Of Work',
      desc: '',
      args: [],
    );
  }

  //Number of Employees
  String get NumberofEmployees {
    return Intl.message(
      'Number of Employees',
      name: 'Number of Employees',
      desc: '',
      args: [],
    );
  }

  //Paid-Up Capital
  String get PaidUpCapital {
    return Intl.message(
      'Paid-Up Capital',
      name: 'Paid-Up Capital',
      desc: '',
      args: [],
    );
  }

  //Annual Turn Over
  String get AnnualTurnOver {
    return Intl.message(
      'Annual Turn Over',
      name: 'Annual Turn Over',
      desc: '',
      args: [],
    );
  }

  String get Others {
    return Intl.message(
      'Others',
      name: 'Others',
      desc: '',
      args: [],
    );
  }

  //
  String get ClientsProfile {
    return Intl.message(
      'Clients Current investment Portfolio Profile',
      name: 'Clients Current investment Portfolio Profile',
      desc: '',
      args: [],
    );
  }

  //
  String get Clientsidealinvestmentportfolioprofile {
    return Intl.message(
      'Client’s ideal investment portfolio profile',
      name: 'Client’s ideal investment portfolio profile',
      desc: '',
      args: [],
    );
  }

  //
  String get DepositsandMurabaha {
    return Intl.message(
      'Depositsand Murabaha',
      name: 'Depositsand Murabaha',
      desc: '',
      args: [],
    );
  }

  //
  String getShares() {
    return Intl.message(
      'Shares',
      name: 'Shares',
      desc: '',
      args: [],
    );
  }

  //
  String getRealEstates() {
    return Intl.message(
      'Real Estates',
      name: 'RealEstates',
      desc: '',
      args: [],
    );
  }

  //
  String getDerivativeContracts() {
    return Intl.message(
      'Derivative Contracts',
      name: 'DerivativeContracts',
      desc: '',
      args: [],
    );
  }

  //
  String getAlternativeInvestments() {
    return Intl.message(
      'Alternative Investments',
      name: 'AlternativeInvestments',
      desc: '',
      args: [],
    );
  }

  //
  String Indicatewherethe() {
    return Intl.message(
      'Indicate where the following \n should be forwarded',
      name: 'Indicate where the following\n should be forwarded',
      desc: '',
      args: [],
    );
  }

  //
  String getClient() {
    return Intl.message(
      'The Client',
      name: 'Client',
      desc: '',
      args: [],
    );
  }

  //
  String getCustodian() {
    return Intl.message(
      'The Custodian',
      name: 'Custodian',
      desc: '',
      args: [],
    );
  }

  //
  String get OthersSpecifyalldetailsasinstructedbyclient {
    return Intl.message(
      'Others : Specify all details as instructed by client',
      name: 'Others : Specify all details as instructed by client',
      desc: '',
      args: [],
    );
  }

  //
  String getCertificates() {
    return Intl.message(
      '     1) Certificates',
      name: '     1) Certificates',
      desc: '',
      args: [],
    );
  }

  //
  String getDividendsOtherIncome() {
    return Intl.message(
      '2) Dividends/Other Income',
      name: '2) DividendsOtherIncome',
      desc: '',
      args: [],
    );
  }

  //
  String getSalesProceeds() {
    return Intl.message(
      '3) Sales Proceeds',
      name: '3) SalesProceeds',
      desc: '',
      args: [],
    );
  }

  //
  String get Pleaseensurethesumofalloftheseshouldbeequalto100 {
    return Intl.message(
      'Please ensure the sum of all of these should be equal to 100.',
      name: 'Please ensure the sum of all of these should be equal to 100.',
      desc: '',
      args: [],
    );
  }

  //
  String get ClientsPreferredInvestments {
    return Intl.message(
      'Client’s Preferred Investments Assets (Check as many as required)',
      name: 'Client’s Preferred Investments Assets (Check as many as required)',
      desc: '',
      args: [],
    );
  }

  //
  String getDenominatedInSaudiRiyals() {
    return Intl.message(
      'Denominated in Saudi Riyals',
      name: 'DenominatedInSaudiRiyals',
      desc: '',
      args: [],
    );
  }

  //
  String getDenominatedInForeignCurrency() {
    return Intl.message(
      'Denominated in Foreign Currency',
      name: 'DenominatedInForeignCurrency',
      desc: '',
      args: [],
    );
  }

  //
  String getStateForeignCurrencies() {
    return Intl.message(
      'State the Foreign Currencies',
      name: 'StateForeignCurrencies',
      desc: '',
      args: [],
    );
  }

  //
  String get Theperiodduringwhich {
    return Intl.message(
      'The period during which the client expects to cash out his invested money',
      name:
          'The period during which the client expects to cash out his invested money',
      desc: '',
      args: [],
    );
  }

  //
  String getShortTermLessThanOneYear() {
    return Intl.message(
      'Short Term (less than 1 year)',
      name: 'ShortTermLessThanOneYear',
      desc: '',
      args: [],
    );
  }

  //
  String getMediumTermOneToFiveYears() {
    return Intl.message(
      'Medium Term (1 year – 5 years)',
      name: 'MediumTermOneToFiveYears',
      desc: '',
      args: [],
    );
  }

  //
  String getLongTermMoreThanFiveYears() {
    return Intl.message(
      'Long Term (more than 5 years)',
      name: 'LongTermMoreThanFiveYears',
      desc: '',
      args: [],
    );
  }

//
  String getOtherConstraints() {
    return Intl.message(
      'Other Constraints',
      name: 'OtherConstraints',
      desc: '',
      args: [],
    );
  }

//
  String
      ClientspreferenceandotherconstraintsmayincludeasexampleShariacompliantinvestmentsetcoranyotherconstraintsdesiredbytheclient() {
    return Intl.message(
      'Clients’ preferences and other constraints may include, as example Sharia compliant investments etc. or any other constraints desired by the client.',
      name:
          'Clients’ preferences and other constraints may include, as example Sharia compliant investments etc. or any other constraints desired by the client.',
      desc: '',
      args: [],
    );
  }

  //
  String get browse {
    return Intl.message(
      'Browse',
      name: 'Browse',
      desc: '',
      args: [],
    );
  }

//
  String get Signatureinthepresenceof {
    return Intl.message(
      'Signature in the presence of (Portfolio Manager)',
      name: 'Signature in the presence of (Portfolio Manager)',
      desc: '',
      args: [],
    );
  }

//
  String get complainceApproved {
    return Intl.message(
      'complaince Approved',
      name: 'complaince Approved',
      desc: '',
      args: [],
    );
  }

  //
  String get FundFundDetails {
    return Intl.message(
      'Fund Details',
      name: 'Fund Details',
      desc: '',
      args: [],
    );
  }

  String get IndividualOrInstitutional {
    return Intl.message(
      'Individual / Institutional',
      name: 'IndividualOrInstitutional',
      desc: '',
      args: [],
    );
  }

////
  String get termsAndCondtionsFatca {
    return Intl.message(
      'We hereby certify that the information provided in this form is true, correct, complete, comprehensive, valid, and non-misleading, and acknowledge that EBC will rely on it until notice of revocation and receipt of an update form. We confirm that EBC, its employees or directors are not liable for any damages resulting from reliance on this information. We completed this form willingly without EBCs help, and understand that false or misleading information may result in rejection of our application or appropriate action',
      name:
          'We hereby certify the information that I/we have provided in this form is true, correct, complete, comprehensive, valid and non- misleading. \n We acknowledge that EBC will relyon the information provided in this form until notice in writing satisfactory to EBC of its revocation and by submission of an update self-certification and declaration form is received by EBC, immediate were any change in circumstances occurs. We confirm, that under no circumstances, shall EBC, its employees or directors be liable for any direct, indirect, incidental, special, punitive or consequential damages that may result in any way from their reliance on the information that we have provided. We confirm that we have completed and provided this form willingly without advice or help from EBC. We understand that providing false information, withholding relevant information or responding in a misleading way may result in rejection of our application and/or other appropriate action taken against us.',
      desc: '',
      args: [],
    );
  }

  String get SignUp {
    return Intl.message(
      'Sign Up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  String get UserName {
    return Intl.message(
      'User Name',
      name: 'UserName',
      desc: '',
      args: [],
    );
  }

  String get CompanyEmail {
    return Intl.message(
      'Company Email',
      name: 'CompanyEmail',
      desc: '',
      args: [],
    );
  }

  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  String get Alreadyhaveanaccount {
    return Intl.message(
      'Already have an account? ',
      name: 'Alreadyhaveanaccount',
      desc: '',
      args: [],
    );
  }

  String get DontHaveAnAcc {
    return Intl.message(
      'Create New Account ',
      name: 'DontHaveAnAcc',
      desc: '',
      args: [],
    );
  }

  String get LogIn {
    return Intl.message(
      'Log in? ',
      name: 'LogIn',
      desc: '',
      args: [],
    );
  }

  String get SignIn {
    return Intl.message(
      'Sign in? ',
      name: 'SignIn',
      desc: '',
      args: [],
    );
  }

  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  String get PasswordDoNotMatch {
    return Intl.message(
      'Password Do Not Match',
      name: 'PasswordDoNotMatch',
      desc: '',
      args: [],
    );
  }
  // Dashboards-------------

  String get AddNew {
    return Intl.message(
      'Add New',
      name: 'AddNew',
      desc: '',
      args: [],
    );
  }

  String get Progress {
    return Intl.message(
      'Progress',
      name: 'Progress',
      desc: '',
      args: [],
    );
  }

  String get Salesofthelastweek {
    return Intl.message(
      'Sales of the last week',
      name: 'Salesofthelastweek',
      desc: '',
      args: [],
    );
  }

  String get TotalSalesLead {
    return Intl.message(
      'Total sales lead',
      name: 'TotalSalesLead',
      desc: '',
      args: [],
    );
  }

  String get AverageBestseller {
    return Intl.message(
      'Average best seller',
      name: 'AverageBestseller',
      desc: '',
      args: [],
    );
  }

  String get AuthorsWithTheBestSales {
    return Intl.message(
      'Authors with the best sales',
      name: 'AuthorsWithTheBestSales',
      desc: '',
      args: [],
    );
  }

  String get increasedOnWeekToWeekReports {
    return Intl.message(
      '40% increased on week-to-week reports',
      name: 'increasedOnWeekToWeekReports',
      desc: '',
      args: [],
    );
  }

  String get PitstopEmailMarketing {
    return Intl.message(
      'Pitstop Email Marketing',
      name: 'PitstopEmailMarketing',
      desc: '',
      args: [],
    );
  }

  String get AllKYC {
    return Intl.message(
      'All KYC',
      name: 'AllKYC',
      desc: '',
      args: [],
    );
  }

  String get PendingKYC {
    return Intl.message(
      'Pending KYC',
      name: 'PendingKYC',
      desc: '',
      args: [],
    );
  }

  String get CompleteKYC {
    return Intl.message(
      'Complete KYC',
      name: 'CompleteKYC',
      desc: '',
      args: [],
    );
  }

  String get UserRegistration {
    return Intl.message(
      'User Registration',
      name: 'UserRegistration',
      desc: '',
      args: [],
    );
  }

  String get NewUser {
    return Intl.message(
      'New User',
      name: 'NewUser',
      desc: '',
      args: [],
    );
  }

  String get ShowByAll {
    return Intl.message(
      'Show By All',
      name: 'ShowByAll',
      desc: '',
      args: [],
    );
  }

  String get StockDetail {
    return Intl.message(
      'Stock Detail',
      name: 'StockDetail',
      desc: '',
      args: [],
    );
  }

  String get ShowByMonth {
    return Intl.message(
      'Show By Month',
      name: 'ShowByMonth',
      desc: '',
      args: [],
    );
  }

  String get SalesDetails {
    return Intl.message(
      'Sales Details',
      name: 'SalesDetails',
      desc: '',
      args: [],
    );
  }

  String get AuthorSales {
    return Intl.message(
      'Author sales',
      name: 'AuthorSales',
      desc: '',
      args: [],
    );
  }

  String get AverageBid {
    return Intl.message(
      'Average Bid',
      name: 'AverageBid',
      desc: '',
      args: [],
    );
  }

  String get Commission {
    return Intl.message(
      'Commission',
      name: 'Commission',
      desc: '',
      args: [],
    );
  }

  String get AllTimeSales {
    return Intl.message(
      'All Time Sales',
      name: 'AllTimeSales',
      desc: '',
      args: [],
    );
  }

  String get CopyOfGuardianDeed {
    return Intl.message(
      'Copy Of Guardians Deed',
      name: 'Copy Of Guardians Deed',
      desc: '',
      args: [],
    );
  }

  String get IqamaIdifForeginResidentUnder18 {
    return Intl.message(
      'Iqama Id (if Foregin Resident Under 18)',
      name: 'Iqama Id (if Foregin Resident Under 18)',
      desc: '',
      args: [],
    );
  }

  String get Thecommercialregisterissuedbythecompetentauthority {
    return Intl.message(
      'The commercial register issued by the competent authority',
      name: 'The commercial register issued by the competent authority',
      desc: '',
      args: [],
    );
  }

  String
      get Thecompanysarticlesofassociationbylawsandtheirannexesandamendments {
    return Intl.message(
      'The companys articles of association, bylaws, and their annexes and amendments',
      name:
          'The companys articles of association, bylaws, and their annexes and amendments',
      desc: '',
      args: [],
    );
  }

  String get ListofBoardOfDirectorsSeniorManagers {
    return Intl.message(
      'List of Board Of Directors & Senior Managers',
      name: 'List of Board Of Directors & Senior Managers',
      desc: '',
      args: [],
    );
  }

  String get GCCMS4 {
    return Intl.message(
      'The Board of Directors or partners resolution approving the opening of the investment account and assigning authorised signatories to operate the investment account',
      name:
          'The Board of Directors or partners resolution approving the opening of the investment account and assigning authorised signatories to operate the investment account',
      desc: '',
      args: [],
    );
  }

  String get GCCMS5 {
    return Intl.message(
      'A list of authorised signatories to operate the investment account in accordance with the companys commercial register, articles of association, bylaws and the Board of Directors resolution',
      name:
          'A list of authorised signatories to operate the investment account in accordance with the companys commercial register, articles of association, bylaws and the Board of Directors resolution',
      desc: '',
      args: [],
    );
  }

  String get GCCMS6 {
    return Intl.message(
      'Any licenses issued for the company by any government entity to conduct certain activities',
      name:
          'Any licenses issued for the company by any government entity to conduct certain activities',
      desc: '',
      args: [],
    );
  }

  String get SwapAgreement {
    return Intl.message(
      'Swap Agreement',
      name: 'Swap Agreement',
      desc: '',
      args: [],
    );
  }

  String get QFI1 {
    return Intl.message(
      'The license or the commercial register for the foreign investor obtained from the relevant authority in the county of establishment',
      name:
          'The license or the commercial register for the foreign investor obtained from the relevant authority in the county of establishment',
      desc: '',
      args: [],
    );
  }

  String get QFI2 {
    return Intl.message(
      'The by-laws and its annexes, or a copy of the article of association and its annexes',
      name:
          'The by-laws and its annexes, or a copy of the article of association and its annexes',
      desc: '',
      args: [],
    );
  }

  String get QFI3 {
    return Intl.message(
      'A list of the names of the legal entitys managers and authorised signatories on behalf of the foreign investor in regard to the account',
      name:
          'A list of the names of the legal entitys managers and authorised signatories on behalf of the foreign investor in regard to the account',
      desc: '',
      args: [],
    );
  }

  String get QFI4 {
    return Intl.message(
      ' A delegation from the Board of Directors specifying names of authorised signatories in relation to the account',
      name:
          ' A delegation from the Board of Directors specifying names of authorised signatories in relation to the account',
      desc: '',
      args: [],
    );
  }

  String get TheFundByLaws {
    return Intl.message(
      'The Fund By Laws',
      name: 'The Fund By Laws',
      desc: '',
      args: [],
    );
  }

  String get FGE1 {
    return Intl.message(
      'The issued resolution assigning the authorised signatories to open and operate the investment account of the fund and their valid identity documents',
      name:
          'The issued resolution assigning the authorised signatories to open and operate the investment account of the fund and their valid identity documents',
      desc: '',
      args: [],
    );
  }

  String get FGE2 {
    return Intl.message(
      'The funds articles of association (if any) and its annexes, which clearly show the structure ofthe funds capital and its management',
      name:
          'The funds articles of association (if any) and its annexes, which clearly show the structure of the funds capital and its management',
      desc: '',
      args: [],
    );
  }

  String get FGE3 {
    return Intl.message(
      'Documents that show the names of members of the Board of Directors',
      name:
          'Documents that show the names of members of the Board of Directors',
      desc: '',
      args: [],
    );
  }

  String get ThelicenseissuedbytheCompetentauthority {
    return Intl.message(
      'The license issued by the competent authority',
      name: 'The license issued by the competent authority',
      desc: '',
      args: [],
    );
  }

  String get Endowment1 {
    return Intl.message(
      'The deed of endowment and the deed of trusteeship',
      name: 'The deed of endowment and the deed of trusteeship',
      desc: '',
      args: [],
    );
  }

  String get Endowment2 {
    return Intl.message(
      'National identification card of the endowments trustee / board of trustees',
      name:
          'National identification card of the endowments trustee / board of trustees',
      desc: '',
      args: [],
    );
  }

  String get Endowment3 {
    return Intl.message(
      'The resolution of the trustee or the board of trustees approving the opening of the investment account',
      name:
          'The resolution of the trustee or the board of trustees approving the opening of the investment account',
      desc: '',
      args: [],
    );
  }

  String get Endowment4 {
    return Intl.message(
      'Permission letter from Governmental authority to invest in securities',
      name:
          'Permission letter from Governmental authority to invest in securities',
      desc: '',
      args: [],
    );
  }

  String get GE1 {
    return Intl.message(
      'Documents (according to administrative regulations & relevant laws)',
      name:
          'Documents (according to administrative regulations & relevant laws)',
      desc: '',
      args: [],
    );
  }

  String get GE2 {
    return Intl.message(
      'ID of authorised signatories',
      name: 'ID of authorised signatories',
      desc: '',
      args: [],
    );
  }

  String get GE3 {
    return Intl.message(
      'Approval of Ministry of Finance (or its equivalent in the GCC member state)',
      name:
          'Approval of Ministry of Finance (or its equivalent in the GCC member state)',
      desc: '',
      args: [],
    );
  }

  String get IOI1 {
    return Intl.message(
      'The Association Agreement and/or bylaws',
      name: 'The Association Agreement and/or bylaws',
      desc: '',
      args: [],
    );
  }

  String get IOI2 {
    return Intl.message(
      'The premises agreement signed with the Government of the Kingdom that permits the International organisation or institution to invest in securities',
      name:
          'The premises agreement signed with the Government of the Kingdom that permits the International organisation or institution to invest in securities',
      desc: '',
      args: [],
    );
  }

  String get IOI3 {
    return Intl.message(
      'The resolution of the competent person in accordance with the Association Agreement and/or bylaws assigning the authorised signatories to open and operate the investment account',
      name:
          'The resolution of the competent person in accordance with the Association Agreement and/or bylaws assigning the authorised signatories to open and operate the investment account',
      desc: '',
      args: [],
    );
  }

  String get IF1 {
    return Intl.message(
      'The Bylaws or Articles of Association of the fund manager and any amendments to them',
      name:
          'The Bylaws or Articles of Association of the fund manager and any amendments to them',
      desc: '',
      args: [],
    );
  }

  String get IF2 {
    return Intl.message(
      'The authorization issued by the Authority or the competent authority in the GCC member state for the fund manager to conduct managing activities and the commencement letter',
      name:
          'The authorization issued by the Authority or the competent authority in the GCC member state for the fund manager to conduct managing activities and the commencement letter',
      desc: '',
      args: [],
    );
  }

  String get IF3 {
    return Intl.message(
      'Approval of investment fund establishment',
      name: 'Approval of investment fund establishment',
      desc: '',
      args: [],
    );
  }

  String get IF4 {
    return Intl.message(
      'The investment funds Terms and Conditions and any amendments to them',
      name:
          'The investment funds Terms and Conditions and any amendments to them',
      desc: '',
      args: [],
    );
  }

  String get AuthorityApproval {
    return Intl.message(
      'Authority Approval',
      name: 'Authority Approval',
      desc: '',
      args: [],
    );
  }

  String get ANBBankAccountAllocation {
    return Intl.message(
      'Client\'s Investment Account',
      name: 'ANB Bank Account Allocation',
      desc: '',
      args: [],
    );
  }

  String get DPMNDPM {
    return Intl.message(
      'DPM / NDPM',
      name: 'DPMNDPM',
      desc: '',
      args: [],
    );
  }

  String get NDPM {
    return Intl.message(
      'NDPM',
      name: 'NDPM',
      desc: '',
      args: [],
    );
  }

  String get DPM {
    return Intl.message(
      'DPM',
      name: 'DPM',
      desc: '',
      args: [],
    );
  }
  // Fund Subscribe

  String get FundSubscribe {
    return Intl.message(
      'Fund Subscription',
      name: 'FundSubscribe',
      desc: '',
      args: [],
    );
  }

  String get Amount {
    return Intl.message(
      'Amount',
      name: 'Amount',
      desc: '',
      args: [],
    );
  }

  String get Subscribe {
    return Intl.message(
      'Subscribe',
      name: 'Subscribe',
      desc: '',
      args: [],
    );
  }

  String get Reedem {
    return Intl.message(
      'Redeem',
      name: 'Reedem',
      desc: '',
      args: [],
    );
  }

  String get FundReedem {
    return Intl.message(
      'Fund Redemption',
      name: 'FundReedem',
      desc: '',
      args: [],
    );
  }

  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  String get RegistrationNo {
    return Intl.message(
      'Registration No.',
      name: 'RegistrationNo',
      desc: '',
      args: [],
    );
  }

  String get UnifiedNo {
    return Intl.message(
      'Unified No.',
      name: 'UnifiedNo',
      desc: '',
      args: [],
    );
  }

  String get LicenseNo {
    return Intl.message(
      'License No.',
      name: 'LicenseNo',
      desc: '',
      args: [],
    );
  }

  String get Auditor {
    return Intl.message(
      'Auditor',
      name: 'Auditor',
      desc: '',
      args: [],
    );
  }

  String get LegalCounsel {
    return Intl.message(
      'Legal Counsel',
      name: 'LegalCounsel',
      desc: '',
      args: [],
    );
  }

  String get EstablishmentExpenses {
    return Intl.message(
      'Establishment Expenses',
      name: 'EstablishmentExpenses',
      desc: '',
      args: [],
    );
  }

  String get EntryFee {
    return Intl.message(
      'Entry Fee',
      name: 'EntryFee',
      desc: '',
      args: [],
    );
  }

  String get ManagementFee {
    return Intl.message(
      'Management Fee',
      name: 'ManagementFee',
      desc: '',
      args: [],
    );
  }

  String get PerformanceFees {
    return Intl.message(
      'Performance Fees ',
      name: 'PerformanceFees',
      desc: '',
      args: [],
    );
  }

  String get CustodyFees {
    return Intl.message(
      'Custody Fees ',
      name: 'CustodyFees',
      desc: '',
      args: [],
    );
  }

  String get FundOperatorFees {
    return Intl.message(
      'Fund Operator Fees',
      name: 'FundOperatorFees',
      desc: '',
      args: [],
    );
  }

  String get AudtiorFees {
    return Intl.message(
      'Auditor Fees ',
      name: 'AudtiorFees',
      desc: '',
      args: [],
    );
  }

  String get TradingFees {
    return Intl.message(
      'Trading Fees',
      name: 'TradingFees',
      desc: '',
      args: [],
    );
  }

  String get ArrangingFinancing {
    return Intl.message(
      'Arranging Financing',
      name: 'ArrangingFinancing',
      desc: '',
      args: [],
    );
  }

  String get OtherExpenses {
    return Intl.message(
      'Other Expenses',
      name: 'OtherExpenses',
      desc: '',
      args: [],
    );
  }

  String get TemplateName {
    return Intl.message(
      'Template Name',
      name: 'TemplateName',
      desc: '',
      args: [],
    );
  }

  String get masterService {
    return Intl.message(
      'Master  Service',
      name: 'masterService',
      desc: '',
      args: [],
    );
  }

  String get Services {
    return Intl.message(
      'Services',
      name: 'Services',
      desc: '',
      args: [],
    );
  }

  String get FundOperator {
    return Intl.message(
      'Fund Operator',
      name: 'FundOperator',
      desc: '',
      args: [],
    );
  }

  String get AgreementSearch {
    return Intl.message(
      'Agreement Search',
      name: 'Agreement Search',
      desc: '',
      args: [],
    );
  }

  String get EnterTemplateName {
    return Intl.message(
      'Enter Template Name',
      name: 'EnterTemplateName',
      desc: '',
      args: [],
    );
  }

  String get AgreementTemplateUpload {
    return Intl.message(
      'Agreement Upload',
      name: 'AgreementTemplateUpload',
      desc: '',
      args: [],
    );
  }

  String get KYCUpload {
    return Intl.message(
      'KYC Upload',
      name: 'KYCUpload',
      desc: '',
      args: [],
    );
  }

  String get CustomerSearch {
    return Intl.message(
      'Client Search',
      name: 'CustomerSearch',
      desc: '',
      args: [],
    );
  }

  String get expenseTracker {
    return Intl.message(
      'Expense Tracker',
      name: 'expenseTracker',
      desc: '',
      args: [],
    );
  }

  String get expensecategory {
    return Intl.message(
      'Expense Category',
      name: 'expensecategory',
      desc: '',
      args: [],
    );
  }

  String get expenseAmt {
    return Intl.message(
      'Expense Amount',
      name: 'expenseAmt',
      desc: '',
      args: [],
    );
  }

  String get expenseDescription {
    return Intl.message(
      'Expense description',
      name: 'expenseDescription',
      desc: '',
      args: [],
    );
  }

  String get expenseName {
    return Intl.message(
      'Expense Name',
      name: 'expenseName',
      desc: '',
      args: [],
    );
  }

  String get Creation {
    return Intl.message(
      'Creation',
      name: 'Creation',
      desc: '',
      args: [],
    );
  }

  String get subServiceCreation {
    return Intl.message(
      'Sub Service\nCreation',
      name: 'subServiceCreation',
      desc: '',
      args: [],
    );
  }

  String get List {
    return Intl.message(
      'List',
      name: 'List',
      desc: '',
      args: [],
    );
  }

  String get FundSearch {
    return Intl.message(
      'Fund Search',
      name: 'FundSearch',
      desc: '',
      args: [],
    );
  }

  String get ClientRegistrationDate {
    return Intl.message(
      'Client Registration Date',
      name: 'ClientRegistrationDate',
      desc: '',
      args: [],
    );
  }

  String get FromDate {
    return Intl.message(
      'From Date',
      name: 'FromDate',
      desc: '',
      args: [],
    );
  }

  String get ToDate {
    return Intl.message(
      'To Date',
      name: 'ToDate',
      desc: '',
      args: [],
    );
  }

  String get subscriptionPeriod {
    return Intl.message(
      'Subscription Period',
      name: 'subscriptionPeriod',
      desc: '',
      args: [],
    );
  }

  String get FundStatus {
    return Intl.message(
      'Fund Status',
      name: 'FundStatus',
      desc: '',
      args: [],
    );
  }

  String get TotalValueOfFund {
    return Intl.message(
      'Total Value of Fund',
      name: 'TotalValueOfFund',
      desc: '',
      args: [],
    );
  }

  String get AgreementSavedSuccessfully {
    return Intl.message(
      'Agreement Saved Successfully',
      name: 'AgreementSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  String get SomethingWentWrong {
    return Intl.message(
      'Something Went Wrong',
      name: 'SomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  String get SearchDraft {
    return Intl.message(
      'Search Draft',
      name: 'SearchDraft',
      desc: '',
      args: [],
    );
  }

  String get Drafts {
    return Intl.message(
      'Drafts',
      name: 'Drafts',
      desc: '',
      args: [],
    );
  }

  String get ClientCompany {
    return Intl.message(
      'Client/Company',
      name: 'ClientCompany',
      desc: '',
      args: [],
    );
  }

  String get FirstNameCompanyName {
    return Intl.message(
      'First Name/Company Name',
      name: 'FirstNameCompanyName',
      desc: '',
      args: [],
    );
  }

  String get FatherNameMainBusinessName {
    return Intl.message(
      'Father\'s Name/Business Name',
      name: 'FatherNameMainBusinessName',
      desc: '',
      args: [],
    );
  }

  String get SelectAgreementName {
    return Intl.message(
      'Select Agreement Name',
      name: 'SelectAgreementName',
      desc: '',
      args: [],
    );
  }

  String get AgreementUpload {
    return Intl.message(
      'Agreement Upload',
      name: 'AgreementUpload',
      desc: '',
      args: [],
    );
  }

  String get CustomerDPMAgreement {
    return Intl.message(
      'Customer DPM Agreement',
      name: 'CustomerDPMAgreement',
      desc: '',
      args: [],
    );
  }

  String get AgreementId {
    return Intl.message(
      'Agreement Id',
      name: 'AgreementId',
      desc: '',
      args: [],
    );
  }

  String get AgreementName {
    return Intl.message(
      'Agreement Name',
      name: 'AgreementName',
      desc: '',
      args: [],
    );
  }

  String get CreateNew {
    return Intl.message(
      'Create New',
      name: 'CreateNew',
      desc: '',
      args: [],
    );
  }

  String get ClientId {
    return Intl.message(
      'Client Id',
      name: 'ClientId',
      desc: '',
      args: [],
    );
  }

  String get DPMAgreementTemplateUpload {
    return Intl.message(
      'DPM Agreement Template Upload',
      name: 'DPMAgreementTemplateUpload',
      desc: '',
      args: [],
    );
  }

  String get ShareDetails {
    return Intl.message(
      'Share Details',
      name: 'ShareDetails',
      desc: '',
      args: [],
    );
  }

  String get ShareCode {
    return Intl.message(
      ' Share Code',
      name: 'ShareCode',
      desc: '',
      args: [],
    );
  }

  String get ShareName {
    return Intl.message(
      'Share Name',
      name: 'ShareName',
      desc: '',
      args: [],
    );
  }

  String get ShareClassification {
    return Intl.message(
      'Share Classification',
      name: 'ShareClassification',
      desc: '',
      args: [],
    );
  }

  String get ShareType {
    return Intl.message(
      'Share Type',
      name: 'ShareType',
      desc: '',
      args: [],
    );
  }

  String get ShareAllotment {
    return Intl.message(
      'Share Allotment',
      name: 'Share Allotment',
      desc: '',
      args: [],
    );
  }

  String get ShareCategory {
    return Intl.message(
      'Share Category',
      name: 'Share Category',
      desc: '',
      args: [],
    );
  }

  String get LockingPeriod {
    return Intl.message(
      'Locking Period',
      name: 'LockingPeriod',
      desc: '',
      args: [],
    );
  }

  String get TotalValueOfShare {
    return Intl.message(
      'Total Value Of Share',
      name: 'TotalValueOfShare',
      desc: '',
      args: [],
    );
  }

  String get ShareOperatorFees {
    return Intl.message(
      'Share Operator Fees',
      name: 'ShareOperatorFees',
      desc: '',
      args: [],
    );
  }

  String get ShareDetailShareClassification {
    return Intl.message(
      'Share Detail & Share Classification',
      name: 'ShareDetailShareClassification',
      desc: '',
      args: [],
    );
  }

  String get ShareFinancialDetail {
    return Intl.message(
      'Share Financial Detail',
      name: 'ShareFinancialDetail',
      desc: '',
      args: [],
    );
  }

  String get ShareFeesDetails {
    return Intl.message(
      'Share Fees Details',
      name: 'ShareFeesDetails',
      desc: '',
      args: [],
    );
  }

  String get ShareBankDetail {
    return Intl.message(
      'Share Bank Detail',
      name: 'ShareBankDetail',
      desc: '',
      args: [],
    );
  }

  String get ShareCreation {
    return Intl.message(
      'Product Creation',
      name: 'ShareCreation',
      desc: '',
      args: [],
    );
  }

  String get AssignPortfolioManager {
    return Intl.message(
      'Assign Portfolio Manager',
      name: 'AssignPortfolioManager',
      desc: '',
      args: [],
    );
  }

  String get PortfolioManagerName {
    return Intl.message(
      'Portfolio Manager Name',
      name: 'PortfolioManagerName',
      desc: '',
      args: [],
    );
  }

  String get PortfolioManagerSearch {
    return Intl.message(
      'Portfolio Manager Search',
      name: 'PortfolioManagerSearch',
      desc: '',
      args: [],
    );
  }

  String get StockSearch {
    return Intl.message(
      'Stock Search',
      name: 'StockSearch',
      desc: '',
      args: [],
    );
  }

  String get StockName {
    return Intl.message(
      'Stock Name',
      name: 'StockName',
      desc: '',
      args: [],
    );
  }

  String get DPMSell {
    return Intl.message(
      'DPM Sell',
      name: 'DPMSell',
      desc: '',
      args: [],
    );
  }

  String get Sell {
    return Intl.message(
      'Sell',
      name: 'Sell',
      desc: '',
      args: [],
    );
  }

  String get DPMBuy {
    return Intl.message(
      'DPM Buy',
      name: 'DPMBuy',
      desc: '',
      args: [],
    );
  }

  String get NDPMBuy {
    return Intl.message(
      'NDPM Buy',
      name: 'NDPMBuy',
      desc: '',
      args: [],
    );
  }

  String get CustomerNDPMAgreement {
    return Intl.message(
      'Customer NDPM Agreement',
      name: 'CustomerNDPMAgreement',
      desc: '',
      args: [],
    );
  }

  String get NDPMSell {
    return Intl.message(
      'NDPM Sell',
      name: 'NDPMSell',
      desc: '',
      args: [],
    );
  }

  String get Buy {
    return Intl.message(
      'Buy',
      name: 'Buy',
      desc: '',
      args: [],
    );
  }

  String get PortfolioManagerId {
    return Intl.message(
      'Portfolio Manager Id',
      name: 'PortfolioManagerId',
      desc: '',
      args: [],
    );
  }

  String get NDPMAgreementTemplateUpload {
    return Intl.message(
      'NDPM Agreement Template Upload',
      name: 'NDPMAgreementTemplateUpload',
      desc: '',
      args: [],
    );
  }

  String get DPMAgreement {
    return Intl.message(
      'DPM Agreement',
      name: 'DPMAgreement',
      desc: '',
      args: [],
    );
  }

  String get NDPMAgreement {
    return Intl.message(
      'NDPM Agreement',
      name: 'NDPMAgreement',
      desc: '',
      args: [],
    );
  }

  String get ServiceCreation {
    return Intl.message(
      'Service Creation',
      name: 'ServiceCreation',
      desc: '',
      args: [],
    );
  }

  String get DurationOfArranging {
    return Intl.message(
      'Duration Of Arranging',
      name: 'DurationOfArranging',
      desc: '',
      args: [],
    );
  }

  String get ServiceSearch {
    return Intl.message(
      'Service Search',
      name: 'ServiceSearch',
      desc: '',
      args: [],
    );
  }
}

//AdvisoryCreation
String get AdvisoryCreation {
  return Intl.message(
    'Advisory Creation',
    name: 'AdvisoryCreation ',
    desc: '',
    args: [],
  );
}

//AdvisoryDetails
String get AdvisoryDetails {
  return Intl.message(
    'Advisory Details',
    name: 'AdvisoryDetails',
    desc: '',
    args: [],
  );
}

//AdvisoryFeestype
String get AdvisoryFeestype {
  return Intl.message(
    'Advisory Fees type',
    name: 'AdvisoryFeestype',
    desc: '',
    args: [],
  );
}

//ArrangingActivityUpdate
String get ArrangingActivityUpdate {
  return Intl.message(
    'Arranging Activity Update',
    name: 'ArrangingActivityUpdate',
    desc: '',
    args: [],
  );
}

String get ArrangingServiceInitiation {
  return Intl.message(
    'Arranging Service Initiation',
    name: 'ArrangingServiceInitiation',
    desc: '',
    args: [],
  );
}

//FixedAdvisoryFees
String get FixedAdvisoryFees {
  return Intl.message(
    'Fixed Advisory Fees',
    name: 'FixedAdvisoryFees',
    desc: '',
    args: [],
  );
}

//AdvisoryFeesRate
String get AdvisoryFeesRate {
  return Intl.message(
    'Advisory Fees Rate',
    name: 'AdvisoryFeesRate',
    desc: '',
    args: [],
  );
}

//PerformanceAdvisoryFees
String get PerformanceAdvisoryFees {
  return Intl.message(
    'Performance Advisory Fees',
    name: 'PerformanceAdvisoryFees',
    desc: '',
    args: [],
  );
}

//CustodyAdvisoryFees
String get CustodyAdvisoryFees {
  return Intl.message(
    'Custody Advisory Fees',
    name: 'CustodyAdvisoryFees',
    desc: '',
    args: [],
  );
}

//FundOperatorAdvisoryFees
String get FundOperatorAdvisoryFees {
  return Intl.message(
    'Advisory Operator Advisory Fees',
    name: 'FundOperatorAdvisoryFees',
    desc: '',
    args: [],
  );
}

//AudtiorAdvisoryFees
String get AudtiorAdvisoryFees {
  return Intl.message(
    'Audtior Advisory Fees',
    name: 'AudtiorAdvisoryFees',
    desc: '',
    args: [],
  );
}

//CustomerSearchforAdvisory
String get CustomerSearchforAdvisory {
  return Intl.message(
    'Customer Search for Advisory',
    name: 'CustomerSearchforAdvisory',
    desc: '',
    args: [],
  );
}

//CustomerAdvisoryAgreement
String get CustomerAdvisoryAgreement {
  return Intl.message(
    'Customer Advisory Agreement',
    name: 'CustomerAdvisoryAgreement',
    desc: '',
    args: [],
  );
}

//AdvisoryServiceCode
String get AdvisoryServiceCode {
  return Intl.message(
    'Advisory Service Code',
    name: 'AdvisoryServiceCode',
    desc: '',
    args: [],
  );
}

//TradingAdvisoryFees
String get TradingAdvisoryFees {
  return Intl.message(
    'Trading Advisory Fees',
    name: 'TradingAdvisoryFees',
    desc: '',
    args: [],
  );
}

//AdvisoryServiceTotalValue
String get AdvisoryServiceTotalValue {
  return Intl.message(
    'Advisory Service Total Value',
    name: 'AdvisoryServiceTotalValue',
    desc: '',
    args: [],
  );
}

//AgreementTemplateSearch
String get AdvisoryAgreementTemplateSearch {
  return Intl.message(
    'Advisory Agreement Template Search',
    name: 'ServiceStatus',
    desc: '',
    args: [],
  );
}

//AdvisoryFundAgreement
String get AdvisoryFundAgreement {
  return Intl.message(
    'Advisory Advisory Agreement',
    name: 'AdvisoryFundAgreement',
    desc: '',
    args: [],
  );
}

//AdvisoryReedem
String get AdvisoryReedem {
  return Intl.message(
    'Advisory Reedem',
    name: 'AdvisoryReedem',
    desc: '',
    args: [],
  );
}

//AdvisoryRedeem
String get AdvisoryRedeem {
  return Intl.message(
    'Advisory Redeem',
    name: 'AdvisoryRedeem',
    desc: '',
    args: [],
  );
}

//ArrangingFeesDetails
String get ArrangingFeesDetails {
  return Intl.message(
    'Arranging Fees Details',
    name: 'ArrangingFeesDetails',
    desc: '',
    args: [],
  );
}

//ArrangingBankDetails
String get ArrangingBankDetails {
  return Intl.message(
    'Arranging Bank Details',
    name: 'ArrangingBankDetails',
    desc: '',
    args: [],
  );
}

//ArrangingAgreement
String get ArrangingAgreementss {
  return Intl.message(
    'Arranging Agreement',
    name: 'ArrangingAgreement',
    desc: '',
    args: [],
  );
}

//ArrangingCreation
String get ArrangingCreation {
  return Intl.message(
    'Arranging Creation',
    name: 'ArrangingCreation',
    desc: '',
    args: [],
  );
}

//ArrangingDetails
String get ArrangingDetails {
  return Intl.message(
    'Arranging Details',
    name: 'ArrangingDetails',
    desc: '',
    args: [],
  );
}

//CustomerArrangingAgreement
String get CustomerArrangingAgreement {
  return Intl.message(
    'Customer Arranging Agreement',
    name: 'CustomerArrangingAgreement',
    desc: '',
    args: [],
  );
}

//ArrangingRedeem
String get ArrangingRedeem {
  return Intl.message(
    'Arranging Redeem',
    name: 'ArrangingRedeem',
    desc: '',
    args: [],
  );
}

//ArrangingSubscribe
String get ArrangingSubscribe {
  return Intl.message(
    'Arranging Subscribe',
    name: 'ArrangingSubscribe',
    desc: '',
    args: [],
  );
}

//TradingArrangingFees
String get TradingArrangingFees {
  return Intl.message(
    'Trading Arranging Fees',
    name: 'TradingArrangingFees',
    desc: '',
    args: [],
  );
}

//AudtiorArrangingFees
String get AudtiorArrangingFees {
  return Intl.message(
    'Audtior Arranging Fees',
    name: 'AudtiorArrangingFees',
    desc: '',
    args: [],
  );
}

//ArrangingFeestype
String get ArrangingFeestype {
  return Intl.message(
    'Arranging Fees type',
    name: 'ArrangingFeestype',
    desc: '',
    args: [],
  );
}

//FixedArrangingFees
String get FixedArrangingFees {
  return Intl.message(
    'Fixed Arranging Fees',
    name: 'FixedArrangingFees',
    desc: '',
    args: [],
  );
}

//ArrangingFeesRate
String get ArrangingFeesRate {
  return Intl.message(
    'Arranging Fees Rate',
    name: 'ArrangingFeesRate',
    desc: '',
    args: [],
  );
}

//PerformanceArrangingFees
String get PerformanceArrangingFees {
  return Intl.message(
    'Performance Arranging Fees',
    name: 'PerformanceArrangingFees',
    desc: '',
    args: [],
  );
}

//CustodyArrangingFees
String get CustodyArrangingFees {
  return Intl.message(
    'Custody Arranging Fees',
    name: 'PerformanceArrangingFees',
    desc: '',
    args: [],
  );
}

//ArrangingAgreementUpload
String get ArrangingAgreementUpload {
  return Intl.message(
    'Arranging Agreement Upload',
    name: 'ArrangingAgreementUpload',
    desc: '',
    args: [],
  );
}

//ArrangingManagerSearch
String get ArrangingManagerSearchsss {
  return Intl.message(
    'Arranging Manager Search',
    name: 'ArrangingManagerSearch',
    desc: '',
    args: [],
  );
}

//ArrangingServiceTotalValue
String get ArrangingServiceTotalValue {
  return Intl.message(
    'Arranging Service Total Value',
    name: 'ArrangingServiceTotalValue',
    desc: '',
    args: [],
  );
}

//AdvisoryFinancialAdministrationDetails
String get AdvisoryFinancialAdministrationDetails {
  return Intl.message(
    'Advisory Financial Administration Details',
    name: 'AdvisoryFinancialAdministrationDetails',
    desc: '',
    args: [],
  );
}

//AdvisorySubscribe
String get AdvisorySubscribe {
  return Intl.message(
    'Advisory Subscribe',
    name: 'AdvisorySubscribe',
    desc: '',
    args: [],
  );
}

//ArrangingServiceCreation
String get ArrangingServiceCreation {
  return Intl.message(
    'Arranging Service Creation',
    name: 'ArrangingServiceCreation',
    desc: '',
    args: [],
  );
}

//ArrangingFinancialAdministrationDetails
String get ArrangingFinancialAdministrationDetails {
  return Intl.message(
    'Arranging Financial Administration Details',
    name: 'ArrangingFinancialAdministrationDetails',
    desc: '',
    args: [],
  );
}

//FundOperatorArrangingFees
String get FundOperatorArrangingFees {
  return Intl.message(
    'Fund Operator Arranging Fees',
    name: 'FundOperatorArrangingFees',
    desc: '',
    args: [],
  );
}

//AdvisoryAgreementTemplateSearch
String get AdvisoryAgreementTemplateSearc {
  return Intl.message(
    'Advisory Agreement Template Search',
    name: 'AdvisoryAgreementTemplateSearc',
    desc: '',
    args: [],
  );
}

//AdvisoryRedeemSearch
String get AdvisoryRedeemSearch {
  return Intl.message(
    'Advisory Redeem Search',
    name: 'AdvisoryRedeemSearch',
    desc: '',
    args: [],
  );
}

String get AgreementUpload {
  return Intl.message(
    'Agreement Upload',
    name: 'AgreementUpload',
    desc: '',
    args: [],
  );
}

String get EastBridgeCapital {
  return Intl.message(
    'East Bridge Capital',
    name: 'EastBridgeCapital',
    desc: '',
    args: [],
  );
}

String get LandlinePhone {
  return Intl.message(
    'Landline/Phone No.',
    name: 'LandlinePhone',
    desc: '',
    args: [],
  );
}

String get PortfolioName {
  return Intl.message(
    'Portfolio Name',
    name: 'PortfolioName',
    desc: '',
    args: [],
  );
}

String get addCategory {
  return Intl.message(
    'Add Category',
    name: 'addCategory',
    desc: '',
    args: [],
  );
}

String get expenseTracker {
  return Intl.message(
    'Expense Tracker',
    name: 'expenseTracker',
    desc: '',
    args: [],
  );
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
