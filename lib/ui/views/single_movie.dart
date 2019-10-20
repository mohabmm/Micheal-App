import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testmovie/core/enums/viewstate.dart';
import 'package:testmovie/core/viewmodels/single_movies_view_model.dart';
import 'base_widget.dart';

class SingleMovie extends StatelessWidget {
  final int id;
  SingleMovie(this.id);
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SingleMovieViewModel>(
        model: SingleMovieViewModel(id),
        builder: (
          context,
          model,
          child,
        ) =>
            Scaffold(
                backgroundColor: Theme.of(context).backgroundColor,
                body: _getBodyUi(
                  context,
                  model,
                )));
  }

  Widget _getLoadingUi(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),
        Text('Fetching data ...')
      ],
    ));
  }

  Widget _noDataUi(BuildContext context, SingleMovieViewModel model) {
    return _getCenteredViewMessage(context, "No data available yet", model);
  }

  Widget _errorUi(BuildContext context, SingleMovieViewModel model) {
    return _getCenteredViewMessage(
        context, "Error retrieving your data. Tap to try again", model,
        error: true);
  }

  Widget _getCenteredViewMessage(
      BuildContext context, String message, SingleMovieViewModel model,
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
                        // WWrap in gesture detector and call you refresh future here
                        Icons.refresh,
                        color: Colors.white,
                        size: 45.0,
                      )
                    : Container()
              ],
            )));
  }

  Widget _getBodyUi(BuildContext context, SingleMovieViewModel model) {
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

  Widget _getListUi(SingleMovieViewModel model, BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: new Text('Single Movie')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text("Movie Name:" +
                    " " +
                    model.singleMovieTicket.data.movieName),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text("Number Of Seats:" +
                    " " +
                    model.singleMovieTicket.data.seats),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text("The Movie ID:" +
                    " " +
                    model.singleMovieTicket.data.id.toString()),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text("Created At:" +
                    " " +
                    model.singleMovieTicket.data.createdAt),
              )),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text("Friendly Date Time:" +
                    " " +
                    model.singleMovieTicket.data.friendlyDateTime),
              )),
            ],
          ),
        ));
  }
}
