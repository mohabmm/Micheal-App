import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testmovie/core/models/all_movies_ticket.dart';
import 'package:testmovie/core/models/tmdb_models.dart';
import 'package:testmovie/core/models/create_ticket_movie.dart';
import 'package:testmovie/core/services/api/api.dart';
import 'package:testmovie/ui/utilities/show_snack_bar.dart';
import '../../service_locator.dart';
import '../enums/viewstate.dart';
import 'base_model.dart';

class AllMovieViewModel extends BaseModel {
  AllMovieViewModel() {
    getAllMoviesTicket();
  }

  var api = locator<Api>();
  AllMoviesTicket allMoviesTicketsList;

  Future getAllMoviesTicket() async {
    try {
      setState(ViewState.Busy);
      allMoviesTicketsList = await api.getAllMoviesTickets();
      if (allMoviesTicketsList.data.length == 0) {
        setState(ViewState.NoDataAvailable);
      } else
        setState(ViewState.DataFetched);
    } catch (e) {
      showSnackBar("Can't Get all Movies issue" + e.toString());
      setState(ViewState.Error);
    }
  }
}
