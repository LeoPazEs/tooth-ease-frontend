import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class ISecureStorage {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
  Future<Map<String, String>> readAll();
}

class SecureStorage implements ISecureStorage {
  final FlutterSecureStorage storage;

  SecureStorage(this.storage);

  @override
  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  @override
  Future<Map<String, String>> readAll() async {
    return await storage.readAll();
  }
}
