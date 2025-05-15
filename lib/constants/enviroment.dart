import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get urlBase {
    return dotenv.env['URL_BASE'] ?? '';
  }
}