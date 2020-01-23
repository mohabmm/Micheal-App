import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testmovie/core/models/main_data.dart';
import 'package:testmovie/core/services/api/api.dart';
import '../../service_locator.dart';
import '../enums/viewstate.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  var api = locator<Api>();
  String tempImage;
  String tempImagePictureFaceRef;
  List<MainData> mainData = new List();
  SharedPreferences sharedPreferences;

  getHomeData(String apiKey) {
    Timer timer;

    timer = Timer.periodic(
        Duration(seconds: 20), (Timer t) => startingData(apiKey));
  }

  signOut(context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushNamed(context, 'landing');
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
    notifyListeners();
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  void _chatChannelViewUpdated(List<MainData> chatChannelViewListData) {}

  getIntialMapCordinates(String source_long, String source_lat,
      String destination_long, String destination_lat, String s) {
    if (source_lat == "SOURCE lattitude") {
//      print("do no thing");
    } else {
      _addMarker(LatLng(double.parse(source_lat), double.parse(source_long)),
          "origin", BitmapDescriptor.defaultMarker);
    }

    /// destination marker
    _addMarker(
        LatLng(double.parse(destination_lat), double.parse(destination_long)),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline(s, source_lat, source_long, destination_lat, destination_long);
  }

  _getPolyline(String s, String source_lat, String_originLongitude,
      String _destLatitude, String _destLongitude) async {
    if (source_lat != "SOURCE lattitude") {
      List<PointLatLng> result =
          await polylinePoints.getRouteBetweenCoordinates(
              s,
              double.parse(source_lat),
              double.parse(String_originLongitude),
              double.parse(_destLatitude),
              double.parse(_destLongitude));
      if (result.isNotEmpty) {
        result.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }
      _addPolyLine();
    } else {
//      print("all is well");
    }
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    notifyListeners();
  }

  startingData(String apiKey) {
    mainData = [];
    api.getMainData().then((onValue) {
      if (onValue == null) {
        setState(ViewState.Error); // If null indicate we're still fetching
      } else if (onValue.length == 0) {
        setState(ViewState.NoDataAvailable);
      } else {
        mainData.addAll(onValue);
        for (int i = 0; i < mainData.length; i++) {
          getIntialMapCordinates(
            mainData[i].source_long,
            mainData[i].source_lat,
            mainData[i].destination_long,
            mainData[i].destination_lat,
            apiKey,
          );
        }
        setState(ViewState.DataFetched);
      }
    });
  }

  checkImages(String ImageToCheck) {
    if (ImageToCheck != null && ImageToCheck != "") {
      tempImage = ImageToCheck;
      notifyListeners();
      return "real";
    } else if (tempImage != null && tempImage != "") {
      return "temp";
    } else {
      return "a7a";
    }
  }

  checkImagesPictureFaceRef(String picture_face_ref) {
    if (picture_face_ref != null && picture_face_ref != "") {
      tempImagePictureFaceRef = picture_face_ref;
      notifyListeners();
      return "realImage";
    } else if (tempImagePictureFaceRef != null &&
        tempImagePictureFaceRef != "") {
      return "tempImage";
    } else {
      return "a7aImage";
    }
  }
}
