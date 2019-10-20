import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testmovie/core/models/all_movies_ticket.dart';
import 'package:testmovie/core/models/single_movie_ticket.dart';
import 'package:testmovie/core/models/tmdb_models.dart';
import 'package:testmovie/core/models/create_ticket_movie.dart';
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

  static const codistaEndpointLogin = 'https://tasks.codista.co/api/login';
  static const codistaEndpointSignUp = 'https://tasks.codista.co/api/register';
  static const codistaEndpointCreateTicket =
      'https://tasks.codista.co/api/tickets';
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
        .post(codistaEndpointSignUp, body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      print('Response body is : ${response.body}');

      Map responses = json.decode(response.body);

      String token = responses["data"]["token"];
      prefs.setString('my_string_key', token);
      print("the token is " + token);
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

//    final userToken = prefs.getString('my_string_key') ?? '';
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer'
    };
    var myData = json.encode(body);

    return http
        .post(codistaEndpointLogin, body: myData, headers: requestHeaders)
        .then((http.Response response) {
      print("the rssponse body of login is " + response.body);
      final int statusCode = response.statusCode;
      Map responses = json.decode(response.body);

      String token = responses["data"]["token"];
      prefs.setString('my_string_key', token);

      print("the status code during login is " + statusCode.toString());
      if (statusCode == 200) {
        showSnackBar('User Signed In  Successfully');
        print("we should login");

        Navigator.pushReplacementNamed(context, 'homeview');
      } else if (statusCode < 200 || statusCode > 400 || json == null) {
        print("error while retrieving data");

        throw new Exception("Error while loging in");
      }

      return Login.fromJson(json.decode(response.body));
    });
  }

  @override
  Future<CreateTicketMovie> createMovieTicket(
      Map body, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userToken = prefs.getString('my_string_key') ?? '';
    String token =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjUwY2Y4MWM2OTVlYTIzNTNmNzU5YjQ3MjEzOGY1YjUwOTgzNmFiMjVjNTZlMGY5ODRhZThkNDc5ZDlkNWE5MTVlMGVjNjg0NDliYmE5NjM1In0.eyJhdWQiOiIxIiwianRpIjoiNTBjZjgxYzY5NWVhMjM1M2Y3NTliNDcyMTM4ZjViNTA5ODM2YWIyNWM1NmUwZjk4NGFlOGQ0NzlkOWQ1YTkxNWUwZWM2ODQ0OWJiYTk2MzUiLCJpYXQiOjE1NzEzNjQ3NjEsIm5iZiI6MTU3MTM2NDc2MSwiZXhwIjoxNjAyOTg3MTYxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Ld4dVXtr1fPsyvYczZFnZVuxOUhhIxBR10nVT82NHD08-41FG2HwQ3bL2jsJzde8P-7k592jV2QBh4PrRx1MKTTw_Nm39GsKxZHk8oqdAwNgFYCckX6n9xaXJLFBRBSUVZETV_9SiaxJk2_1xvh-dN4ZKR9wwxAGghv1d7XzgXBDnYYo7qYUY38QJMozIjfpgjHUCUcgypMwHH2hDJP2dmPGwK05eZsvxzfMO9UzRWXbVmSybDbpOgcrkKE8As1PCy7cbVDP3E1L2eFmr45Ncqn2pOrt-cnVRJwJ7ZkqE8GqIB-rnqyJu3SMwjOwzBn8_aR16LXVd-xX4kDnRw-igHM6SQYNIzqyJwlX3vABgoepvSuSJC9GideyZhYLS_FNEXRFlAZcUaWiaKNfUaJsEr3Bn3awXJlOSXt1F9i4rrNmo0cekXYMk92QqNDQhdDitYx_Osx1Mrc3wShpiDcX3p-TF_bqPvt3EneC2eFPAEHNQ1arFHzCg2eB-CBjFvgEAhlTm5cqLehqBr0acGz60hviyBoO4DkugnmW3wYta2HN4Hy_xqVmCEHIfwbdqz2_43PC2n7UwwPIfJ1VlHfW4xwYczfkrkpdpI7_AkngeWF_0MlsEG_I7PBLHGcpLGY_gNAlIOnRgKGzr0jFdhggDZvlD56Luz9rIX6BVd0CLbM";

    //    I'm guessing that you're trying to pass a Map as the body.
//    In this case it would assume
//    that you are actually doing a application/x-www-form-urlencoded.
//    What you need to do is encode the Map as a string and then do what you're doing.

    var myData = json.encode(body);
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    final response = await http.post(codistaEndpointCreateTicket,
        body: myData, headers: requestHeaders);
    final responseJson = json.decode(response.body);
    print(responseJson);
    final int statusCode = response.statusCode;

    if (statusCode == 200) {
      showSnackBar('Movie Created Successfully');
    } else if (statusCode < 200 || statusCode > 400 || json == null) {
      showSnackBar('Failed while creating movie');
      throw new Exception("Error while fetching data");
    }
    return CreateTicketMovie.fromJson(json.decode(response.body));
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
}
