import 'dart:convert';
import 'package:http/http.dart' as http;

class DeepSearchApi {
  final String baseUrl = 'https://api-v2.deepsearch.com/v1/articles';
  final String apiKey = '6b877175a5614e14a0ea3f40506d9311';

  Future<List<Map<String, String>>> fetchArticles({
    required String companyName,
    required String dateFrom,
    required String dateTo,
  }) async {
    final Uri url = Uri.parse(
        '$baseUrl?company_name=$companyName&date_from=$dateFrom&date_to=$dateTo&api_key=$apiKey');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, String>>.from(data['results'].map((item) => {
          'title': item['title'],
          'link': item['link'],
          'description': item['description'] ?? '',
          'date': item['date'] ?? '',
        }));
      } else {
        throw Exception(
            'Failed to fetch articles. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching articles: $e');
    }
  }
}