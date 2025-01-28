import 'package:flutter/material.dart';
import 'city_selection_screen.dart';

class CountrySelectionScreen extends StatefulWidget {
  const CountrySelectionScreen({super.key});

  @override
  State<CountrySelectionScreen> createState() => _CountrySelectionScreenState();
}

class _CountrySelectionScreenState extends State<CountrySelectionScreen> {
  // All available countries
  final List<String> _allCountries = [
    'Türkiye', 'Amerika Birleşik Devletleri', 'Birleşik Krallık', 'Almanya',
    'Fransa', 'İtalya', 'İspanya', 'Portekiz', 'Hollanda', 'Belçika', 'İsviçre',
    'Avusturya', 'İsveç', 'Norveç', 'Danimarka', 'Finlandiya', 'Rusya',
    'Polonya', 'Çek Cumhuriyeti', 'Yunanistan', 'Macaristan', 'Romanya',
    'Bulgaristan', 'Ukrayna', 'Japonya', 'Güney Kore', 'Çin', 'Hindistan',
    'Avustralya', 'Yeni Zelanda', 'Kanada', 'Meksika', 'Brezilya', 'Arjantin',
    'Güney Afrika', 'İsrail', 'Mısır', 'Suudi Arabistan',
    'Birleşik Arap Emirlikleri', 'Endonezya'
  ];

  // List that changes based on search query
  List<String> _filteredCountries = [];
  // Controller for the search field
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCountries = _allCountries; // Initially, all countries are shown
    // Listen for changes in the search field
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Function to update _filteredCountries based on the search query
  void _filterCountries() {
    final String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCountries = _allCountries
          .where((country) => country.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ülke Seçimi'),
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Ülke ara',
                hintText: 'Ülke adı giriniz',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // List of countries
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredCountries[index]),
                  leading: const Icon(Icons.flag),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CitySelectionScreen(
                          selectedCountry: _filteredCountries[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
