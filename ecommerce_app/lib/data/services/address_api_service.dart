
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class AddressAPIService {
  final String baseUrl = 'rsapi.goong.io';
  final String apiKey = 'KeONrT42qDbhvyFK5oLjywhE0EAcrxeHh0NTznDz';
  final String sessionToken = Uuid().v4(); // token mỗi lần request
  // Timer? _debounce;

  // void deplayedSearchReq(String? query, Function(List<String>) onResult) {
  //   if(_debounce != null && _debounce!.isActive) {
  //     _debounce!.cancel();
  //   }

  //   _debounce = Timer(Duration(milliseconds: 300), () async {
  //     if(query == null || query.length < 2) {
  //       onResult([]);
  //       return;
  //     }

  //     List<String> addresses = await fetchAddress(query);
  //     onResult(addresses);
  //   });
  // }

  Future<List<String>> searchAddress(String? query) async {
    if (query == null || query.length < 2) return [];

    final Uri url = Uri.https(
      baseUrl,
      'Place/AutoComplete',
      {
        'api_key': apiKey,
        'input': query,
        'sessiontoken' : sessionToken,
      }
    );

    final response = await http.get(url);

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['predictions'] as List)
        .map((item) => item['description'].toString())
        .toList();

    }
    return [];
  }
}