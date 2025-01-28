import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      colors: true,
      printEmojis: true,
    ),
    filter: ProductionFilter(),
  );

  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}

class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String? imageUrl; // If the API provides an image URL
  final String source;
  final DateTime publishedAt;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.source,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'],
      source: json['source']['name'] ?? '',
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }
}

class NewsService {
  static const String _apiKey ='ff7c574326de47fa8a597c5bbe944221'; // NewsAPI.org'dan alacağınız API anahtarı. **ÖNEMLİ: API anahtarınızı buraya girin!**
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

  Future<List<NewsArticle>> getNews({
    required String country,
    String? city,
  }) async {
    try {
      String countryCode = _countryCodes[country] ?? 'tr';

      // Şehir ismi varsa, API'ye gönderilen parametreyi değiştir.
      Uri uri;
      if (city != null && city.isNotEmpty) {
         uri = Uri.parse('$_baseUrl/everything?q=$city&apiKey=$_apiKey&pageSize=10');
        AppLogger.info(
           '$_baseUrl/everything?q=$city&apiKey=$_apiKey&pageSize=10',
        );
      } else {
       uri = Uri.parse('$_baseUrl/top-headlines?country=$countryCode&apiKey=$_apiKey&pageSize=10');
        AppLogger.info(
            '$_baseUrl/top-headlines?country=$countryCode&apiKey=$_apiKey&pageSize=10',
          );
      }

      final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> articlesJson = data['articles'];

        List<NewsArticle> articles =
            articlesJson.map((articleJson) => NewsArticle.fromJson(articleJson)).toList();
        return articles;
      } else {
        throw Exception(
            'Haberler yüklenirken bir hata oluştu. Hata kodu: ${response.statusCode}');
      }
    } catch (e) {
      AppLogger.error('Haberleri alırken bir hata oluştu.', e);
      rethrow; // Hatayı yukarıya fırlat, çağıran fonksiyonun hatayı işlemesini sağla
    }
  }
}