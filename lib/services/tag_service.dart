import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overtimer_mobile/models/tag/tag_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TagService {

  static Future<void> deleteTag(int id) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Tag/$id');

      var response = await http.delete(url);

      if (response.statusCode == 200) {
      } else {
        throw Exception('Status code: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<TagItem>> getTags() async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Tag');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> decodedData = convert.jsonDecode(response.body);

        List<TagItem> tags = decodedData
            .map((dynamic jsonTag) => TagItem(
          id: jsonTag['id'] as int? ?? 0,
          name: jsonTag['name'] as String? ?? "",
          companyId: jsonTag['companyId'] as int? ?? 0,
        )).toList();

        return tags;
      } else {
        throw Exception('Falha ao carregar os dados: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

}
