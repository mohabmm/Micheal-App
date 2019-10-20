import 'dart:convert';

class Movie {
  List<Result> results;

  Movie({
    this.results,
  });

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    print(list.runtimeType);
    List<Result> results = list.map((i) => Result.fromJson(i)).toList();

    return Movie(results: results);
  }

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  String title;
  double voteAverage;
  String overview;
  DateTime releaseDate;

  Result({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
        video: json["video"] == null ? null : json["video"],
        posterPath: json["poster_path"] == null
            ? null
            : "http://image.tmdb.org/t/p/w185" + json["poster_path"],
        id: json["id"] == null ? null : json["id"],
        adult: json["adult"] == null ? null : json["adult"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        originalLanguage: json["original_language"] == null
            ? null
            : json["original_language"],
        originalTitle:
            json["original_title"] == null ? null : json["original_title"],
        title: json["title"] == null ? null : json["title"],
        voteAverage: json["vote_average"] == null
            ? null
            : json["vote_average"].toDouble(),
        overview: json["overview"] == null ? null : json["overview"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
      );

  Map<String, dynamic> toJson() => {
        "popularity": popularity == null ? null : popularity,
        "vote_count": voteCount == null ? null : voteCount,
        "video": video == null ? null : video,
        "poster_path": posterPath == null ? null : posterPath,
        "id": id == null ? null : id,
        "adult": adult == null ? null : adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_title": originalTitle == null ? null : originalTitle,
        "title": title == null ? null : title,
        "vote_average": voteAverage == null ? null : voteAverage,
        "overview": overview == null ? null : overview,
        "release_date": releaseDate == null
            ? null
            : "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
      };
}
