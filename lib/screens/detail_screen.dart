import 'package:flutter/material.dart';
import 'package:toonflix/helper/html_helper.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/episode_card_widget.dart';
import 'package:toonflix/widgets/error_text_widget.dart';
import 'package:toonflix/widgets/favorite_button_widget.dart';
import 'package:toonflix/widgets/webtoon_card_widget.dart';
import 'package:toonflix/widgets/webtoon_detail_card.dart';

class DetailScreen extends StatelessWidget {
  final WebtoonModel webtoon;

  final Future<WebtoonDetailModel> webtoonDetail;
  final Future<WebtoonEpisodeModelList> webtoonEpisodes;

  DetailScreen({
    super.key,
    required this.webtoon,
  })  : webtoonDetail = ApiService.getWebtoonDetailById(webtoon.id),
        webtoonEpisodes = ApiService.getLatestEpisodesById(webtoon.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parseHtmlText(webtoon.title)),
        actions: [
          FavoriteButton(
            webtoonId: webtoon.id,
          ),
        ],
      ),
      body: FutureBuilder(
        future: webtoonEpisodes,
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(top: 50, bottom: 30),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: makeMainWebtoonCard(),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                sliver: SliverToBoxAdapter(
                  child: makeWebtoonDetailFuture(),
                ),
              ),
              if (snapshot.hasData)
                SliverPadding(
                  padding: const EdgeInsets.all(25),
                  sliver: makeEpisodesList(snapshot.data!),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget makeMainWebtoonCard() => GestureDetector(
        onTap: () => awaitLaunchUrl(
          Uri.parse(
            "https://comic.naver.com/webtoon/list?titleId=${webtoon.id}",
          ),
        ),
        child: WebtoonImageCard(
          webtoon: webtoon,
        ),
      );

  Widget makeWebtoonDetailFuture() => FutureBuilder(
        future: webtoonDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var detail = snapshot.data!;
            return WebtoonDetailCard(detail: detail);
          } else if (snapshot.hasError) {
            return const ErrorText();
          }
          return const SizedBox(
            width: 300,
            child: LinearProgressIndicator(),
          );
        },
      );

  Widget makeEpisodesList(WebtoonEpisodeModelList episodes) =>
      SliverList.builder(
        itemCount: episodes.length,
        itemBuilder: (context, index) => EpisodeCard(
          webtoon: webtoon,
          episode: episodes[index],
        ),
      );
}
