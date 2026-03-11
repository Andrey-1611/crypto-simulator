import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final urlUtilProvider = Provider((_) => UrlUtil());

class UrlUtil {
  static const rustoreUrl =
      'https://www.rustore.ru/catalog/app/com.example.crypto_simulator';

  void openInRustore() async {
    final uri = Uri.parse(rustoreUrl);
    await launchUrl(uri);
  }
}
