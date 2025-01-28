import 'dart:convert';
import 'package:http/http.dart' as http;

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
        final articles = List<Map<String, dynamic>>.from(data['articles']);

        if (city != null) {
          return articles
              .where((article) {
                final title = article['title']?.toString().toLowerCase() ?? '';
                final description =
                    article['description']?.toString().toLowerCase() ?? '';
                final content =
                    article['content']?.toString().toLowerCase() ?? '';
                final cityLower = city.toLowerCase();

                return title.contains(cityLower) ||
                    description.contains(cityLower) ||
                    content.contains(cityLower);
              })
              .take(10)
              .toList();
        }

        return articles;
      } else {
        throw Exception(
          'Haberler yüklenirken bir hata oluştu. Hata kodu: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow; // Hatayı yukarıya fırlat, çağıran fonksiyonun hatayı işlemesini sağla
    }
  }
}
