// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get emptyStateMessage => 'You have no tasks yet! Create one!';

  @override
  String get errorMessage => 'Oops! Something went wrong!';

  @override
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get titleRequired => 'Please, enter a title';

  @override
  String get dateNotValid => 'Choose a date that is not in the past';

  @override
  String get save => 'Save';
}
