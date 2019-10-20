import 'dart:convert';

class CreateTicketMovie {
  bool success;
  String message;
  MovieName data;

  CreateTicketMovie({
    this.success,
    this.message,
    this.data,
  });

  factory CreateTicketMovie.fromJson(Map<String, dynamic> json) =>
      CreateTicketMovie(
        success: json["success"],
        message: json["message"],
        data: MovieName.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class MovieName {
  String movieName;
  int seats;
  String dateTime;
  int id;

  MovieName({
    this.movieName,
    this.seats,
    this.dateTime,
    this.id,
  });

  factory MovieName.fromJson(Map<String, dynamic> json) => MovieName(
        movieName: json["movie_name"],
        seats: json["seats"],
        dateTime: json["date_time"],
        id: json["id"],
      );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["movie_name"] = movieName;
    map["seats"] = seats;
    map["date_time"] = dateTime;
    map['id'] = id;
    return map;
  }

  Map<String, dynamic> toJson() => {
        "movie_name": movieName,
        "seats": seats,
        "date_time": dateTime,
        "id": id
      };
}
