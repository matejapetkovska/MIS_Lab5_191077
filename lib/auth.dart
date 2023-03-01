import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCRVtphQ_nPZmZuN1raaKX7AWtU4U9LoW4');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    var url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCRVtphQ_nPZmZuN1raaKX7AWtU4U9LoW4');
    final response = await http.post(
      url,
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
  }
}
