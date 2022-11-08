import 'dart:convert';
import 'package:http/http.dart' as http;

import '../shared/const.dart';

class SMTPService {
  static Future<http.Response> sendMail(String email) {
    return http.post(Uri.https(Const.baseUrl, '/api/mahasiswa/sendmail'),
        body: jsonEncode(<String, String>{
          'email': email,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'AFL-API-KEY': Const.apiKey,
        });
  }
}
