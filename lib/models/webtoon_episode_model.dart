import 'package:quiver/collection.dart';

class WebtoonEpisodeModel {
  final String id, title, rating, date, thumb;

  WebtoonEpisodeModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.date,
    required this.thumb,
  });

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'],
        thumb = json['thumb'];

  @override
  String toString() {
    return "WebtoonEpisodeModel{id: $id, title: $title, rating: $rating, date: $date, thumb: $thumb}";
  }
}

class WebtoonEpisodeModelList extends DelegatingList<WebtoonEpisodeModel> {
  final List<WebtoonEpisodeModel> _episodes;

  @override
  List<WebtoonEpisodeModel> get delegate => _episodes;

  WebtoonEpisodeModelList({required List<WebtoonEpisodeModel> episodes})
      : _episodes = episodes;

  WebtoonEpisodeModelList.fromJson(List<dynamic> json)
      : _episodes =
            json.map((item) => WebtoonEpisodeModel.fromJson(item)).toList();

  WebtoonEpisodeModelList.empty() : _episodes = [];

  @override
  String toString() {
    return "WebtoonEpisodeList{episodes: $_episodes}";
  }
}
