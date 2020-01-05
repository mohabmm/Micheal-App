import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testmovie/core/viewmodels/authntication_model.dart';

import 'base_widget.dart';

class LandingPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  TextEditingController passwordConfirmationController =
      new TextEditingController();

  GlobalKey<FormState> form = GlobalKey<FormState>();
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AuthServiceModel>(
      model: AuthServiceModel(),
      builder: (
        context,
        model,
        child,
      ) =>
          Scaffold(
        body: _getListUi(context, model),
      ),
    );
  }
}

Widget _getListUi(BuildContext context, AuthServiceModel model) {
  final signUpColor = const Color(0xFF3d3d3d);
  return Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage("assets/images/intro.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: new Padding(
      padding: const EdgeInsets.all(20.00),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new RaisedButton(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.grey,
            child: new Text(
              "Signup",
              style: TextStyle(color: signUpColor),
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'signupform');
            },
          ),
          new RaisedButton(
            key: Key("sparta"),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.red,
            child: new Text(
              "Login",
            ),
            onPressed: () {
              Navigator.pushNamed(context, 'signinformem');
            },
          ),
        ],
      ),
    ),
  );
}
