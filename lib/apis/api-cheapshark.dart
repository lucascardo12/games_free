import 'package:get/get.dart';

class ApiCheapShark extends GetConnect {
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
      'https://www.cheapshark.com/api/1.0/deals?$params',
    );
    if (result.isOk) {
      return result.body;
    } else {
      Get.snackbar('erro', 'getOfertas');
      return [];
    }
  }

  Future<List> getStores() async {
    Response result = await get('https://www.cheapshark.com/api/1.0/stores');
    if (result.isOk) {
      return result.body;
    } else {
      Get.snackbar('erro', 'getStores');
      return [];
    }
  }

  Future<Map<String, dynamic>> getGame({required String gameId}) async {
    Response result = await get('https://www.cheapshark.com/api/1.0/games?id=$gameId');
    if (result.isOk) {
      return result.body;
    } else {
      Get.snackbar('erro', 'getGame');
      return Map<String, dynamic>();
    }
  }
}
