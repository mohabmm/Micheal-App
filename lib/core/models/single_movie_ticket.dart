// To parse this JSON data, do
//
//     final singleTicket = singleTicketFromJson(jsonString);

import 'dart:convert';

SingleMovieTicket singleTicketFromJson(String str) =>
    SingleMovieTicket.fromMap(json.decode(str));

String singleTicketToJson(SingleMovieTicket data) => json.encode(data.toMap());

class SingleMovieTicket {
  bool success;
  String message;
  Data data;

  SingleMovieTicket({
    this.success,
    this.message,
    this.data,
  });

  factory SingleMovieTicket.fromMap(Map<String, dynamic> json) =>
      SingleMovieTicket(
        success: json["success"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  int id;
  String movieName;
  String seats;
  String dateTime;
  String friendlyDateTime;
  String createdAt;
  String total;

  Data({
    this.id,
    this.movieName,
    this.seats,
    this.dateTime,
    this.friendlyDateTime,
    this.createdAt,
    this.total,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
