import 'package:flutter_dotenv/flutter_dotenv.dart';

//Clase para obtener la url base de la API
class Environment {
  static String get urlBase {
    return dotenv.env['URL_BASE'] ?? '';
  }
}