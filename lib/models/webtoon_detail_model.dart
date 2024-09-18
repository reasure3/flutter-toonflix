class WebtoonDetailModel {
  final String title, about, genre, age;

  WebtoonDetailModel({
    required this.title,
    required this.about,
    required this.genre,
    required this.age,
  });

  WebtoonDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];

  @override
  String toString() {
    return "WebtoonDetailModel{title: $title, about: $about, genre: $genre, age: $age}";
  }
}
