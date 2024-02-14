import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overtimer_mobile/models/role_info.dart';
import 'package:overtimer_mobile/models/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthService {
  static Future<void> Login(String email, String password) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Auth/login');

      var headers = {
        'Content-Type': 'application/json',
      };

      var requestBody = {
        'email': email,
        'password': password,
      };

      var response = await http.post(
        url,
        headers: headers,
        body: convert.jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        String token = _getTokenFromResponse(response);
        _saveToken(token);
      } else {
        throw Exception(
            'Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> Logout() async {
    try {
      _deleteToken();
    } catch (e) {
      throw Exception(e);
    }
  }

  static String _getTokenFromResponse(http.Response response) {
    var responseData = convert.jsonDecode(response.body);
    String tokenType = responseData["tokenType"];
    String accessToken = responseData["accessToken"];
    String token = "$tokenType $accessToken";
    return token;
  }

  static _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  static _deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<UserInfo> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Auth/user');

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };

      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonBody = convert.jsonDecode(response.body);

        var roleInfo = RoleInfo(
          id: jsonBody['role']['id'],
          name: jsonBody['role']['name'],
        );

        var userInfo = UserInfo(
          id: jsonBody['id'],
          name: jsonBody['name'],
          email: jsonBody['email'],
          active: jsonBody['active'],
          role: roleInfo,
        );

        return userInfo;
      } else if(response.statusCode == 401) {
        throw response;
      }
      else {
        throw Exception("Falha ao obter informações do usuário");
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    try {
      if (token == null) {
        return false;
      }

      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Auth/verify-token');

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': token,
      };

      var response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
