import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testmovie/core/viewmodels/authntication_model.dart';
import 'package:testmovie/ui/utilities/validator.dart';
import 'package:testmovie/ui/widgets/form_input.dart';
import 'base_widget.dart';

class SignUpForm extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class _State extends State<SignUpForm> {
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  GlobalKey<FormState> form = GlobalKey<FormState>();
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController deviceIdController = new TextEditingController();

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
                key: _scaffoldstate,
                appBar: new AppBar(
                  title: new Text('Sign Up'),
                ),
                body: _getListUi(model, _formKey, emailController,
                    passwordController, deviceIdController, context)));
  }
}

Widget _getListUi(
    AuthServiceModel model,
    GlobalKey<FormState> formKey,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController deviceIdController,
    BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(20.0),
    child: Form(
      key: formKey,
      child: new ListView(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          FormInput(
            validator: (value) =>
                Validators(name: 'Email Address', value: value)
                    .compose([Validators.required, Validators.email]),
            controller: emailController,
            icon: FontAwesomeIcons.envelope,
            hintText: "Email Address",
            keyboardType: TextInputType.emailAddress,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: FormInput(
              validator: (value) =>
                  Validators(name: 'Password', value: value).compose([
                Validators.required,
              ]),
              controller: passwordController,
              icon: FontAwesomeIcons.expand,
              hintText: "Password",
              obscureText: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: FormInput(
              validator: (value) =>
                  Validators(name: 'device id', value: value).compose([
                Validators.required,
              ]),
              controller: deviceIdController,
              icon: FontAwesomeIcons.expand,
              hintText: "device id",
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          ButtonTheme(
            minWidth: 4.0,
            child: new RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              onPressed: () async {
                formKey.currentState.save();
                if (!formKey.currentState.validate()) return;
                var loginSuccess = await model.signUp(
                  email: emailController.text,
                  context: context,
                  password: passwordController.text,
                  deviceId: deviceIdController.text,
                );
              },
              child: Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
