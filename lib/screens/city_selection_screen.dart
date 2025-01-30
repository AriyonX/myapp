import 'package:flutter/material.dart';
import 'news_screen.dart';

class CitySelectionScreen extends StatefulWidget {
  final String? selectedCountry;

  const CitySelectionScreen({
    super.key,
    required this.selectedCountry,
  });

  @override
  State<CitySelectionScreen> createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  String? selectedCity;

  // Country-specific city data (trimmed down to ~15 important cities)
  final Map<String, List<String>> countryCities = {
    'Türkiye': [
      'İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya', 'Adana', 'Konya',
      'Gaziantep', 'Şanlıurfa', 'Diyarbakır', 'Mersin', 'Kayseri', 'Eskişehir',
      'Samsun', 'Trabzon'
    ],
    'Amerika Birleşik Devletleri': [
      'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix', 'Philadelphia',
      'San Antonio', 'San Diego', 'Dallas', 'San Jose', 'Austin', 'Jacksonville',
      'San Francisco', 'Seattle', 'Denver'
    ],
    'Birleşik Krallık': [
      'London', 'Birmingham', 'Manchester', 'Glasgow', 'Liverpool', 'Leeds',
      'Newcastle', 'Sheffield', 'Bristol', 'Nottingham', 'Edinburgh', 'Cardiff',
      'Belfast', 'Leicester', 'Coventry'
    ],
    'Almanya': [
      'Berlin', 'Hamburg', 'Munich', 'Cologne', 'Frankfurt', 'Stuttgart',
      'Düsseldorf', 'Dortmund', 'Essen', 'Leipzig', 'Bremen', 'Dresden',
      'Hanover', 'Nuremberg', 'Duisburg'
    ],
    'Fransa': [
      'Paris', 'Marseille', 'Lyon', 'Toulouse', 'Nice', 'Nantes', 'Strasbourg',
      'Montpellier', 'Bordeaux', 'Lille', 'Rennes', 'Reims', 'Le Havre',
      'Saint-Étienne', 'Toulon'
    ],
    'İtalya': [
      'Roma', 'Milano', 'Napoli', 'Torino', 'Palermo', 'Genova', 'Bologna',
      'Firenze', 'Bari', 'Catania', 'Venezia', 'Verona', 'Messina', 'Padova',
      'Trieste'
    ],
    'İspanya': [
      'Madrid', 'Barcelona', 'Valencia', 'Sevilla', 'Zaragoza', 'Málaga',
      'Murcia', 'Palma', 'Las Palmas de Gran Canaria', 'Bilbao', 'Alicante',
      'Córdoba', 'Valladolid', 'Vigo', 'Gijón'
    ],
    'Portekiz': [
      'Lisboa', 'Porto', 'Vila Nova de Gaia', 'Braga', 'Setúbal',
      'Coimbra', 'Funchal', 'Amadora', 'Queluz', 'Agualva-Cacém', 'Cascais', 'Leiria',
      'Ponta Delgada', 'Portimão', 'Aveiro'
    ],
    'Hollanda': [
      'Amsterdam', 'Rotterdam', 'The Hague', 'Utrecht', 'Eindhoven', 'Tilburg',
      'Groningen', 'Almere', 'Breda', 'Nijmegen', 'Apeldoorn', 'Haarlem',
      'Arnhem', 'Enschede', 'Amersfoort'
    ],
    'Belçika': [
      'Brüksel', 'Anvers', 'Gent', 'Charleroi', 'Liège', 'Bruges', 'Namur',
      'Leuven', 'Mons', 'Aalst', 'Mechelen', 'La Louvière', 'Kortrijk',
      'Hasselt', 'Ostend'
    ],
    'İsviçre': [
      'Zürih', 'Cenevre', 'Basel', 'Bern', 'Lozan', 'Luzern', 'St. Gallen',
      'Lugano', 'Winterthur', 'Biel/Bienne', 'Thun', 'Schaffhausen',
      'Fribourg', 'Chur', 'Vernier'
    ],
    'Avusturya': [
      'Viyana', 'Graz', 'Linz', 'Salzburg', 'Innsbruck', 'Klagenfurt', 'Villach',
      'Wels', 'Sankt Pölten', 'Dornbirn', 'Wiener Neustadt', 'Steyr', 'Feldkirch',
      'Bregenz', 'Leonding'
    ],
    'İsveç': [
      'Stockholm', 'Göteborg', 'Malmö', 'Uppsala', 'Linköping', 'Örebro',
      'Västerås', 'Helsingborg', 'Jönköping', 'Norrköping', 'Umeå', 'Lund',
      'Borås', 'Eskilstuna', 'Gävle'
    ],
    'Norveç': [
      'Oslo', 'Bergen', 'Trondheim', 'Stavanger', 'Kristiansand', 'Drammen',
      'Tromsø', 'Fredrikstad', 'Sandnes', 'Skien', 'Sarpsborg', 'Ålesund',
      'Tønsberg', 'Moss', 'Porsgrunn'
    ],
    'Danimarka': [
      'Kopenhag', 'Aarhus', 'Odense', 'Aalborg', 'Esbjerg', 'Randers', 'Kolding',
      'Horsens', 'Vejle', 'Roskilde', 'Herning', 'Hørsholm', 'Silkeborg',
      'Næstved', 'Frederiksberg'
    ],
    'Finlandiya': [
      'Helsinki', 'Espoo', 'Tampere', 'Vantaa', 'Oulu', 'Turku', 'Jyväskylä',
      'Lahti', 'Kuopio', 'Pori', 'Kouvola', 'Joensuu', 'Lappeenranta', 'Vaasa',
      'Hämeenlinna'
    ],
    'Rusya': [
      'Moskova', 'Sankt-Peterburg', 'Novosibirsk', 'Yekaterinburg', 'Kazan',
      'Nizhny Novgorod', 'Chelyabinsk', 'Omsk', 'Samara', 'Rostov-on-Don',
      'Ufa', 'Krasnoyarsk', 'Perm', 'Voronezh', 'Volgograd'
    ],
    'Polonya': [
      'Varşova', 'Kraków', 'Łódź', 'Wrocław', 'Poznań', 'Gdańsk', 'Szczecin',
      'Bydgoszcz', 'Lublin', 'Katowice', 'Białystok', 'Gdynia', 'Częstochowa',
      'Radom', 'Sosnowiec'
    ],
    'Çek Cumhuriyeti': [
      'Prag', 'Brno', 'Ostrava', 'Plzeň', 'Liberec', 'Olomouc', 'České Budějovice',
      'Ústí nad Labem', 'Hradec Králové', 'Pardubice', 'Havířov', 'Zlín', 'Kladno',
      'Most', 'Opava'
    ],
    'Yunanistan': [
      'Atina', 'Selanik', 'Patras', 'Kandiye', 'Larisa', 'Volos', 'Rodos',
      'Yanya', 'Kavala', 'Korfu', 'Kalamata', 'Tripoli', 'Chalcis',
      'Alexandroupoli', 'Serres'
    ],
    'Macaristan': [
      'Budapeşte', 'Debrecen', 'Szeged', 'Miskolc', 'Pécs', 'Győr', 'Nyíregyháza',
      'Kecskemét', 'Székesfehérvár', 'Szombathely', 'Szolnok', 'Érd', 'Tatabánya',
      'Kaposvár', 'Békéscsaba'
    ],
    'Romanya': [
      'Bükreş', 'Kaloşvar', 'Temeşvar', 'Iași', 'Constanța', 'Krayova',
      'Braşov', 'Galați', 'Ploiești', 'Oradea', 'Brăila', 'Arad', 'Sibiu',
      'Bacău', 'Pitești'
    ],
    'Bulgaristan': [
      'Sofya', 'Filibe', 'Varna', 'Burgaz', 'Ruse', 'Eski Zağra', 'Plevne',
      'Sliven', 'Dobriç', 'Şumnu', 'Pazarcık', 'Hasköy', 'Yambol', 'Blagoevgrad',
      'Veliko Tırnovo'
    ],
    'Ukrayna': [
      'Kiev', 'Harkov', 'Odessa', 'Dnipro', 'Donetsk', 'Zaporijya', 'Lviv',
      'Kryvyi Rih', 'Mikolayiv', 'Mariupol', 'Luhansk', 'Vinnytsia', 'Simferopol',
      'Kherson', 'Poltava'
    ],
    'Japonya': [
      'Tokyo', 'Yokohama', 'Osaka', 'Nagoya', 'Sapporo', 'Fukuoka', 'Kobe',
      'Kyoto', 'Hiroshima', 'Kawasaki', 'Saitama', 'Sendai', 'Kitakyushu',
      'Chiba', 'Sakai'
    ],
    'Güney Kore': [
      'Seul', 'Busan', 'Incheon', 'Daegu', 'Daejeon', 'Gwangju', 'Suwon',
      'Ulsan', 'Changwon', 'Goyang', 'Seongnam', 'Yongin', 'Bucheon', 'Ansan',
      'Cheongju'
    ],
    'Çin': [
      'Şanghay', 'Pekin', 'Guangzhou', 'Shenzhen', 'Tianjin', 'Chongqing',
      'Wuhan', 'Chengdu', 'Nanjing', 'Xi\'an', 'Hangzhou', 'Shenyang', 'Qingdao',
      'Dalian', 'Ningbo'
    ],
    'Hindistan': [
      'Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Ahmedabad', 'Chennai',
      'Kolkata', 'Surat', 'Pune', 'Jaipur', 'Lucknow', 'Kanpur', 'Nagpur',
      'Indore', 'Thane'
    ],
    'Avustralya': [
      'Sidney', 'Melbourne', 'Brisbane', 'Perth', 'Adelaide', 'Gold Coast',
      'Canberra', 'Newcastle', 'Wollongong', 'Geelong', 'Hobart', 'Townsville',
      'Cairns', 'Darwin', 'Toowoomba'
    ],
    'Yeni Zelanda': [
      'Auckland', 'Wellington', 'Christchurch', 'Hamilton', 'Tauranga', 'Dunedin',
      'Lower Hutt', 'Palmerston North', 'Napier', 'Porirua', 'New Plymouth',
      'Nelson', 'Invercargill', 'Whangarei', 'Rotorua'
    ],
    'Kanada': [
      'Toronto', 'Montreal', 'Vancouver', 'Calgary', 'Ottawa', 'Edmonton',
      'Mississauga', 'Winnipeg', 'Québec City', 'Hamilton', 'Brampton',
      'Surrey', 'Halifax', 'London', 'Markham'
    ],
    'Meksika': [
      'Meksiko', 'Guadalajara', 'Monterrey', 'Puebla', 'Tijuana', 'Ciudad Juárez',
      'León', 'Zapopan', 'Ecatepec de Morelos', 'Naucalpan', 'Chihuahua',
      'Mérida', 'San Luis Potosí', 'Aguascalientes', 'Hermosillo'
    ],
    'Brezilya': [
      'São Paulo', 'Rio de Janeiro', 'Brasília', 'Salvador', 'Fortaleza',
      'Belo Horizonte', 'Manaus', 'Curitiba', 'Recife', 'Porto Alegre',
      'Belém', 'Goiânia', 'Guarulhos', 'Campinas', 'São Luís'
    ],
    'Arjantin': [
      'Buenos Aires', 'Córdoba', 'Rosario', 'Mendoza', 'La Plata',
      'San Miguel de Tucumán', 'Mar del Plata', 'Salta', 'Santa Fe', 'San Juan',
      'Resistencia', 'Santiago del Estero', 'Corrientes', 'Bahía Blanca',
      'Neuquén'
    ],
    'Güney Afrika': [
      'Cape Town', 'Durban', 'Johannesburg', 'Pretoria', 'Port Elizabeth',
      'Soweto', 'Pietermaritzburg', 'Benoni', 'Tembisa', 'East London', 'Bloemfontein',
      'Vereeniging', 'Boksburg', 'Welkom', 'Newcastle'
    ],
    'İsrail': [
      'Jerusalem', 'Tel Aviv', 'Haifa', 'Rishon LeZion', 'Petah Tikva',
      'Ashdod', 'Netanya', 'Beersheba', 'Holon', 'Bnei Brak', 'Rehovot',
      'Bat Yam', 'Ashkelon', 'Herzliya', 'Kfar Saba'
    ],
    'Mısır': [
      'Cairo', 'Alexandria', 'Giza', 'Port Said', 'Suez', 'Luxor', 'Mansoura',
      'El Mahalla El Kubra', 'Tanta', 'Asyut', 'Ismailia', 'Fayoum', 'Zagazig',
      'Aswan', 'Damietta'
    ],
    'Suudi Arabistan': [
      'Riyad', 'Cidde', 'Mekke', 'Medine', 'Dammam', 'Taif', 'Tabuk',
      'Buraydah', 'Khamis Mushait', 'Khobar', 'Yanbu', 'Hafar Al-Batin',
      'Jubail', 'Al-Ahsa', 'Najran'
    ],
    'Birleşik Arap Emirlikleri': [
      'Abu Dabi', 'Dubai', 'Sharjah', 'Al Ain', 'Ajman', 'Ras Al Khaimah',
      'Fujairah', 'Umm Al Quwain', 'Khor Fakkan', 'Dibba Al-Fujairah',
      'Al Ruwais', 'Kalba', 'Madinat Zayed', 'Liwa Oasis', 'Al Dhaid'
    ],
    'Endonezya': [
      'Jakarta', 'Surabaya', 'Bandung', 'Medan', 'Bekasi', 'Tangerang',
      'Depok', 'Semarang', 'Palembang', 'Makassar', 'Batam', 'Bogor',
      'Padang', 'Malang', 'Pekanbaru'
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Get the cities for the selected country, or an empty list if the country isn't found
    final List<String> currentCities =
        countryCities[widget.selectedCountry] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Şehir Seçimi'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: currentCities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(currentCities[index]),
                  leading: const Icon(Icons.location_city),
                  selected: selectedCity == currentCities[index],
                  onTap: () {
                    setState(() {
                      selectedCity = currentCities[index];
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsScreen(
                          selectedCountry: widget.selectedCountry!,
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
