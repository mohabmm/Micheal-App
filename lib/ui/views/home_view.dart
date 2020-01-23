import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testmovie/core/enums/viewstate.dart';
import 'package:testmovie/core/viewmodels/home_view_model.dart';
import 'package:testmovie/ui/utilities/show_snack_bar.dart';
import 'package:testmovie/ui/views/map_view.dart';
import 'package:testmovie/ui/widgets/login_button.dart';
import 'base_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
        model: HomeViewModel(),
        onModelReady: (model) =>
            model.getHomeData(""),
        builder: (
          context,
          model,
          child,
        ) =>
            Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: _getBodyUi(context, model)));
  }

  Widget _getLoadingUi(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
        Text('Fetching data ...')
      ],
    ));
  }

  Widget _noDataUi(BuildContext context, HomeViewModel model) {
    return _getCenteredViewMessage(context, "No data available yet", model);
  }

  Widget _errorUi(BuildContext context, HomeViewModel model) {
    return _getCenteredViewMessage(
        context, "Error retrieving your data. Tap to try again", model,
        error: true);
  }

  Widget _getCenteredViewMessage(
      BuildContext context, String message, HomeViewModel model,
      {bool error = false}) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                error
                    ? Icon(
                        // Wrap in gesture detector and call you refresh future here
                        Icons.refresh,
                        color: Colors.white,
                        size: 45.0,
                      )
                    : Container()
              ],
            )));
  }

  Widget _getBodyUi(BuildContext context, HomeViewModel model) {
    print("get body UI OF THE HOME VIEW ");
    switch (model.state) {
      case ViewState.Busy:
        return _getLoadingUi(context);
      case ViewState.NoDataAvailable:
        return _noDataUi(context, model);
      case ViewState.Error:
        return _errorUi(context, model);
      case ViewState.DataFetched:
      default:
        return _getListUi(model, context);
    }
  }

  Widget _getListUi(HomeViewModel model, BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(title: new Text('Driver Data')),
        body: Center(
          child: new ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: model.mainData.length,
              itemBuilder: (BuildContext context, int index) {
                String deviceId = model.mainData[index].device_id;
                String alcoholDetection =
                    model.mainData[index].alcohol_detection;
                String bloodOxygen = model.mainData[index].blood_oxygen;
                String sourceLong = model.mainData[index].source_long;
                String sourceLat = model.mainData[index].source_lat;
                String destinationLong = model.mainData[index].destination_long;
                String destinationLat = model.mainData[index].destination_lat;
                String picture_pupil_ref =
                    model.mainData[index].picture_pupil_ref;
                String picture_face_ref =
                    model.mainData[index].picture_face_ref;
                String pulseRate = model.mainData[index].pulse_rate;
                String temperature = model.mainData[index].temperature_c;

                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new LoginButton(
                          text: "Press To Track The Driver Location",
                          color: Colors.grey,
                          loginMethod: () {
                            (sourceLat == "SOURCE lattitude")
                                ? showSnackBar(
                                    "Location is not available waiting for the service",
                                  )
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MapViewScreen(sourceLat, sourceLong),
                                    ),
                                  );
                          },
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              "Temperature" + ":" + temperature,
                            ),
                            SizedBox(width: 7),
                            new Text("Device Id" + ":" + deviceId),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                                "Alcohol Detection" + ":" + alcoholDetection),
                            SizedBox(width: 7),
                            new Text("Pulse Rate" + ":" + pulseRate),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        new Text("Blood Oxygen" + ":" + bloodOxygen),
                        new SizedBox(
                          height: 20,
                        ),
                        (model.checkImages(picture_pupil_ref) == "real")
                            ? new Image.network(picture_pupil_ref)
                            : (model.checkImages(picture_pupil_ref) == "temp")
                                ? new Image.network(model.tempImage)
                                : new Text("No eye detected"),
                        new SizedBox(
                          height: 10,
                        ),
                        (picture_pupil_ref != null && picture_pupil_ref != '')
                            ? new Text("Eye Detection")
                            : new Container(
                                height: 1,
                              ),
                        (model.checkImagesPictureFaceRef(picture_face_ref) ==
                                "realImage")
                            ? new Image.network(picture_face_ref)
                            : (model.checkImages(picture_face_ref) ==
                                    "tempImage")
                                ? new Image.network(
                                    model.tempImagePictureFaceRef)
                                : new Text("No face deteted"),
                        new SizedBox(
                          height: 10,
                        ),
                        (picture_face_ref != null && picture_face_ref != '')
                            ? new Text("Face Detection")
                            : new Container(
                                height: 1,
                              ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
