import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:toonflix/helper/html_helper.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/widgets/naver_webtoon_image.dart';

class EpisodeCard extends StatelessWidget {
  final WebtoonModel webtoon;
  final WebtoonEpisodeModel episode;

  const EpisodeCard({
    super.key,
    required this.webtoon,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.green.shade200),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: GestureDetector(
          onTap: () => awaitLaunchUrl(
            Uri.parse(
                "https://comic.naver.com/webtoon/detail?titleId=${webtoon.id}&no=${episode.id}"),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  width: 160,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(3, 3),
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  child: NaverWebtoonImage(
                    url: episode.thumb,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parseHtmlText(episode.title),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          parseHtmlText(episode.rating),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        RatingBarIndicator(
                          rating: double.parse(episode.rating) / 2,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.green,
                          ),
                          itemCount: 5,
                          itemSize: 15,
                        ),
                      ],
                    ),
                    Text(
                      parseHtmlText(episode.date),
                      style: Theme.of(context).textTheme.titleSmall?.apply(
                            color: Colors.grey.shade600,
                          ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
