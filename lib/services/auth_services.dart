import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _token = 'AIzaSyBNTjPTQwNEgOgYIVpmPrrgamiGO8ALSH0';
  final storage = new FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _token});

    final res = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedRep = json.decode(res.body);

    if (decodedRep.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodedRep['idToken']);
      return null;
    } else {
      return decodedRep['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {'key': _token});

    final res = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedRep = json.decode(res.body);

    if (decodedRep.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodedRep['idToken']);
      return null;
    } else {
      return decodedRep['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
