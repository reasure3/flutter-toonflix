import 'package:flutter/material.dart';
import 'package:toonflix/helper/html_helper.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';

class WebtoonDetailCard extends StatelessWidget {
  const WebtoonDetailCard({
    super.key,
    required this.detail,
  });

  final WebtoonDetailModel detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${parseHtmlText(detail.genre)} / ${parseHtmlText(detail.age)}",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          parseHtmlText(detail.about),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
