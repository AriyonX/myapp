import 'package:flutter/material.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/utils/app_logger.dart';

class NewsScreen extends StatefulWidget {
  final String? selectedCountry;
  const NewsScreen({Key? key, required this.selectedCountry}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<NewsArticle>> newsFuture;
  final NewsService _newsService = NewsService();

  @override
  void initState() {
    super.initState();
    //selectedCountry e göre haberleri çek
    newsFuture = _newsService.getTopHeadlinesByCountry(widget.selectedCountry ?? 'Türkiye');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Screen'),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            AppLogger.error('Error loading news', snapshot.error);
            return Center(
                child: Text(
                    'Haberler yüklenirken bir hata oluştu: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final List<NewsArticle> news = snapshot.data!;

            if (news.isEmpty) {
              return const Center(
                child: Text('Bu şehir için haber bulunamadı.'),
              );
            }
            return ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                final article = news[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(article.description),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
                child: Text('Beklenmeyen bir hata oluştu.'));
          }
        },
      ),
    );
  }
}
