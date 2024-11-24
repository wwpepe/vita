import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:convert';

class DeepSearchApi {
  // 실제 API 호출 대신 임시 데이터를 반환
  Future<List<Map<String, String>>> fetchArticles({
    required String companyName,
    required String dateFrom,
    required String dateTo,
  }) async {
    // 임시 데이터
    return [
      {
        'title': 'Example Article 1',
        'link': 'https://example.com/article1',
        'description': 'This is a description for article 1.',
        'date': '2023-01-01',
      },
      {
        'title': 'Example Article 2',
        'link': 'https://example.com/article2',
        'description': 'This is a description for article 2.',
        'date': '2023-01-02',
      },
    ];
  }
}
