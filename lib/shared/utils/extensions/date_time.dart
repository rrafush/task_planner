extension Formatter on DateTime {
  String formatDateToLocale({String languageCode = 'en'}) {
    final connection = languageCode == 'pt' ? 'às' : 'at';
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year $connection ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
