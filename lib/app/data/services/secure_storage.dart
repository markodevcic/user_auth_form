import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class SecureStorage {
  static Future<void> writeToken(String token) async {
    return storage.write(key: 'jwt', value: token);
  }

  static Future<String> get getToken async {
    var token = await storage.read(key: "jwt");
    if (token == null) return "";
    return token;
  }

  static Future<void> get deleteToken async {
    return storage.delete(key: "jwt");
  }
}
