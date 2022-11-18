import 'package:intl/intl.dart';

class FormatterService {

  String getDate(DateTime date) => DateFormat.yMEd().format(date);
  String getTime(DateTime date) => DateFormat.Hm().format(date);

  String getType(int type) {
    String value = "";
    switch (type) {
      case 0:
        value = "Lettre Suivie";
        break;
      case 1:
        value = "Lettre Recommandée";
        break;
      default:
        value = "Colis";
    }
    return value;}
}