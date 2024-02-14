import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:overtimer_mobile/models/interval/interval_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:overtimer_mobile/models/tag_item.dart';
import 'auth_service.dart';

class IntervalService {
  static Future<void> deleteInterval(int id) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Work/$id');

      var token = await AuthService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };

      var response = await http.delete(url, headers: headers);

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

  List<TagItem> _getTagIds(List intervalTags) {
    return intervalTags.map((tag) {
      return TagItem(
          id: tag['id'] as int,
          name: tag['name'] as String,
          companyId: tag['companyId'] as int);
    }).toList();
  }

  Future<List<IntervalItem>> getIntervals() async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/work');

      var token = await AuthService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> decodedData = convert.jsonDecode(response.body);

        List<IntervalItem> intervals = decodedData
            .map((dynamic jsonInterval) => IntervalItem(
                  id: jsonInterval['id'] as int? ?? 0,
                  userId: jsonInterval['userId'] as int? ?? 0,
                  projectId: jsonInterval['companyId'] as int? ?? 0,
                  tagIds: _getTagIds(jsonInterval['tags']),
                  title: jsonInterval['title'] as String? ?? "",
                  start: _createDateTime(jsonInterval['initialDateTime']),
                  end: _createDateTime(jsonInterval['finalDateTime']),
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

      var token = await AuthService.getToken();

      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      };

      var requestBody = {
        'userId': interval.userId,
        'projectId': interval.projectId,
        'title': interval.title,
        'initialDateTime': interval.start.toUtc().toIso8601String(),
        'finalDateTime': interval.end.toUtc().toIso8601String(),
        'tagIds': interval.tagIds.map((tag) => tag.id).toList(),
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

  static Future<void> editInterval(IntervalItem interval, int companyId) async {
    try {
      var apiUrl = dotenv.get("API_URL");
      var url = Uri.http(apiUrl, '/api/Work/${interval.id}');

      var headers = {'Content-Type': 'application/json'};

      var requestBody = {
        'userId': interval.userId,
        'projectId': interval.projectId,
        'title': interval.title,
        'initialDateTime': interval.start.toUtc().toIso8601String(),
        'finalDateTime': interval.end.toUtc().toIso8601String(),
        'tagIds': interval.tagIds.map((tag) => tag.id).toList(),
      };

      var response = await http.patch(
        url,
        headers: headers,
        body: convert.jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Intervalo editado com sucesso
      } else {
        throw Exception('Erro na edição da tag: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Exception during HTTP request: $e');
    }
  }
}
