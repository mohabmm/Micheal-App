import 'package:flutter/cupertino.dart';
import 'package:testmovie/core/models/login.dart';
import 'package:testmovie/core/models/main_data.dart';
import 'package:testmovie/core/models/registiration_data.dart';

abstract class Api {
  Future<Login> logIn(Map body, BuildContext context);

  Future<UserSignUpData> signUp(Map body, BuildContext context);

  Future<List<MainData>> getMainData();

  Stream<List<MainData>> getMainDataStream();
}
