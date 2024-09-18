import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix/helper/html_helper.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/services/api_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  static const String likedToonsKey = "likedToons";

  late SharedPreferences prefs;

  bool isPrefLoaded = false;
  List<String> favoritesToonsId = [];

  List<WebtoonDetailModel> webtoons = [];

  void initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList(likedToonsKey);
    if (likedToons != null) {
      setState(() {
        isPrefLoaded = true;
      });
      favoritesToonsId = likedToons;
      getFavoriteWeboons();
    } else {
      await prefs.setStringList(likedToonsKey, []);
      setState(() {
        isPrefLoaded = true;
      });
    }
  }

  void getFavoriteWeboons() async {
    for (var webtoonId in favoritesToonsId) {
      updateWebtoonTitle(webtoonId);
    }
  }

  void updateWebtoonTitle(String webtoonId) async {
    var webtoon = await ApiService.getWebtoonDetailById(webtoonId);
    setState(() {
      webtoons.add(webtoon);
    });
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarTitleFavoriteToon),
      ),
      body: isPrefLoaded
          ? makeFavoritesList()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget makeFavoritesList() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.separated(
        itemCount: favoritesToonsId.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            awaitLaunchUrl(
              Uri.parse(
                "https://comic.naver.com/webtoon/list?titleId=${favoritesToonsId[index]}",
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: getWebtoonTitleText(index),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
      ),
    );
  }

  Widget getWebtoonTitleText(int index) {
    String title = "...";
    if (webtoons.length > index) {
      title = webtoons[index].title;
    }
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                parseHtmlText(title),
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textWidthBasis: TextWidthBasis.parent,
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
