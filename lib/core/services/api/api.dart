import 'package:flutter/cupertino.dart';
import 'package:testmovie/core/models/all_movies_ticket.dart';
import 'package:testmovie/core/models/single_movie_ticket.dart';
import 'package:testmovie/core/models/tmdb_models.dart';
import 'package:testmovie/core/models/main_data.dart';
import 'package:testmovie/core/models/login.dart';
import 'package:testmovie/core/models/registiration_data.dart';

abstract class Api {
  Future<Movie> getMovieData();
  Future<Login> logIn(Map body, BuildContext context);
  Future<UserSignUpData> signUp(Map body, BuildContext context);
  Future<List<MainData>> getMainData();
  Future<AllMoviesTicket> getAllMoviesTickets();
  Future<SingleMovieTicket> getSingleMoviesTicket(id);
}
