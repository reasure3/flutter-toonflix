import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher.dart';

String parseHtmlText(String html) => parseFragment(html).text ?? html;

void awaitLaunchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
