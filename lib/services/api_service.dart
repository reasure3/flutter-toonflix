import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl = "webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<T> _fetchData<T>(
    String endpoint,
    T Function(dynamic) fromJson,
    String errorMsg,
  ) async {
    final uri = Uri.https(baseUrl, endpoint);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return fromJson(jsonDecode(response.body));
      } else {
        throw HttpException(
          "$errorMsg Status code: ${response.statusCode}",
          uri: uri,
        );
      }
    } catch (e) {
      // Optionally log the error or handle it accordingly
      rethrow;
    }
  }

  static Future<WebtoonModelList> getTodaysToons() async {
    return _fetchData(
      today,
      (json) => WebtoonModelList.fromJson(json),
      "Failed to load today's webtoons.",
    );
  }

  static Future<WebtoonDetailModel> getWebtoonDetailById(String id) async {
    return _fetchData(
      id,
      (json) => WebtoonDetailModel.fromJson(json),
      "Failed to load webtoon details.",
    );
  }

  static Future<WebtoonEpisodeModelList> getLatestEpisodesById(
    String id,
  ) async {
    return _fetchData(
      "$id/episodes",
      (json) => WebtoonEpisodeModelList.fromJson(json),
      "Failed to load latest episodes.",
    );
  }
}
