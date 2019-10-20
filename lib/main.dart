import 'package:flutter/material.dart';
import 'package:testmovie/service_locator.dart';
import 'package:testmovie/ui/router.dart';
import 'core/services/api/scaffold_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codista Test App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: 'landing',
      onGenerateRoute: Router.generateRoute,
      navigatorKey: locator<ScaffoldService>().navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
