import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

class NewsService {
  static const String _apiKey = '9b267a02a19c4a2c9c51dedf19791ef5';
  static const String _baseUrl = 'https://newsapi.org/v2';
  final Map<String, String> _countryCodes = {
    'Türkiye': 'tr',
    'Amerika Birleşik Devletleri': 'us',
    'Birleşik Krallık': 'gb',
    'Almanya': 'de',
    'Fransa': 'fr',
    'İtalya': 'it',
    'İspanya': 'es',
    'Portekiz': 'pt',
    'Hollanda': 'nl',
    'Belçika': 'be',
    'İsviçre': 'ch',
    'Avusturya': 'at',
    'İsveç': 'se',
    'Norveç': 'no',
    'Danimarka': 'dk',
    'Finlandiya': 'fi',
    'Rusya': 'ru',
    'Polonya': 'pl',
    'Çek Cumhuriyeti': 'cz',
    'Yunanistan': 'gr',
    'Macaristan': 'hu',
    'Romanya': 'ro',
    'Bulgaristan': 'bg',
    'Ukrayna': 'ua',
    'Japonya': 'jp',
    'Güney Kore': 'kr',
    'Çin': 'cn',
    'Hindistan': 'in',
    'Avustralya': 'au',
    'Yeni Zelanda': 'nz',
    'Kanada': 'ca',
    'Meksika': 'mx',
    'Brezilya': 'br',
    'Arjantin': 'ar',
    'Güney Afrika': 'za',
    'İsrail': 'il',
    'Mısır': 'eg',
    'Suudi Arabistan': 'sa',
    'Birleşik Arap Emirlikleri': 'ae',
    'Endonezya': 'id',
  };

  Future<List<NewsArticle>> getTopHeadlinesByCountry(String country) async {
    if (!_countryCodes.containsKey(country)) {
      throw Exception(
          'Geçersiz ülke: $country. Lütfen geçerli bir ülke seçin.');
    }

    final uri = Uri.parse('$_baseUrl/top-headlines?country=${_countryCodes[country]}');
    
    try {
      final client = http.Client();
      final response = await client.get(
        uri,
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/109.0',
          'Accept': 'application/json',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer $_apiKey',
        },
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['status'] == 'ok') {
          final List<dynamic> articles = data['articles'];
          return articles.map((article) => NewsArticle.fromJson(article)).toList();
        } else {
          throw Exception(
              'API hatası: ${data['message'] ?? 'Bilinmeyen bir hata oluştu.'}');
        }
      } else if (response.statusCode == 426) {
        throw Exception('426 Hatası: API, daha yeni bir istemci sürümü veya HTTPS kullanımı gerektiriyor.');
      } else {
        throw Exception(
            'Haberler yüklenirken bir hata oluştu. Hata kodu: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Bağlantı hatası: $e');
    }
  }
}
