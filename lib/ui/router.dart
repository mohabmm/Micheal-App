import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testmovie/ui/views/all_movies.dart';
import 'package:testmovie/ui/views/home_view.dart';
import 'package:testmovie/ui/views/landing_page.dart';
import 'package:testmovie/ui/views/sign_up_form.dart';
import 'package:testmovie/ui/views/signin_form.dart';
import 'package:testmovie/ui/views/single_movie.dart';
import 'package:testmovie/ui/views/ticket_registiration.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'landing':
        return MaterialPageRoute(builder: (_) => LandingPage());

      case 'signupform':
        return MaterialPageRoute(builder: (_) => SignUpForm());

      case 'signinformem':
        return MaterialPageRoute(builder: (_) => SignInFormEmailAndPassword());

      case 'homeview':
        return MaterialPageRoute(builder: (_) => HomeView());

//      case 'createTicket':
//        return MaterialPageRoute(builder: (_) => TicketRegistration());
      case 'allmovie':
        return MaterialPageRoute(builder: (_) => AllMovies());
      case 'singlemovie':
        var id = settings.arguments as int;

        return MaterialPageRoute(builder: (_) => SingleMovie(id));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
