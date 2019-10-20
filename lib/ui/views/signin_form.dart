import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testmovie/core/viewmodels/authntication_model.dart';
import 'package:testmovie/ui/utilities/validator.dart';
import 'package:testmovie/ui/widgets/form_input.dart';
import 'base_widget.dart';

class SignInFormEmailAndPassword extends StatefulWidget {
  final VoidCallback onSignedIn;

  const SignInFormEmailAndPassword({Key key, this.onSignedIn})
      : super(key: key);

  @override
  _State createState() => new _State();
}

class _State extends State<SignInFormEmailAndPassword> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();
  String mail;
  String password;

  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();

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
                title: new Text('Sign In'),
              ),
              body: Form(
                key: _formKeys,
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
                          _formKeys.currentState.save();
                          if (!_formKeys.currentState.validate()) return;

                          var loginSuccess = await model.logIn(
                              emailController.text,
                              passwordController.text,
                              context);
                        },
                        child: Text(
                          "Login ",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
