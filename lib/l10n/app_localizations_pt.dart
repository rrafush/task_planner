// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get emptyStateMessage => 'Você ainda não tem tarefas! Crie uma!';

  @override
  String get errorMessage => 'Oops! Algo deu errado!';

  @override
  String get title => 'Título';

  @override
  String get description => 'Descrição';

  @override
  String get titleRequired => 'Por favor, insira um título';

  @override
  String get dateNotValid => 'Escolha uma data que não está no passado';

  @override
  String get save => 'Salvar';
}
