import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testmovie/core/enums/viewstate.dart';
import 'package:testmovie/core/viewmodels/all-movies_view_model.dart';
import 'base_widget.dart';

class AllMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AllMovieViewModel>(
        model: AllMovieViewModel(),
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

  Widget _noDataUi(BuildContext context, AllMovieViewModel model) {
    return _getCenteredViewMessage(context, "No data available yet", model);
  }

  Widget _errorUi(BuildContext context, AllMovieViewModel model) {
    return _getCenteredViewMessage(
        context, "Error retrieving your data. Tap to try again", model,
        error: true);
  }

  Widget _getCenteredViewMessage(
      BuildContext context, String message, AllMovieViewModel model,
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
                GestureDetector(
                  onTap: () {},
                  child: error
                      ? Icon(
                          // WWrap in gesture detector and call you refresh future here
                          Icons.refresh,
                          color: Colors.white,
                          size: 45.0,
                        )
                      : Container(),
                )
              ],
            )));
  }

  Widget _getBodyUi(BuildContext context, AllMovieViewModel model) {
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

  Widget _getListUi(AllMovieViewModel model, BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: new Text('All Movies')),
      body: new ListView.builder(
          itemExtent: 220.0,
          itemCount: model.allMoviesTicketsList.data.length,
          itemBuilder: (BuildContext context, int index) {
            String seats = model.allMoviesTicketsList.data[index].seats;
            String title = model.allMoviesTicketsList.data[index].movieName;
            String dateTime = model.allMoviesTicketsList.data[index].dateTime;
            String friendlyDateTime =
                model.allMoviesTicketsList.data[index].friendlyDateTime;
            int id = model.allMoviesTicketsList.data[index].id;

            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'singlemovie', arguments: id);
              },
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Movie ID:" + " " + id.toString()),
                    )),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Movie Name:" + " " + title),
                    )),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Number Of Seats:" + " " + seats),
                    )),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                          "Friendly Date Time At:" + " " + friendlyDateTime),
                    )),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Date Time:" + " " + dateTime),
                    )),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
