import 'package:flutter/material.dart';
import 'package:games_free/controllers/home_controller.dart';
import 'package:games_free/main.dart';
import 'package:games_free/views/config_page.dart';
import 'package:games_free/views/free_page.dart';
import 'package:games_free/views/ofertas_page.dart';
import 'package:games_free/views/store_page.dart';
import 'package:games_free/widgets/menu_top.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ct = di.get<HomeController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => ct.init(context),
    );
    super.initState();
  }

  @override
  void dispose() {
    ct.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade600,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      ct.gb.packageInfo.appName,
                      style: Theme.of(context).textTheme.headline6!,
                    ),
                    ValueListenableBuilder(
                      valueListenable: ct.index,
                      builder: (context, value, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MenuTop(
                            label: 'Free',
                            index: ct.index.value == 0,
                            icon: Icons.free_breakfast,
                            onpress: () => ct.index.value = 0,
                          ),
                          MenuTop(
                            label: 'Ofertas',
                            icon: Icons.offline_bolt,
                            index: ct.index.value == 1,
                            onpress: () => ct.index.value = 1,
                          ),
                          MenuTop(
                            label: 'Lojas',
                            icon: Icons.store,
                            index: ct.index.value == 2,
                            onpress: () => ct.index.value = 2,
                          ),
                          MenuTop(
                            label: 'Config',
                            icon: Icons.settings,
                            index: ct.index.value == 3,
                            onpress: () => ct.index.value = 3,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
          ValueListenableBuilder(
            valueListenable: ct.index,
            builder: (context, value, child) => Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                child: [
                  const FreePage(),
                  const OfertaPage(),
                  const StorePage(),
                  const ConfigPage(),
                ].elementAt(
                  ct.index.value,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: FutureBuilder<BannerAd>(
          future: ct.admob.loadBanner(
            adUnitId: ct.admob.bannerAdUnitId,
          ),
          builder: (context, value) {
            if (value.hasError) {
              return Row(
                children: const [
                  Center(
                    child: Text('Erro na propaganda'),
                  ),
                ],
              );
            }
            if (value.hasData) {
              return AdWidget(
                ad: value.data!,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
