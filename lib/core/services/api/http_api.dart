import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testmovie/core/models/all_movies_ticket.dart';
import 'package:testmovie/core/models/single_movie_ticket.dart';
import 'package:testmovie/core/models/tmdb_models.dart';
import 'package:testmovie/core/models/main_data.dart';
import 'package:testmovie/core/models/login.dart';
import 'package:testmovie/core/models/registiration_data.dart';
import 'package:testmovie/core/services/api/api.dart';
import 'package:testmovie/ui/utilities/show_snack_bar.dart';

class HttpApi implements Api {
  static const apiKey = "f1d1160278adc1fdc71f931acee39cb0";

  static const movieEndpoint =
      'https://api.themoviedb.org/3/discover/movie?api_key=' +
          apiKey +
          '&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1';
  var client = new http.Client();

  static const endpointLogin = 'http://54.183.229.104/signin.php';
  static const endpointSignUp = 'http://54.183.229.104/signup.php';
  static const getMainDataEndPoint =
      'http://54.183.229.104/get_last_record.php';
  static const codistaEndpointGetAllMovies =
      'https://tasks.codista.co/api/tickets';
  static const codistaEndpointGetSingleMovie =
      'https://tasks.codista.co/api/tickets/';

  final prefs = SharedPreferences.getInstance();

  @override
  Future<Movie> getMovieData() async {
    var response = await client.get(movieEndpoint);
    return Movie.fromJson(json.decode(response.body));
  }

  @override
  Future<UserSignUpData> signUp(Map body, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    return http
        .post(endpointSignUp, body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      print('Response body is : ${response.body}');

      Map responses = json.decode(response.body);

//      String token = responses["token"];
//      prefs.setString('my_string_key', token);
//      print("the token is " + token);
      if (statusCode == 200) {
        showSnackBar('User Registered Successfully and the token is ');
        Navigator.pushReplacementNamed(context, 'signinformem');
        return;
      } else if (statusCode < 200 || statusCode > 400 || json == null) {
        print("error found");
      }
      throw new Exception("Error while fetching data");
    });
  }

  @override
  Future<Login> logIn(Map body, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    return http
        .post(endpointLogin, body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      print('Response body is : ${response.body}');

      Map responses = json.decode(response.body);

      String token = responses["token"];
      prefs.setString('my_string_key', token);
      print("the token is " + token);
      if (statusCode == 200) {
        showSnackBar('User Registered Successfully and the token is ');

        Navigator.pushReplacementNamed(context, 'homeview');
        return;
      } else if (statusCode < 200 || statusCode > 400 || json == null) {
        print("error found");
      }
      throw new Exception("Error while fetching data");
    });
  }

  @override
  Future<List<MainData>> getMainData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userToken = prefs.getString('my_string_key') ?? '';

    print("the user token inside the get main data is" + userToken);
    //    I'm guessing that you're trying to pass a Map as the body.
//    In this case it would assume
//    that you are actually doing a application/x-www-form-urlencoded.
//    What you need to do is encode the Map as a string and then do what you're doing.

    var posts = List<MainData>();
    final response =
        await http.post(getMainDataEndPoint, body: {'token': userToken});
    final parsed = json.decode(response.body) as Map<String, dynamic>;
    posts.add(MainData.fromJson(parsed));
    print("the main data are " + parsed.toString());
    final int statusCode = response.statusCode;
//    posts.add(MainData.fromJson(post));
    return posts;
  }

  @override
  Future<AllMoviesTicket> getAllMoviesTickets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString('my_string_key') ?? '';
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    var response =
        await client.get(codistaEndpointGetAllMovies, headers: requestHeaders);
    final responseJson = json.decode(response.body);
    print(responseJson);
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      showSnackBar('get all Movies Created Successfully');
    } else if (statusCode < 200 || statusCode > 400 || json == null) {
      showSnackBar('Failed while creating movie');
      throw new Exception("Can't get all movies issue");
    }
    return AllMoviesTicket.fromJson(json.decode(response.body));
  }

  @override
  Future<SingleMovieTicket> getSingleMoviesTicket(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userToken = prefs.getString('my_string_key') ?? '';
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    await Future.delayed(Duration(seconds: 1));

    var response = await client.get(
        codistaEndpointGetSingleMovie + id.toString(),
        headers: requestHeaders);
    final responseJson = json.decode(response.body);
    print(responseJson);
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      showSnackBar('get single Movie is Called Successfully');
    } else if (statusCode < 200 || statusCode > 400 || json == null) {
      showSnackBar('Failed while creating movie');
      throw new Exception("Can't get single movies issue");
    }
    return SingleMovieTicket.fromMap(json.decode(response.body));
  }

  addFunction(String s) {}
}
