import 'dart:convert';

String allMoviesTicketToJson(AllMoviesTicket data) => json.encode(data.toMap());

class AllMoviesTicket {
  List<Datum> data;

  AllMoviesTicket({
    this.data,
  });
  factory AllMoviesTicket.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    print(list.runtimeType);
    List<Datum> results = list.map((i) => Datum.fromJson(i)).toList();

    return AllMoviesTicket(data: results);
  }

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  int id;
  String movieName;
  String seats;
  String dateTime;
  String friendlyDateTime;
  String createdAt;
  String total;

  Datum({
    this.id,
    this.movieName,
    this.seats,
    this.dateTime,
    this.friendlyDateTime,
    this.createdAt,
    this.total,
  });

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        movieName: json["movie_name"],
        seats: json["seats"],
        dateTime: json["date_time"],
        friendlyDateTime: json["friendly_date_time"],
        createdAt: json["created_at"],
        total: json["total"],
      );
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        movieName: json["movie_name"],
        seats: json["seats"],
        dateTime: json["date_time"],
        friendlyDateTime: json["friendly_date_time"],
        createdAt: json["created_at"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "movie_name": movieName,
        "seats": seats,
        "date_time": dateTime,
        "friendly_date_time": friendlyDateTime,
        "created_at": createdAt,
        "total": total,
      };
}
