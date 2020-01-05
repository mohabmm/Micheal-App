class MainData {
  String device_id;
  String temperature_c;
  String pulse_rate;
  String blood_oxygen;
  String source_long;
  String destination_long;
  String source_lat;
  String destination_lat;
  String alcohol_detection;
  String picture_pupil_ref;
  String picture_face_ref;
  String record_date;
  String is_available;

  MainData({
    this.device_id,
    this.temperature_c,
    this.pulse_rate,
    this.blood_oxygen,
    this.source_long,
    this.destination_long,
    this.source_lat,
    this.destination_lat,
    this.alcohol_detection,
    this.picture_pupil_ref,
    this.picture_face_ref,
    this.record_date,
    this.is_available,
  });

  factory MainData.fromJson(Map<String, dynamic> json) => MainData(
        device_id: json["device_id"],
        temperature_c: json["temperature_c"],
        pulse_rate: json["pulse_rate"],
        blood_oxygen: json["blood_oxygen"],
        source_long: json["source_long"],
        destination_long: json["destination_long"],
        source_lat: json["source_lat"],
        destination_lat: json["destination_lat"],
        alcohol_detection: json["alcohol_detection"],
        picture_pupil_ref: json["picture_pupil_ref"],
        picture_face_ref: json["picture_face_ref"],
        record_date: json["record_date"],
        is_available: json["is_available"],
      );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["device_id"] = device_id;
    map["temperature_c"] = temperature_c;
    map["pulse_rate"] = pulse_rate;
    map['blood_oxygen'] = blood_oxygen;

    map["source_long"] = source_long;
    map["destination_long"] = destination_long;
    map["source_lat"] = source_lat;
    map["destination_lat"] = destination_lat;

    map["alcohol_detection"] = alcohol_detection;
    map['picture_pupil_ref'] = picture_pupil_ref;

    map["picture_face_ref"] = picture_face_ref;
    map["record_date"] = record_date;
    map["is_available"] = is_available;

    return map;
  }

  Map<String, dynamic> toJson() => {
        "movie_name": device_id,
        "seats": temperature_c,
        "date_time": pulse_rate,
        "id": blood_oxygen,
        "source_long": source_long,
        "destination_long": destination_long,
        "source_lat": source_lat,
        "destination_lat": destination_lat,
        "alcohol_detection": alcohol_detection,
        "picture_pupil_ref": picture_pupil_ref,
        "picture_face_ref": picture_face_ref,
        "record_date": record_date,
        "is_available": is_available,
      };
}
