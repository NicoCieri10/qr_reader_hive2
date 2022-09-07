import 'package:data_persistence/data_persistence.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  final _url = Uri.parse(scan.value);

  if (scan.value.contains('http')) {
    // Abrir el sitio web

    if (!await launchUrl(
      _url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $_url';
    }
  } else {
    await Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
