import 'package:flutter/cupertino.dart';
import 'package:testmovie/core/models/login.dart';
import 'package:testmovie/core/models/main_data.dart';
import 'package:testmovie/core/models/registiration_data.dart';
import 'package:testmovie/core/services/api/api.dart';

class FakeApi implements Api {
  UserSignUpData data = UserSignUpData(
    email: 'mohab_31_8@hotmail.com',
    deviceId: 'mohab',
    password: '123456',
  );

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
  Stream<List<MainData>> getMainDataStream() {
    // TODO: implement getMainDataStream
    return null;
  }
}
