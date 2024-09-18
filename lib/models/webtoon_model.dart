import 'package:quiver/collection.dart';

class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel({
    required this.title,
    required this.thumb,
    required this.id,
  });

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];

  @override
  String toString() {
    return "WebtoonModel{title: $title, id: $id, thumb: $thumb}";
  }

  String infoString() {
    return "[$id] $title";
  }

  String infoStringDetail() {
    return "[$id] $title (thumbUrl: $thumb})";
  }
}

class WebtoonModelList extends DelegatingList<WebtoonModel> {
  final List<WebtoonModel> _webtoons;

  @override
  List<WebtoonModel> get delegate => _webtoons;

  WebtoonModelList({required List<WebtoonModel> webtoons})
      : _webtoons = webtoons;

  WebtoonModelList.fromJson(List<dynamic> json)
      : _webtoons = json.map((item) => WebtoonModel.fromJson(item)).toList();

  WebtoonModelList.empty() : _webtoons = [];

  @override
  String toString() {
    return "WebtoonList{webtoons: $_webtoons}";
  }

  String infoString() {
    return "[${_webtoons.map((webtoon) => webtoon.infoString()).join(", ")}]";
  }

  String infoStringDetail() {
    return "[${_webtoons.map((webtoon) => webtoon.infoStringDetail()).join(", ")}]";
  }
}
