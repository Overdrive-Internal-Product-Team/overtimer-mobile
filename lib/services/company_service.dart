import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:overtimer_mobile/services/auth_service.dart';
import 'dart:convert' as convert;

class CompanyService {
  static Future<Map<String, dynamic>> getCompany() async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Company/1');

      var token = await AuthService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load company data');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.Response?> editCompany(String name, String cnpj) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Company/1');

      var token = await AuthService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };

      var requestBody = {
        'name': name,
        'cnpj': cnpj,
      };

      var response = await http.patch(
        url,
        headers: headers,
        body: convert.jsonEncode(requestBody),
      );

      return response;
    } catch (e) {

      rethrow;
    }
  }
}
