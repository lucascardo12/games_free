import 'dart:convert';

import 'package:http/http.dart';

class ApiCheapShark {
  final String host = 'https://www.cheapshark.com';
  final String path = '/api/1.0';
  Future<List> getOfertas({
    String? storeID,
    double? upperPrice,
    String? sortBy,
    int? desc,
  }) async {
    String params = '';
    if (storeID != null) params += 'storeID=$storeID&';
    if (upperPrice != null) params += 'upperPrice=$upperPrice&';
    if (sortBy != null) params += 'sortBy=$sortBy&';
    if (desc != null) params += 'desc=$desc&';
    Response result = await get(
      Uri.parse('$host$path/deals?$params'),
    );
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return [];
    }
  }

  Future<List> getStores() async {
    Response result = await get(Uri.parse('$host$path/stores'));
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> getGame({required String gameId}) async {
    Response result = await get(Uri.parse('$host$path/games?id=$gameId'));
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return <String, dynamic>{};
    }
  }
}
