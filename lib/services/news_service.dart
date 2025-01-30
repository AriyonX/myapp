
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_article.dart';

 

class NewsService {
  static const String _apiKey ='959ea5e7296a44b4a2191fb009b46f33'; // NewsAPI.org'dan alacağınız API anahtarı. **ÖNEMLİ: API anahtarınızı buraya girin!**
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
  // API anahtarını kontrol et
  static void checkApiKey() {
    if (_apiKey.isEmpty || _apiKey == '959ea5e7296a44b4a2191fb009b46f33') {
      throw Exception(
          'API anahtarı ayarlanmamış. Lütfen API anahtarınızı girin!');
    }
  }

  Future<List<NewsArticle>> getTopHeadlinesByCountry(String country) async {
    checkApiKey();
    // Ülke kodunu kontrol et
    if (!_countryCodes.containsKey(country)) {
      
throw Exception(
        'Geçersiz ülke: $country. Lütfen geçerli bir ülke seçin.');
    }

    final response = await http.get(
      Uri.parse(
          '$_baseUrl/top-headlines?country=${_countryCodes[country]}&apiKey=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'ok') {
        final List<dynamic> articles = data['articles'];
        return articles
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      } else {
        // API'den hata durumu döndüğünde
        throw Exception(
            'API hatası: ${data['message'] ?? 'Bilinmeyen bir hata oluştu.'}');
      }
    } else {
      // API'den HTTP hatası döndüğünde
      throw Exception(
          'Haberler yüklenirken bir hata oluştu. Hata kodu: ${response.statusCode}');
    }
  }
}
