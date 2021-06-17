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
        return 'https://store.steampowered.com/app/${jogo.info!.steamAppID}';
      case '2':
        return 'https://www.gamersgate.com/product/${limpaUrl(jogo.info!.title!)}';
      case '3':
        return 'https://www.greenmangaming.com/pt/games/${limpaUrl(jogo.info!.title!)}/';
      case '6':
        return 'https://www.direct2drive.com/search?q=${jogo.info!.title!}';
      case '7':
        return 'https://www.gog.com/game/${limpaUrlGog(jogo.info!.title!)}/';
      case '8':
        return 'https://www.origin.com/bra/pt-br/search?searchString=${jogo.info!.title!}';
      case '11':
        return 'https://www.humblebundle.com/store/${limpaUrl(jogo.info!.title!)}';
      case '15':
        return 'https://www.fanatical.com/en/game/${limpaUrl(jogo.info!.title!)}';
      case '21':
        return 'https://www.wingamestore.com/search/?SearchWord=${jogo.info!.title!}';
      case '23':
        return 'https://www.gamebillet.com/${limpaUrl(jogo.info!.title!)}';
      case '24':
        return 'https://www.voidu.com/${limpaUrl(jogo.info!.title!)}';
      case '25':
        return 'https://www.epicgames.com/store/pt-BR/p/${limpaUrl(jogo.info!.title!)}';
      case '27':
        return 'https://us.gamesplanet.com/search?query=${jogo.info!.title!.toLowerCase()}';
      case '28':
        return 'https://www.gamesload.com.br/results.html?search=${jogo.info!.title!}&N=&sortDateUpdate=desc';
      case '29':
        return 'https://2game.com/${limpaUrl(jogo.info!.title!)}';
      case '30':
        return 'https://www.indiegala.com/search/${jogo.info!.title!.toLowerCase()}/store-games';
      case '32':
        return 'https://www.allyouplay.com/${limpaUrl(jogo.info!.title!)}';
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
