import 'package:flutter/src/widgets/framework.dart';
import 'package:testmovie/core/enums/viewstate.dart';
import 'package:testmovie/core/models/login.dart';
import 'package:testmovie/core/models/registiration_data.dart';
import 'package:testmovie/core/services/api/api.dart';
import 'package:testmovie/ui/utilities/show_snack_bar.dart';
import '../../service_locator.dart';
import 'base_model.dart';

class AuthServiceModel extends BaseModel {
  var api = locator<Api>();
  Registration registration;
  Login login;
  UserSignUpData data;

  Future logIn(String email, String password, BuildContext context) async {
    setState(ViewState.Busy);
    var success;

    Login loginData = new Login(
      email: email,
      password: password,
    );

    try {
      success = await api.logIn(loginData.toMap(), context);
      setState(ViewState.Idle);
    } catch (e) {
      showSnackBar("Can't Login" + e.toString());
      success = false;
    }
    return success;
  }

  Future signUp(
      {String deviceId,
      String email,
      String password,
      BuildContext context}) async {
    setState(ViewState.Busy);
    var success;

    UserSignUpData data = new UserSignUpData(
      deviceId: deviceId,
      email: email,
      password: password,
    );

    try {
      success = await api.signUp(data.toMap(), context);
      setState(ViewState.Idle);
    } catch (e) {
      showSnackBar("Can't Register" + e.toString());
      success = false;
    }
  }
}
