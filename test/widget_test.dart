import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test('Test', () {
    DateFormat format = DateFormat('dd/MM/yyyy');
    DateTime dateTime = DateTime.now();

    print(format.format(dateTime));
  });
}
