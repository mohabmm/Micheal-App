import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testmovie/core/enums/viewstate.dart';
import 'package:testmovie/core/viewmodels/home_view_model.dart';
import 'package:testmovie/ui/widgets/top_part.dart';
import 'base_widget.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
        model: HomeViewModel(),
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
    return Scaffold(
      appBar: AppBar(title: new Text('Driver Data')),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            child:

//            new Text("a7a"),
                new ListView.builder(
                    itemExtent: 120.0,
                    scrollDirection: Axis.vertical,
                    itemCount: model.posts.length,
                    itemBuilder: (BuildContext context, int index) {
                      String deviceId = model.posts[index].device_id;
                      String alcoholDetection =
                          model.posts[index].alcohol_detection;
                      String bloodOxygen = model.posts[index].blood_oxygen;
                      String latitude = model.posts[index].location_lat;
                      String longitude = model.posts[index].location_long;
                      String imageDescription =
                          model.posts[index].picture_description;
                      String pictureRef = model.posts[index].picture_ref;
                      String pulseRate = model.posts[index].pulse_rate;
                      String temperature = model.posts[index].temperature_c;

                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 12.0),
                        child: Container(
                          height: 400.0,
                          width: 135.0,
                          child: Column(
                            children: <Widget>[
                              new Text(deviceId),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, left: 8.0, right: 8.0),
                                child: Text(bloodOxygen,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "SF-Pro-Display-Bold")),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
