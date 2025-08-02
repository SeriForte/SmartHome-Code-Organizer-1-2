import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton2 extends StatelessWidget {
  const LinkButton2({super.key, required this.urlLabel, required this.url});

  final String urlLabel;
  final String url;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        _launchUrl(url);
      },
      child: Text(urlLabel),
    );
  }
}
