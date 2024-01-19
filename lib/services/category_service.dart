import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overtimer_mobile/models/category_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CategoryService {
  static Future<void> deleteCategory(int id) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Category/$id');

      var response = await http.delete(url);

      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<CategoryItem>> getCategories() async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Category');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> decodedData = convert.jsonDecode(response.body);

        List<CategoryItem> categories = decodedData
            .map((dynamic jsonCategory) => CategoryItem(
          id: jsonCategory['id'] as int? ?? 0,
          name: jsonCategory['name'] as String? ?? "",
          companyId: jsonCategory['companyId'] as int? ?? 0,
        ))
            .toList();

        return categories;
      } else {
        throw Exception('Falha ao carregar os dados: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<CategoryItem> getCategory(int id) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Category/$id');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        dynamic decodedData = convert.jsonDecode(response.body);

        CategoryItem category = CategoryItem(
          id: decodedData['id'] as int? ?? 0,
          name: decodedData['name'] as String? ?? "",
          companyId: decodedData['companyId'] as int? ?? 0,
        );

        return category;
      } else {
        throw Exception('Falha ao carregar os dados: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> addCategory(String name, int companyId) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Category');

      var headers = {'Content-Type': 'application/json'};

      var requestBody = {
        'companyId': companyId,
        'name': name,
      };

      var response = await http.post(
        url,
        headers: headers,
        body: convert.jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Erro no cadastro da categoria: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception during HTTP request: $e');
    }
  }

  static Future<void> editCategory(int id, String name, int companyId) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Category/$id');

      var headers = {'Content-Type': 'application/json'};

      var requestBody = {
        'companyId': companyId,
        'name': name,
      };

      var response = await http.patch(
        url,
        headers: headers,
        body: convert.jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Categoria editada com sucesso
      } else {
        throw Exception('Erro na edição da categoria: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception during HTTP request: $e');
    }
  }
}
