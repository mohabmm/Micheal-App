import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testmovie/core/models/login.dart';
import 'package:testmovie/core/models/main_data.dart';
import 'package:testmovie/core/models/registiration_data.dart';
import 'package:testmovie/core/services/api/api.dart';
import 'package:testmovie/ui/utilities/show_snack_bar.dart';

class HttpApi implements Api {
  static const apiKey = "f1d1160278adc1fdc71f931acee39cb0";

  StreamController<List<MainData>> mainItemsController = new BehaviorSubject();

  Stream<List<MainData>> get mainDataStream => mainItemsController.stream;

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
  Future<UserSignUpData> signUp(Map body, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    return http
        .post(endpointSignUp, body: body)
        .then((http.Response response) async {
      final int statusCode = response.statusCode;
      print('Response body is : ${response.body}');

      Map responses = json.decode(response.body);

      if (statusCode == 200) {
        showSnackBar('User Registered Successfully');
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
        showSnackBar('User Registered Successfully ');

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

    var posts = List<MainData>();
    final response =
        await http.post(getMainDataEndPoint, body: {'token': userToken});
    final parsed = json.decode(response.body) as Map<String, dynamic>;
    posts.add(MainData.fromJson(parsed));
    mainItemsController.add(posts);

    print("the main data are " + parsed.toString());
    final int statusCode = response.statusCode;
//    posts.add(MainData.fromJson(post));
    return posts;
  }

  addFunction(String s) {}

  @override
  Stream<List<MainData>> getMainDataStream() {
    getMainData();
    return mainDataStream;
  }
}
