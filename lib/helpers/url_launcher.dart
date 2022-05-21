import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlLauncher {
  const UrlLauncher._();

  static Future<void> launchUrl(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null) {
      throw UrlLauncherException('Could not parse $url');
    }

    final canLaunchUrl = await url_launcher.canLaunchUrl(uri);

    if (!canLaunchUrl) {
      throw UrlLauncherException('Could not launch $uri');
    }

    try {
      await url_launcher.launchUrl(uri);
    } on Exception catch (e, st) {
      throw UrlLauncherException('Error while launching URL: $e\n$st');
    }
  }
}

class UrlLauncherException implements Exception {
  final String? message;

  const UrlLauncherException([this.message]);

  @override
  String toString() {
    return 'UrlLauncherException{message: $message}';
  }
}
