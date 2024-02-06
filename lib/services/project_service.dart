import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overtimer_mobile/models/project_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'auth_service.dart';

class ProjectService {
  static Future<void> deleteProject(int id) async {
    try {
      final apiUrl = dotenv.get("API_URL");
      final url = Uri.http(apiUrl, '/api/Project/$id');

      final token = await AuthService.getToken();

      var response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<ProjectItem>> getProjects() async {
    try {
      final apiUrl = dotenv.get("API_URL");
      final url = Uri.http(apiUrl, '/api/Project');

      final token = await AuthService.getToken();

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> decodedData = convert.jsonDecode(response.body);

        List<ProjectItem> projects = decodedData
            .map((dynamic jsonProject) => ProjectItem(
          id: jsonProject['id'] as int? ?? 0,
          name: jsonProject['name'] as String? ?? "",
          categoryId: jsonProject['categoryId'] as int? ?? 0,
        ))
            .toList();

        return projects;
      } else {
        throw Exception('Falha ao carregar os dados: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<ProjectItem> getProject(int id) async {
    try {
      final apiUrl = dotenv.get("API_URL");
      final url = Uri.http(apiUrl, '/api/Project/$id');

      final token = await AuthService.getToken();

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': '$token',
        },
      );

      if (response.statusCode == 200) {
        dynamic decodedData = convert.jsonDecode(response.body);

        ProjectItem project = ProjectItem(
          id: decodedData['id'] as int? ?? 0,
          name: decodedData['name'] as String? ?? "",
          categoryId: decodedData['categoryId'] as int? ?? 0,
        );

        return project;
      } else {
        throw Exception('Falha ao carregar os dados: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addProject(String name, int categoryId) async {
    try {
      final apiUrl = dotenv.get("API_URL");
      final url = Uri.http(apiUrl, '/api/Project');

      final token = await AuthService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };

      var requestBody = {
        'categoryId': categoryId,
        'name': name,
      };

      var response = await http.post(
        url,
        headers: headers,
        body: convert.jsonEncode(requestBody),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Erro no cadastro do projeto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception during HTTP request: $e');
    }
  }

  static Future<void> editProject(int id, String name, int categoryId) async {
    try {
      final apiUrl = dotenv.get("API_URL");
      final url = Uri.http(apiUrl, '/api/Project/$id');

      final token = await AuthService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };

      var requestBody = {
        'categoryId': categoryId,
        'name': name,
      };

      var response = await http.patch(
        url,
        headers: headers,
        body: convert.jsonEncode(requestBody),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Erro na edição do projeto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception during HTTP request: $e');
    }
  }
}
