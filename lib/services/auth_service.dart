import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCwQYMMlROaHlO12wGuTuIwBxTezL2iBdU';

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(response.body);

    if (decodeResp.containsKey('idToken')) {
      return null; // Login exitoso
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(response.body);

    if (decodeResp.containsKey('idToken')) {
      return null; // Registro exitoso
    } else {
      return decodeResp['error']['message'];
    }
  }
}
