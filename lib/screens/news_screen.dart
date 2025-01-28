import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  final String selectedCountry;
  final String selectedCity;

  const NewsScreen({
    super.key,
    required this.selectedCountry,
    required this.selectedCity,
  });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Map<String, dynamic>> articles = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Replace with your actual API key
      String apiKey = '959ea5e7296a44b4a2191fb009b46f33';
      String url =
          'https://newsapi.org/v2/everything?q=${widget.selectedCity}&language=tr&apiKey=$apiKey';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('articles')) {
          List<dynamic> fetchedArticles = data['articles'];
          setState(() {
            articles = List<Map<String, dynamic>>.from(fetchedArticles);
            isLoading = false;
          });
        } else {
          throw Exception('Response does not contain articles');
        }
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News in ${widget.selectedCity}'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : errorMessage != null
                ? Text(errorMessage!)
                : ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return ListTile(
                        title: Text(article['title'] ?? 'No Title'),
                        subtitle: Text(article['description'] ?? 'No Description'),
                        // Add more article details as needed
                      );
                    },
                  ),
      ),
    );
  }
}




