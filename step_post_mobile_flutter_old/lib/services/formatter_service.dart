import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:step_post_mobile_flutter/utils/constantes.dart';

class FormatterService {
  final f = DateFormat('dd/MM/yyyy');

  String getDate(DateTime date) => f.format(date);
  String getTime(DateTime date) => DateFormat.Hm().format(date.toLocal());

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
    return value;
  }

  Color getColor(int statut) {
    Color color = const Color(0xff140A82);
    switch (statut) {
      case 5:
        color = kGreen;
        break;
      case 6:
        color = kOrange;
        break;
      case 7:
        color = kYellow;
        break;
      case 8:
        color = kYellow;
        break;
      default:
        break;
    }
    return color;
  }
}



/*


      case 7:
        color = '#FFCC40';
        break;
      case 8:
        color = '#FFCC40';
        break;
 */