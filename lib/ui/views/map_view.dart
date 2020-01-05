import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:testmovie/core/viewmodels/home_view_model.dart';

import 'base_widget.dart';

class MapViewScreen extends StatelessWidget {
  String lat;
  String long;
  MapViewScreen(this.lat, this.long);
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
        model: HomeViewModel(),
        onModelReady: (model) =>
            model.getHomeData("AIzaSyAvj5r2iScc7QEJLr3y1gIRLllMXgvsUdk"),
        builder: (
          context,
          model,
          child,
        ) =>
            Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: _getBodyUi(context, model, lat, long)));
  }

  _getBodyUi(
      BuildContext context, HomeViewModel model, String lat, String long) {
    LatLng _mapInitLocation = LatLng(double.parse(lat), double.parse(long));
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GoogleMap(
          onMapCreated: model.onMapCreated,
          tiltGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _mapInitLocation,
            zoom: 12,
          ),
          compassEnabled: true,

          myLocationEnabled: true,
//                            tiltGesturesEnabled: true,
//                          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          markers: Set<Marker>.of(model.markers.values),
          polylines: Set<Polyline>.of(model.polylines.values),
        ),
      ),
    );
  }
}
