import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testmovie/core/enums/viewstate.dart';
import 'package:testmovie/core/viewmodels/home_view_model.dart';
import 'package:testmovie/ui/utilities/validator.dart';
import 'package:testmovie/ui/widgets/form_input.dart';
import 'base_widget.dart';

class TicketRegistration extends StatefulWidget {
  @override
  _TicketRegistrationState createState() => _TicketRegistrationState();
}

class _TicketRegistrationState extends State<TicketRegistration> {
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  TextEditingController movieNameController = new TextEditingController();
  TextEditingController numberOfSeatsController = new TextEditingController();
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String time;

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
                key: _scaffoldstate,
                body: _getListUi(context, _formKey, model, movieNameController,
                    numberOfSeatsController)));
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
                        // WWrap in gesture detector and call you refresh future here
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
        return Center(
          child: _getListUi(
            context,
            _formKey,
            model,
            movieNameController,
            numberOfSeatsController,
          ),
        );
    }
  }

  Widget _getListUi(
      BuildContext context,
      GlobalKey<FormState> formKey,
      HomeViewModel model,
      TextEditingController movieNameController,
      TextEditingController numberOfSeatsController) {
    return Scaffold(
      appBar: AppBar(title: new Text('Create Ticket')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: new ListView(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: FormInput(
                    validator: (value) =>
                        Validators(name: 'Movie Name', value: value).compose([
                      Validators.required,
                    ]),
                    controller: movieNameController,
                    icon: FontAwesomeIcons.expand,
                    hintText: "movie Name",
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                FormInput(
                  validator: (value) =>
                      Validators(name: 'Number Of Seats ', value: value)
                          .compose([
                    Validators.required,
                  ]),
                  controller: numberOfSeatsController,
                  icon: FontAwesomeIcons.school,
                  hintText: "Number Of Seats",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 10.0,
                ),
                FlatButton(
                    onPressed: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onChanged: (date) {
                        setState(() {
                          time = date.year.toString() +
                              "-" +
                              date.month.toString() +
                              "-" +
                              date.day.toString() +
                              " " +
                              date.hour.toString() +
                              ":" +
                              date.minute.toString() +
                              ":" +
                              date.second.toString();
                        });

                        print("The real time when changing is " + time);
                      }, onConfirm: (date) {
                        setState(() {
                          time = date.year.toString() +
                              "-" +
                              date.month.toString() +
                              "-" +
                              date.day.toString() +
                              " " +
                              date.hour.toString() +
                              ":" +
                              "00" +
                              ":" +
                              "00";
                        });

                        print("The real time when confirming is " + time);
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Text(
                      'Pick The Movie Date',
                    )),
                SizedBox(
                  height: 10.0,
                ),
                ButtonTheme(
                  minWidth: 4.0,
                  child: new RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    onPressed: () async {
                      formKey.currentState.save();
                      if (!formKey.currentState.validate()) return;

                      print("the current sending time is " + time);
                      await model.createMovieTicket(
                        context,
                        userName: movieNameController.text,
                        seats: int.parse(numberOfSeatsController.text),
                        dateTime: time,
                      );
                    },
                    child: Text(
                      "Create Ticket",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
