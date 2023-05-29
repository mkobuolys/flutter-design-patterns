import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlLauncher {
  const UrlLauncher._();

  static Future<void> launchPersonalPage() => launchUrl(
        'https://kazlauskas.dev',
      );

  static Future<void> launchFlutterDesignPatternsIntroductionPage() =>
      launchUrl(
        'https://kazlauskas.dev/flutter-design-patterns-0-introduction',
      );

  static Future<void> launchUrl(String url) async {
    final uri = Uri.tryParse(url);

    if (uri == null) {
      throw UrlLauncherException('Could not parse $url');
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
