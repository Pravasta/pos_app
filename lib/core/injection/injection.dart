import 'package:pos_app/core/injection/env.dart';
import 'package:pos_app/main.dart';

class Injection {
  static const String fontFamily = 'Poppins';
  static final String baseURL = env.baseURL;
  static final bool isDevelopment = env.isDevelopMode;
}
