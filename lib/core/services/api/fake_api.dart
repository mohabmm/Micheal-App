import 'package:flutter/cupertino.dart';
import 'package:testmovie/core/models/all_movies_ticket.dart';
import 'package:testmovie/core/models/single_movie_ticket.dart';
import 'package:testmovie/core/models/tmdb_models.dart';
import 'package:testmovie/core/models/main_data.dart';
import 'package:testmovie/core/models/login.dart';
import 'package:testmovie/core/models/registiration_data.dart';
import 'package:testmovie/core/services/api/api.dart';

class FakeApi implements Api {
  List<Result> fakeMovieResults = [
    Result(
      voteCount: 3,
      adult: false,
      overview: "ssdsd",
      backdropPath: "ssdsa",
      id: 3,
      posterPath:
          'http://image.tmdb.org/t/p/w185//nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg',
      title: "Fake movie number one ",
    ),
    Result(
      voteCount: 3,
      adult: false,
      overview: "ssdsd",
      backdropPath: "ssdsa",
      id: 3,
      posterPath:
          'http://image.tmdb.org/t/p/w185//nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg',
      title: "Fake movie number two",
    ),
    Result(
      voteCount: 3,
      adult: false,
      overview: "ssdsd",
      backdropPath: "ssdsa",
      id: 3,
      posterPath:
          'http://image.tmdb.org/t/p/w185//nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg',
      title: "Fake movie number 3",
    ),
    Result(
      voteCount: 3,
      adult: false,
      overview: "ssdsd",
      backdropPath: "ssdsa",
      id: 3,
      posterPath:
          'http://image.tmdb.org/t/p/w185//nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg',
      title: "Fake movie number 4 ",
    ),
  ];

  UserSignUpData data = UserSignUpData(
    email: 'mohab_31_8@hotmail.com',
    deviceId: 'mohab',
    password: '123456',
  );

  @override
  Future<Movie> getMovieData() async {
    await Future.delayed(Duration(seconds: 1));

    return Movie(results: fakeMovieResults);
  }

  @override
  Future<UserSignUpData> signUp(Map body, BuildContext context) async {
    await Future.delayed(Duration(seconds: 1));

    if (data.deviceId == "mohab") {
      print("great");
    } else if (data.email == "mohab.magdy1@msa.edu.eg") {
      print("fake email");
    } else {
      print("signed up succefully");
    }
    return UserSignUpData(
      deviceId: "",
      email: '',
      password: '',
    );
  }

  @override
  Future<Login> logIn(Map body, BuildContext context) {
    // TODO: implement logIn
    return null;
  }

  @override
  Future<List<MainData>> getMainData() {
    // TODO: implement createMovie
    return null;
  }

  @override
  Future<AllMoviesTicket> getAllMoviesTickets() {
    // TODO: implement getAllMovies
    return null;
  }

  @override
  Future<SingleMovieTicket> getSingleMoviesTicket(id) {
    // TODO: implement getSingleMoviesTicket
    return null;
  }
}
