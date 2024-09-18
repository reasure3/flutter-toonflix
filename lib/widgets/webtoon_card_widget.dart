import 'package:flutter/material.dart';
import 'package:toonflix/helper/html_helper.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/screens/detail_screen.dart';
import 'package:toonflix/widgets/naver_webtoon_image.dart';

class WebtoonCard extends StatelessWidget {
  const WebtoonCard({
    super.key,
    required this.webtoon,
  });

  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => DetailScreen(webtoon: webtoon),
          ),
        );
      },
      child: Column(
        children: [
          WebtoonImageCard(webtoon: webtoon),
          const SizedBox(height: 10),
          SizedBox(
            width: 270,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                parseHtmlText(webtoon.title),
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.center,
                textWidthBasis: TextWidthBasis.parent,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WebtoonImageCard extends StatelessWidget {
  const WebtoonImageCard({
    super.key,
    required this.webtoon,
  });

  final WebtoonModel webtoon;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: webtoon.id,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 250,
          maxWidth: 250,
          minHeight: 250,
        ),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              blurRadius: 15,
              offset: Offset(10, 10),
              color: Colors.black54,
            ),
          ],
        ),
        child: NaverWebtoonImage(url: webtoon.thumb),
      ),
    );
  }
}
