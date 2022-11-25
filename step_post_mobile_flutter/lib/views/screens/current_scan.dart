import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_post_mobile_flutter/repositories/scan_result_repository.dart';
import 'package:step_post_mobile_flutter/views/widgets/mail_card.dart';

class CurrentScan extends StatelessWidget {
  const CurrentScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mail = context.watch<ScanResultRepository>().mail;
    return
      mail != null
      ? MailCard(mail: mail!)
      : SizedBox();
  }
}
