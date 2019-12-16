import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testmovie/core/models/all_movies_ticket.dart';
import 'package:testmovie/core/models/tmdb_models.dart';
import 'package:testmovie/core/models/main_data.dart';
import 'package:testmovie/core/services/api/api.dart';
import 'package:testmovie/ui/utilities/show_snack_bar.dart';
import '../../service_locator.dart';
import '../enums/viewstate.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  HomeViewModel() {
    getMovies();
  }

  var api = locator<Api>();
  List<MainData> posts;
  SharedPreferences sharedPreferences;

  Future getMovies() async {
    setState(ViewState.Busy); // If null indicate we're still fetching
    posts = await api.getMainData();
    setState(ViewState.DataFetched);
  }

  signOut(context) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushNamed(context, 'landing');
  }
//
//  Future createMovieTicket(
//    BuildContext context, {
//    userName,
//    seats,
//    dateTime,
//  }) async {
//    MainData data = new MainData(
//      device_id: userName,
//      temperature_c: seats,
//      pulse_rate: dateTime,
//    );
//
//    var success;
//    try {
//      success = await api.getMainData();
//    } catch (e) {
//      showSnackBar("Can't Create Movie Issue" + e.toString());
//      success = false;
//    }
//  }
}
