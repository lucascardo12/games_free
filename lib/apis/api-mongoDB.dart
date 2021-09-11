import 'dart:convert';
import 'package:games_free/senhas.dart';
import 'package:get/get_connect/connect.dart';

class ApiMongoDB extends GetConnect {
  Future<bool> insertUpdate({dynamic objeto, required String tabela}) async {
    try {
      Map<String, String> headers = Map<String, String>();
      headers['senhaDb'] = senhaDb;
      headers['clusterDb'] = clusterDb;
      headers['formatDb'] = formatDb;
      headers['hostDb'] = hostDb;
      headers['loginDb'] = loginDb;
      headers['tabela'] = tabela;
      headers['login'] = loginApi;
      headers['senha'] = senhaApi;

      Response result = await post(
        'http://$hostApi/InsertUpdate',
        objeto.toJson(),
        headers: headers,
        contentType: "application/json",
      );

      return result.isOk;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleta({dynamic objeto, required String tabela}) async {
    try {
      Map<String, String> headers = Map<String, String>();
      headers['senhaDb'] = senhaDb;
      headers['clusterDb'] = clusterDb;
      headers['formatDb'] = formatDb;
      headers['hostDb'] = hostDb;
      headers['loginDb'] = loginDb;
      headers['selector'] = '{"_id": ${objeto.id}';
      headers['tabela'] = tabela;
      headers['login'] = loginApi;
      headers['senha'] = senhaApi;

      Response result = await delete(
        'http://$hostApi/Delete',
        headers: headers,
        contentType: "application/json",
      );
      return result.isOk;
    } catch (e) {
      return false;
    }
  }

  Future<List<dynamic>> getData({dynamic selector, required String tabela}) async {
    //{'_id': data.id} selector
    try {
      Map<String, String> headers = Map<String, String>();
      headers['senhaDb'] = senhaDb;
      headers['clusterDb'] = clusterDb;
      headers['formatDb'] = formatDb;
      headers['hostDb'] = hostDb;
      headers['loginDb'] = loginDb;
      headers['selector'] = jsonEncode(selector);
      headers['tabela'] = tabela;
      headers['login'] = loginApi;
      headers['senha'] = senhaApi;

      Response result = await get(
        'http://$hostApi/GetData',
        headers: headers,
        contentType: "application/json",
      );
      return jsonDecode(result.bodyString ?? '')["data"];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
