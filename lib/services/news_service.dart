//In lib/services/news_service.dart

import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsService {
  final String _baseUrl = 'https://newsapi.org/v2';
  final String _apiKey = '959ea5e7296a44b4a2191fb009b46f33Y';

  final Map<String, String> _countryCodes = {
    'Türkiye': 'tr',
    'Almanya': 'de',
    'ABD': 'us',
    'Birleşik Krallık': 'gb',
    'Fransa': 'fr',
    'İtalya': 'it',
    'İspanya': 'es',
    'Japonya': 'jp',
    'Çin': 'cn',
    'Hindistan': 'in',
    'Kanada': 'ca',
    'Avustralya': 'au',
    'Güney Kore': 'kr',
    'Brezilya': 'br',
    'Meksika': 'mx',
    'Arjantin': 'ar',
    'Rusya': 'ru',
    'Hollanda': 'nl',
    'İsveç': 'se',
    'İsviçre': 'ch',
    'Belçika': 'be',
    'Avusturya': 'at',
    'Danimarka': 'dk',
    'Norveç': 'no',
    'Finlandiya': 'fi',
    'Polonya': 'pl',
    'Çek Cumhuriyeti': 'cz',
    'Yunanistan': 'gr',
    'Macaristan': 'hu',
    'Romanya': 'ro',
    'Bulgaristan': 'bg',
    'Ukrayna': 'ua',
    'İrlanda': 'ie',
    'Portekiz': 'pt',
    'Güney Afrika': 'za',
    'İsrail': 'il',
    'Mısır': 'eg',
    'Suudi Arabistan': 'sa',
    'Birleşik Arap Emirlikleri': 'ae',
    'Endonezya': 'id',
  };

  Future<List<Map<String, dynamic>>> getNews({
    required String country,
    String? city,
  }) async {
    try {
      String countryCode = _countryCodes[country] ?? 'tr';

      final response = await http.get(
        Uri.parse(
          '$_baseUrl/top-headlines?country=$countryCode&apiKey=$_apiKey&pageSize=10',
        ),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'HaberNoktasi/1.0',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];
        return List<Map<String, dynamic>>.from(articles);
      } else {
        // Handle non-200 status codes
        //print('Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle any exceptions
      //print('Exception: $e');
      return [];
    }
  }
}
