class MainData {
  String device_id;
  String temperature_c;
  String pulse_rate;
  String blood_oxygen;
  String location_long;
  String location_lat;
  String alcohol_detection;
  String picture_ref;
  String picture_description;
  String record_date;
  String is_available;

  MainData({
    this.device_id,
    this.temperature_c,
    this.pulse_rate,
    this.blood_oxygen,
    this.location_long,
    this.location_lat,
    this.alcohol_detection,
    this.picture_ref,
    this.picture_description,
    this.record_date,
    this.is_available,
  });

  factory MainData.fromJson(Map<String, dynamic> json) => MainData(
        device_id: json["device_id"],
        temperature_c: json["temperature_c"],
        pulse_rate: json["pulse_rate"],
        blood_oxygen: json["blood_oxygen"],
        location_long: json["location_long"],
        location_lat: json["location_lat"],
        alcohol_detection: json["alcohol_detection"],
        picture_ref: json["picture_ref"],
        picture_description: json["picture_description"],
        record_date: json["record_date"],
        is_available: json["is_available"],
      );

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["device_id"] = device_id;
    map["temperature_c"] = temperature_c;
    map["pulse_rate"] = pulse_rate;
    map['blood_oxygen'] = blood_oxygen;

    map["location_long"] = location_long;
    map["location_lat"] = location_lat;
    map["alcohol_detection"] = alcohol_detection;
    map['picture_ref'] = picture_ref;

    map["picture_description"] = picture_description;
    map["record_date"] = record_date;
    map["is_available"] = is_available;

    return map;
  }

  Map<String, dynamic> toJson() => {
        "movie_name": device_id,
        "seats": temperature_c,
        "date_time": pulse_rate,
        "id": blood_oxygen,
        "location_long": location_long,
        "location_lat": location_lat,
        "alcohol_detection": alcohol_detection,
        "picture_ref": picture_ref,
        "picture_description": picture_description,
        "record_date": record_date,
        "is_available": is_available,
      };
}
