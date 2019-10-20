import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testmovie/core/models/all_movies_ticket.dart';
import 'package:testmovie/core/models/single_movie_ticket.dart';
import 'package:testmovie/core/models/tmdb_models.dart';
import 'package:testmovie/core/models/create_ticket_movie.dart';
import 'package:testmovie/core/services/api/api.dart';
import 'package:testmovie/ui/utilities/show_snack_bar.dart';
import '../../service_locator.dart';
import '../enums/viewstate.dart';
import 'base_model.dart';

class SingleMovieViewModel extends BaseModel {
  final int id;
  SingleMovieViewModel(this.id) {
    singleMovieTicketFunction(id);
  }

  var api = locator<Api>();
  SingleMovieTicket singleMovieTicket;

  Future singleMovieTicketFunction(id) async {
    try {
      setState(ViewState.Busy);
      singleMovieTicket = await api.getSingleMoviesTicket(id);
      if (singleMovieTicket.data.movieName == null) {
        setState(ViewState.NoDataAvailable);
      } else
        setState(ViewState.DataFetched);
    } catch (e) {
      showSnackBar("Can't Get single Movies issue" + e.toString());
      print("the single movie error is " + e.toString());
      setState(ViewState.Error);
    }
  }
}
