import 'package:flutter_test/flutter_test.dart';
import 'package:simple_to_do_app/shared/utils/extensions/date_time.dart';

void main() {
  testWidgets('Should format date in english', (tester) async {
    var date = DateTime(2024, 10, 10, 23, 58);
    var formattedDate = date.formatDateToLocale();
    expect(formattedDate, '10/10/2024 at 23:58');

    date = DateTime(2023, 7, 15, 4, 40);
    formattedDate = date.formatDateToLocale();
    expect(formattedDate, '15/07/2023 at 04:40');

    date = DateTime(2020, 12, 3, 6, 30);
    formattedDate = date.formatDateToLocale();
    expect(formattedDate, '03/12/2020 at 06:30');
  });

  testWidgets('Should format date in portuguese', (tester) async {
    var date = DateTime(2024, 10, 10, 23, 58);
    var formattedDate = date.formatDateToLocale(languageCode: 'pt');
    expect(formattedDate, '10/10/2024 às 23:58');

    date = DateTime(2023, 7, 15, 4, 40);
    formattedDate = date.formatDateToLocale(languageCode: 'pt');
    expect(formattedDate, '15/07/2023 às 04:40');

    date = DateTime(2020, 12, 3, 6, 30);
    formattedDate = date.formatDateToLocale(languageCode: 'pt');
    expect(formattedDate, '03/12/2020 às 06:30');
  });
}
