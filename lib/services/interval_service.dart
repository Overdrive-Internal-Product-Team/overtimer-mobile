import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overtimer_mobile/models/interval/interval_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class IntervalService {
  static Future<void> deleteTag(int id) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Work/$id');

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

  DateTime _createDateTime(String datetime) {
    return DateTime.parse(datetime);
  }

  Future<List<IntervalItem>> getIntervals() async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/work');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> decodedData = convert.jsonDecode(response.body);

        List<IntervalItem> intervals = decodedData
            .map((dynamic jsonTag) => IntervalItem(
                  id: jsonTag['id'] as int? ?? 0,
                  userId: jsonTag['userId'] as int? ?? 0,
                  projectId: jsonTag['companyId'] as int? ?? 0,
                  tagIds: jsonTag['tags'],
                  title: jsonTag['title'] as String? ?? "",
                  start: _createDateTime(jsonTag['initialDateTime']),
                  end: _createDateTime(jsonTag['finalDateTime']),
                ))
            .toList();

        return intervals;
      } else {
        throw Exception('Falha ao carregar os dados: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  // static Future<TagItem> getTag(int id) async {
  //   try {
  //     var apiUrl = dotenv.get("API_URL");
  //     var url = Uri.http(apiUrl, '/api/Tag/$id');

  //     var response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       dynamic decodedData = convert.jsonDecode(response.body);

  //       TagItem tag = TagItem(
  //         id: decodedData['id'] as int? ?? 0,
  //         name: decodedData['name'] as String? ?? "",
  //         companyId: decodedData['companyId'] as int? ?? 0,
  //       );

  //       return tag;
  //     } else {
  //       throw Exception('Falha ao carregar os dados: ${response.body}');
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> addInterval(IntervalItem interval, int companyId) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/work');

      var headers = {'Content-Type': 'application/json'};

      var requestBody = {
        'userId': interval.userId,
        'projectId': interval.projectId,
        'title': interval.title,
        'initialDateTime': interval.start.toUtc().toIso8601String(),
        'finalDateTime': interval.end.toUtc().toIso8601String(),
        'tagIds': interval.tagIds,
      };

      var response = await http.post(
        url,
        headers: headers,
        body: convert.jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Erro no cadastro da entrada: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception during HTTP request: $e');
    }
  }

  // static Future<void> editTag(int id, String name, int companyId) async {
  //   try {
  //     var apiUrl = dotenv.get("API_URL");
  //     var url = Uri.http(apiUrl, '/api/Tag/$id');

  //     var headers = {'Content-Type': 'application/json'};

  //     var requestBody = {
  //       'companyId': companyId,
  //       'name': name,
  //     };

  //     var response = await http.patch(
  //       url,
  //       headers: headers,
  //       body: convert.jsonEncode(requestBody),
  //     );

  //     if (response.statusCode == 200) {
  //       // Tag editada com sucesso
  //     } else {
  //       throw Exception('Erro na edição da tag: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Exception during HTTP request: $e');
  //   }
  // }
}
