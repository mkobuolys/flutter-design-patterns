import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  const UrlLauncher._();

  static Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not call $url';
    }
  }
}
