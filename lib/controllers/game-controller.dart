import 'package:games_free/models/games.dart';
import 'package:games_free/models/ofertas.dart';
import 'package:games_free/services/global.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  Ofertas of = Get.arguments;
  Games jogo = Games();
  final gb = Get.find<Global>();
  @override
  void onInit() {
    getDetalheGame();
    super.onInit();
  }

  getDetalheGame() async {
    Map<String, dynamic> retorno = await gb.api.getGame(gameId: of.gameID ?? '');
    jogo = Games.fromJson(retorno);
    update();
  }

  String retornaUrlLoja({required Deals oferta}) {
    switch (oferta.storeID) {
      case '1':
        return '${gb.linkLojas[oferta.storeID]}/app/${jogo.info!.steamAppID}';
      case '2':
        return '${gb.linkLojas[oferta.storeID]}/product/${limpaUrl(jogo.info!.title!)}';
      case '3':
        return '${gb.linkLojas[oferta.storeID]}/pt/games/${limpaUrl(jogo.info!.title!)}/';
      case '6':
        return '${gb.linkLojas[oferta.storeID]}/search?q=${jogo.info!.title!}';
      case '7':
        return '${gb.linkLojas[oferta.storeID]}/game/${limpaUrlGog(jogo.info!.title!)}/';
      case '8':
        return '${gb.linkLojas[oferta.storeID]}/bra/pt-br/search?searchString=${jogo.info!.title!}';
      case '11':
        return '${gb.linkLojas[oferta.storeID]}/store/${limpaUrl(jogo.info!.title!)}';
      case '15':
        return '${gb.linkLojas[oferta.storeID]}/en/game/${limpaUrl(jogo.info!.title!)}';
      case '21':
        return '${gb.linkLojas[oferta.storeID]}/search/?SearchWord=${jogo.info!.title!}';
      case '23':
        return '${gb.linkLojas[oferta.storeID]}/${limpaUrl(jogo.info!.title!)}';
      case '24':
        return '${gb.linkLojas[oferta.storeID]}/${limpaUrl(jogo.info!.title!)}';
      case '25':
        return '${gb.linkLojas[oferta.storeID]}/store/pt-BR/p/${limpaUrl(jogo.info!.title!)}';
      case '27':
        return '${gb.linkLojas[oferta.storeID]}/search?query=${jogo.info!.title!.toLowerCase()}';
      case '28':
        return '${gb.linkLojas[oferta.storeID]}/results.html?search=${jogo.info!.title!}&N=&sortDateUpdate=desc';
      case '29':
        return '${gb.linkLojas[oferta.storeID]}/${limpaUrl(jogo.info!.title!)}';
      case '30':
        return '${gb.linkLojas[oferta.storeID]}/search/${jogo.info!.title!.toLowerCase()}/store-games';
      case '32':
        return '${gb.linkLojas[oferta.storeID]}/${limpaUrl(jogo.info!.title!)}';
      default:
        return '';
    }
  }

  String limpaUrl(String v) {
    return v
        .toLowerCase()
        .replaceAll(' ', '-')
        .replaceAll(':', '')
        .replaceAll('---', '-')
        .replaceAll('--', '-');
  }

  String limpaUrlGog(String v) {
    return v
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll(':', '')
        .replaceAll('___', '_')
        .replaceAll('__', '_');
  }
}
