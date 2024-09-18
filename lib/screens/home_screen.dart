import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/screens/favorites_screen.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/error_text_widget.dart';
import 'package:toonflix/widgets/webtoon_card_widget.dart';

final Logger logger = Logger("Toonflix HomeScreen");

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<WebtoonModelList> webtoonsFuture = ApiService.getTodaysToons();

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarTitleTodayToon),
      ),
      body: FutureBuilder(
        future: webtoonsFuture,
        builder: makeLoadingBuilder,
      ),
    );
  }

  Widget makeLoadingBuilder(
      BuildContext context, AsyncSnapshot<WebtoonModelList> snapshot) {
    if (snapshot.hasData) {
      var webtoons = snapshot.data!;
      logger.fine("Today's webtoons data was successfully loaded!");
      logger.info("Total Webtoon List: ${webtoons.infoString()}");
      return Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: makeWebtoonCardList(webtoons),
          ),
          SizedBox(
            height: 40,
            child: Center(
              child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoritesScreen(),
                    ),
                  );
                },
                label: Text(
                  AppLocalizations.of(context)!.favorites,
                  style: GoogleFonts.nanumGothic(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.green,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      );
    } else if (snapshot.hasError) {
      logger.warning(
        "Failed loading today's webtoons data: ${snapshot.error}",
      );
      return const ErrorText();
    } else {
      logger.info("Loading today's webtoons data");
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget makeWebtoonCardList(WebtoonModelList webtoons) => Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            final to = clampDouble(
              controller.offset + event.scrollDelta.dy,
              controller.position.minScrollExtent - 100,
              controller.position.maxScrollExtent + 100,
            );
            controller.jumpTo(to);
          }
        },
        child: ListView.separated(
          controller: controller,
          scrollDirection: Axis.horizontal,
          itemCount: webtoons.length,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          itemBuilder: (context, index) {
            final webtoon = webtoons[index];
            logger.info(
              "Rendering $index's Webtoon Card: ${webtoon.title}",
            );
            return WebtoonCard(webtoon: webtoon);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 20,
            );
          },
        ),
      );
}
